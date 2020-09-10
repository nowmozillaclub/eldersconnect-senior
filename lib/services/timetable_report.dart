import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/time_table_item.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Task {
  final int day;
  final DocumentSnapshot task;
  int count = 0;
  int totalCount = 0;

  Task({this.task, this.day}) {
    getTasks();
  }

  void getTasks() {
    List<dynamic> days = task.data['records'];
    days.forEach((element) {
      var date = DateFormat('dd-MM-yyyy').parse(element['date']);
      if(day == date.weekday) {
        totalCount ++;
        if(element['status'])
          count++;
      }
    });
  }
}

class Count {
  final DateTime date;
  final int count;

  Count({this.date, this.count});
}

class TimetableReports extends ChangeNotifier{
  static User userInfo;
  final _firestore = Firestore.instance;
  bool _loading;
  static List<TimeTableItem> tasks = [];
  static List<Count> counts = [];

  TimetableReports(User u) {
    userInfo = u;
    _loading = true;
//    getReports();
    getCounts();
  }

  User get user => userInfo;

  bool get state => _loading;

  List<TimeTableItem> get taskList => tasks;

  List<Count> get dailyCounts => counts;

  Future<void> getReports() async {
//    if( userInfo != null) {
//      QuerySnapshot repDocs = await _firestore.collection('seniors').document(userInfo.uid).collection('timetableReports').getDocuments();
//      if (repDocs.documents.length != 0) {
//        Future.forEach(repDocs.documents, (DocumentSnapshot que) async {
//          if (que.documentID != 'dailyCounts') {
//          }
//        }).then((value) {_loading = false; notifyListeners();});
//      }
//    }
//    else {
//      _loading = false;
//      notifyListeners();
//    }
  }

  Future<void> getCounts() async {
    if( userInfo != null ) {
      DocumentSnapshot countDoc = await _firestore.collection('seniors').document(userInfo.uid).collection('timetableReports').document('dailyCounts').get();
      var countList = Map<String, int>.from(countDoc.data['counts']);
      countList.forEach((key, value) {
        DateTime date = DateFormat('dd-MM-yyyy').parse(key);
        counts.add(Count(date: date, count: value));
        print(key);
      });
      counts.sort((c1, c2) {
        var d1 = c1.date;
        var d2 = c2.date;
        return d1.compareTo(d2);
      });
      DateTime minDate = counts[0].date;
      DateTime maxDate = counts[counts.length - 1].date;
      if(!minDate.isAtSameMomentAs(maxDate)) {
        counts = [];
        while (!minDate.isAtSameMomentAs(maxDate.add(Duration(days: 1)))) {
          if (countList.containsKey(DateFormat('dd-MM-yyyy').format(minDate))) {
            counts.add(Count(date: minDate,
                count: countList[DateFormat('dd-MM-yyyy').format(minDate)]));
          }
          else {
            counts.add(Count(date: minDate, count: 0));
          }
          minDate = minDate.add(Duration(days: 1));
        }
      }
    }
    _loading = false;
    notifyListeners();
  }

  List<Series<Count, DateTime>> getCountSeries() {
    return [
      Series<Count, DateTime>(
          data: counts,
          domainFn: (Count _count, _) => _count.date,
          measureFn: (Count _count, _) => _count.count,
          colorFn: (Count _count, _) => ColorUtil.fromDartColor(MyColors.accent),
          id: 'Number of Tasks Completed Daily'
      )
    ];
  }

  List<Series<Count, DateTime>> getDaySeries(int day) {
    return [
      Series<Count, DateTime>(
          data: counts.where((element) => element.date.day == day).toList(),
          domainFn: (Count _count, _) => _count.date,
          measureFn: (Count _count, _) => _count.count,
          colorFn: (Count _count, _) => ColorUtil.fromDartColor(MyColors.accent),
          id: 'Number of Tasks Completed Daily'
      )
    ];
  }
}