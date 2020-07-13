import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/time_table_item.dart';
import 'package:ec_senior/models/user.dart';
import 'package:flutter/cupertino.dart';

class TimeTableProvider extends ChangeNotifier{
  final User user;
  final Firestore _firestore = Firestore.instance;
  static List<TimeTableItem> _timetableList = [];

  List<TimeTableItem> get timetable => _timetableList;

  TimeTableProvider(this.user) {
    print('constructor called');
    print(this.user==null); //Not null till here
    getTimeTable();
  }

  User get senior => user;

  Future<void> getTimeTable() async {
    if(user.timetableId!= null) { //error on this line
      DocumentSnapshot timetableDoc = await _firestore.collection('timetable').document(user.timetableId).get();
      List<dynamic> currTimetable = timetableDoc.data['timetable'];
      currTimetable.forEach((element) {
        var item = new TimeTableItem(
            title: element['title'],
            time: element['time'],
            completed: element['completed'],
            days: element['days']
        );
        _timetableList.add(item);
      });
    }
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

      await _firestore.collection('timetable')
          .document(user.timetableId)
          .updateData({'timetable': newTimetable});
      return 0;
    }
    catch(err) {
      return 1;
    }
  }
}