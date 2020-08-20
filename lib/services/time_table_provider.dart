import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/time_table_item.dart';
import 'package:ec_senior/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TimeTableProvider extends ChangeNotifier{
  static User userInfo;
  final Firestore _firestore = Firestore.instance;
  static List<TimeTableItem> _timetableList = [];
  static bool _lodaing = true;

  TimeTableProvider.toLoad(User u) {
    userInfo = u;
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
    _lodaing = true;
    if(user != null) {
      if(user.timetableId == null) {
        return;
      }
      DocumentSnapshot userDoc = await _firestore.collection('seniors').document(user.uid).get();
      DocumentSnapshot ttbDoc = await _firestore.collection('timetable').document(user.timetableId).get();
      DateTime updateTime = DateFormat('kk:mm, dd, MM, yyyy').parse(userDoc.data['timetableLastUpdatedAt']);
      DateTime ttUpdateTime = DateFormat('kk:mm, dd, MM, yyyy').parse(ttbDoc.data['timestamp']+', ${DateTime.now().month}, ${DateTime.now().year}');
      if( updateTime.day != DateTime.now().day)
        await createTodaysTimetable();
      else if( updateTime.isBefore(ttUpdateTime))
        await createTodaysTimetable();
      _timetableList = [];
      QuerySnapshot ttDocs = await _firestore.collection('seniors').document(user.uid).collection('todaysTimetable').getDocuments();
      ttDocs.documents.forEach((element) {
        var item = new TimeTableItem(
          title: element.documentID,
          time: element['time'],
          completed: element['completed'],
          days: element['days'],
        );
        _timetableList.add(item);
      });
    }
    _lodaing = false;
    notifyListeners();
  }

  Future<int> markAsCompleted(int index) async {
    try {
      _timetableList[index] = TimeTableItem(
          title: _timetableList[index].title,
          time: _timetableList[index].time,
          completed: true,
          days: _timetableList[index].days
      );

      List<dynamic> newTimetable = [];
      _timetableList.forEach((element) {
        newTimetable.add({
          'title': element.title,
          'time': element.time,
          'days': element.days,
          'completed': element.completed,
        });
      });

      await _firestore.collection('seniors').document(user.uid).collection('todaysTimetable').document(_timetableList[index].title).updateData({'completed': true});
      notifyListeners();
      return 0;
    }
    catch(err) {
      notifyListeners();
      return 1;
    }
  }

  Future<void> createTodaysTimetable() async {
    DocumentSnapshot doc = await _firestore.collection('timetable').document(userInfo.timetableId).get();
    List<dynamic> timetable = doc.data['timetable'];
    int day = DateTime.now().weekday;
    QuerySnapshot oldtt = await _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').getDocuments();
    if( oldtt.documents.length != 0)
      oldtt.documents.forEach((element) {
        _firestore.collection('senior').document(userInfo.uid).collection('todaysTimetable').document(element.documentID).delete();//TODO: Replace with batch command
      });
    timetable.forEach((element) {
      List<dynamic> days = element['days'];
      if(days.indexOf(day) != -1)
        _firestore.collection('seniors').document(userInfo.uid).collection('todaysTimetable').document(element['title']).setData({
          'time': element['time'],
          'days': element['days'],
          'completed': false,
        });
    });
    _firestore.collection('seniors').document(userInfo.uid).updateData({'timetableLastUpdatedAt': '${DateFormat('kk:mm, dd, MM, yy').format(DateTime.now())}'});
  }
}