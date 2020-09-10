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
    if(doc.data['timetableLastUpdatedAt'] == null)
      await createTodaysTimetable();
    else {
      DateTime lastUpdate = DateFormat('kk:mm, dd-MM-yyyy').parse(
          doc.data['timetableLastUpdatedAt']);
      QuerySnapshot currTtDocs = await _firestore.collection('seniors')
          .document(userInfo.uid).collection('todaysTimetable')
          .getDocuments();
      if (_dateTime.day != lastUpdate.day) {
        if (currTtDocs.documents.length == 0)
          await createTodaysTimetable();
        else {
          await makeReport(lastUpdate);
          await clearTimetable();
          await createTodaysTimetable();
        }
      }
    }
//    else {
//      DocumentSnapshot ttDoc = await _firestore.collection('timetable').document('example').collection('timetable').document('${_dateTime.weekday}').get();
//      if( ttDoc.exists) {
//        DateTime ttLastUpdate = DateFormat('kk:mm, dd-MM-yyyy').parse(
//            ttDoc.data['timestamp']);
//        if (lastUpdate.isBefore(ttLastUpdate))
//          await updateTodaysTimetable();
//      }
//    }
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
    //TODO: Do in Junior app itself, too inefficient to do in the Senior app
  }

  Future<void> makeReport(DateTime date) async {
    QuerySnapshot itemDocs = await _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').getDocuments();
    int count = 0;
    Future.forEach(itemDocs.documents, (element) async {
      DocumentSnapshot itemDoc = await _firestore.collection('seniors').document(user.uid).collection('timetableReports').document(element.documentID).get();
      if(element.data['completed'])
        count++;
      if(itemDoc.exists) {
        List<dynamic> currRecords = itemDoc.data['records'] ?? [];
        currRecords.add({'date': '${DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(Duration(days: 1)))}', 'status': element.data['completed']});
        await _firestore.collection('seniors').document(user.uid).collection('timetableReports')
            .document(element.documentID).updateData({'records': currRecords});
      }

      else {
        List<dynamic> currRecords = [];
        currRecords.add({'date': '${DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(Duration(days: 1)))}', 'status': element.data['completed']});
        await _firestore.collection('seniors').document(user.uid).collection('timetableReports')
            .document(element.documentID).setData({'records': currRecords});
      }
    });
    DocumentSnapshot countDoc = await _firestore.collection('seniors').document(user.uid).collection('timetableReports').document('dailyCounts').get();
    if(countDoc.exists && countDoc.data['counts'] != null) {
      Map<String, int> counts = Map<String, int>.from(countDoc.data['counts']);
      int currCount =counts['${DateFormat('dd-MM-yyyy').format(date)}'] ?? 0;
      counts['${DateFormat('dd-MM-yyyy').format(date)}'] = currCount + count;
      await _firestore.collection('seniors').document(user.uid).collection('timetableReports').document('dailyCounts').setData({'counts': counts});
    }
    else
      await _firestore.collection('seniors').document(user.uid).collection('timetableReports').document('dailyCounts').setData({'counts': {'${DateFormat('dd-MM-yyyy').format(date)}': count}});
    print(date);
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
