import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/question.dart';
import 'package:ec_senior/models/user.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Answer {
  final String ans;
  final DocumentSnapshot que;
  int count;

  Answer({this.que, this.ans}) {
    getAnswers();
  }

  void getAnswers() {
    List<dynamic> answers = que.data['answers'];
    count = answers.where((element) => element['answer'] == ans).toList().length;
  }
}

class Count {
  final DateTime date;
  final int count;

  Count({this.date, this.count});
}

class QuestionnaireReports extends ChangeNotifier{
  static User userInfo;
  final _firestore = Firestore.instance;
  bool _loading;
  static List<Question> ques = [];
  static List<Count> counts = [];

  QuestionnaireReports(User u) {
    userInfo = u;
    _loading = true;
    getReports();
    getCounts();
  }

  User get user => userInfo;

  bool get state => _loading;

  List<Question> get queList => ques;

  List<Count> get dailyCounts => counts;

  Future<void> getReports() async {
    if( userInfo != null) {
      QuerySnapshot repDocs = await _firestore.collection('seniors').document(userInfo.uid).collection('reports').getDocuments();
      if (repDocs.documents.length != 0) {
        Future.forEach(repDocs.documents, (DocumentSnapshot que) async {
            if (que.documentID != 'dailyCounts') {
              DocumentSnapshot optionsDoc = await _firestore.collection(
                  'questionnaire').document(que.documentID).get();
              List<dynamic> options = optionsDoc.data['options'];
              ques.add(Question(question: que.documentID, options: options));
            }
        }).then((value) {_loading = false; notifyListeners();});
      }
    }
    else {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getCounts() async {
    if( userInfo != null ) {
      DocumentSnapshot countDoc = await _firestore.collection('seniors').document(userInfo.uid).collection('reports').document('dailyCounts').get();
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
      counts = [];
      while(!minDate.isAtSameMomentAs(maxDate)) {
        if(countList.containsKey(DateFormat('dd-MM-yyyy').format(minDate))) {
          counts.add(Count(date: minDate, count: countList[DateFormat('dd-MM-yyyy').format(minDate)]));
        }
        else {
          counts.add(Count(date: minDate, count: 0));
        }
        minDate = minDate.add(Duration(days: 1));
      }
    }
  }

  List<Series<Count, DateTime>> getCountSeries() {
    return [
      Series<Count, DateTime>(
          data: counts,
        domainFn: (Count _count, _) => _count.date,
        measureFn: (Count _count, _) => _count.count,
        colorFn: (Count _count, _) => ColorUtil.fromDartColor(MyColors.accent),
        id: 'Number of Questions Answered Daily'
      )
    ];
  }
}