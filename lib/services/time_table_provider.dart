import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/time_table_item.dart';
import 'package:ec_senior/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimeTableProvider extends ChangeNotifier{
  static User userInfo;
  final Firestore _firestore = Firestore.instance;
  static List<TimeTableItem> _timetableList = [];
  static bool _lodaing;
  static DateTime _dateTime;

  TimeTableProvider.toLoad(User u) {
    userInfo = u;
    _lodaing = true;
    _dateTime = DateTime.now();
    getTimeTable();
  }

  TimeTableProvider();

  List<TimeTableItem> get timetable => _timetableList;
  bool get state => _lodaing;

  set user(User u) {
    userInfo = u;
  }

  User get user => userInfo;

  Future<void> getTimeTable() async {
    if( userInfo == null || userInfo.timetableId == null) {
      _lodaing = false;
      return;
    }
    DocumentSnapshot doc = await _firestore.collection('seniors').document(userInfo.uid).get();
    _lodaing = true;
    DateTime lastUpdate = DateFormat('kk:mm, dd-MM-yyyy').parse(doc.data['timetableLastUpdatedAt']);
    QuerySnapshot currTtDocs = await _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').getDocuments();
    if( _dateTime.day != lastUpdate.day ) {
      if( currTtDocs.documents.length == 0 )
        await createTodaysTimetable();
      else {
        await makeReport();
        await clearTimetable();
        await createTodaysTimetable();
      }
    }
    else {
      DocumentSnapshot ttDoc = await _firestore.collection('timetable').document('example').collection('timetable').document('${_dateTime.weekday}').get();
      DateTime ttLastUpdate = DateFormat('kk:mm, dd-MM-yyyy').parse(ttDoc.data['timestamp']);
      if( lastUpdate.isBefore(ttLastUpdate) )
        await updateTodaysTimetable();
    }
    QuerySnapshot newTimetable = await _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').getDocuments();
//    print(newTimetable.documents.length == currTtDocs.documents.length);
    _timetableList = [];
    newTimetable.documents.forEach((element) {
      _timetableList.add(TimeTableItem(
        title: element.documentID,
        time: element.data['time'],
        otherDays: element.data['otherDays'],
        completed: element.data['completed'],
      ));
    });
    _lodaing = false;
    notifyListeners();
  }

  Future<void> createTodaysTimetable() async {
    DocumentSnapshot ttDoc = await _firestore.collection('timetable').document('example').collection('timetable').document('${_dateTime.weekday}').get();
    if( ttDoc.exists) {
      List<dynamic> tasks = ttDoc.data['tasks'];
      tasks.forEach((element) {
        _timetableList.add(
            TimeTableItem(title: element['title'], time: element['time'], otherDays: element['otherDays'], completed: false));
        _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').document(element['title']).setData({
          'time': element['time'],
          'otherDays': element['otherDays'],
          'completed': false,
        });
      });
    }
    await _firestore.collection('seniors').document(userInfo.uid).updateData({'timetableLastUpdatedAt': DateFormat('kk:mm, dd-MM-yyyy').format(DateTime.now())});
  }

  Future<void> updateTodaysTimetable() async {
    //TODO: Read new timetable
    //TODO: Check if already in current timetable
    //TODO: Add if not
    await _firestore.collection('seniors').document(userInfo.uid).updateData({'timetableLastUpdatedAt': DateFormat('kk:mm, dd-MM-yyyy').format(DateTime.now())});
  }

  Future<void> makeReport() async {
    List<dynamic> records = [];
    QuerySnapshot tasks = await _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').getDocuments();
    tasks.documents.forEach((element) {
      records.add({
        'title': element.documentID,
        'time': element.data['time'],
        'completed': element.data['completed'],
      });
    });
    await _firestore.collection('seniors').document(userInfo.uid).collection('timetableReports')
        .document('${DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(Duration(days: 1)))}').setData({
      'records': records,
    });
  }

  Future<void> clearTimetable() async {
    QuerySnapshot currTtDocs = await _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').getDocuments();
    currTtDocs.documents.forEach((element) async {
      await _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').document(element.documentID).delete();
    });
    //TODO: Use batch commands
  }

  Future<void> toggleStatus(int index) async {
    TimeTableItem element = _timetableList[index];
    await _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').document(element.title).updateData({
      'completed': !element.completed,
    });
    _timetableList[index] = TimeTableItem(
      title: element.title,
      time: element.time,
      completed: !element.completed,
      otherDays: element.otherDays,
    );
    notifyListeners();
  }
}
