import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/question.dart';
import 'package:ec_senior/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Answer {
  final String uid;
  final String ans;
  final DocumentSnapshot que;
  int count;

  Answer({this.que, this.ans, this.uid});

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

  Future<void> makeReport(DocumentSnapshot que) async {

  }

  Future<void> getCounts() async {
    if( userInfo != null ) {
      DocumentSnapshot countDoc = await _firestore.collection('seniors').document(userInfo.uid).collection('reports').document('dailyCounts').get();
      var countList = Map<String, int>.from(countDoc.data['counts']);
      countList.forEach((key, value) {
        DateTime date = DateFormat('dd-MM-yyyy').parse(key);
        counts.add(Count(date: date, count: value));
      });
      counts.sort((c1, c2) {
        var d1 = c1.date;
        var d2 = c2.date;
        return d1.compareTo(d2);
      });
    }
  }

  List<Series<Count, DateTime>> getCountSeries() {
    return [
      Series<Count, DateTime>(
          data: counts,
        domainFn: (Count _count, _) => _count.date,
        measureFn: (Count _count, _) => _count.count,
        id: 'Number of Questions Answered Daily'
      )
    ];
  }
}