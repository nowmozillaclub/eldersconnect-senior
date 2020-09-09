import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/question.dart';
import 'package:ec_senior/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Questionnaire extends ChangeNotifier{
  final Firestore _firestore = Firestore.instance;
  static User userInfo;
  static List<Question> questionsAndOptions;

  Questionnaire(User u) {
    user = u;
  }

  set user(User user) {
    userInfo = user;
  }

  User get user => userInfo;

  List<dynamic> get questions => questionsAndOptions;

  Future<void> getQuestionnaire() async{
    DocumentSnapshot userDoc = await _firestore.collection('seniors').document(user.uid).get();
    if(userDoc.data['quesLastUpdatedAt'] != DateTime.now().day)
      await createTodaysQuestionnaire();
    questionsAndOptions = [];
    QuerySnapshot quesDocs = await _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').getDocuments();
    quesDocs.documents.forEach((doc) {
          questionsAndOptions.add(Question(question: doc.documentID, options: doc.data['options']));
    });
  }

  Future<void> updateQuestionnaire(List<String> asked, List<String> answers) async {
    for(int i=0; i<asked.length; i++) {
      questionsAndOptions.removeWhere((element) => element.question == asked[i]);

      await _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').document(asked[i]).delete();

      await addToReports(asked[i], answers[i]);
    }
    int count = answers.length;
    DocumentSnapshot countDoc = await _firestore.collection('seniors').document(user.uid).collection('reports').document('dailyCounts').get();
    if(countDoc.exists && countDoc.data['counts'] != null) {
      Map<String, int> counts = Map<String, int>.from(countDoc.data['counts']);
      int currCount =counts['${DateFormat('dd-MM-yyyy').format(DateTime.now())}'] ?? 0;
      counts['${DateFormat('dd-MM-yyyy').format(DateTime.now())}'] = currCount + count;
      await _firestore.collection('seniors').document(user.uid).collection('reports').document('dailyCounts').setData({'counts': counts});
    }
    else
      await _firestore.collection('seniors').document(user.uid).collection('reports').document('dailyCounts').setData({'counts': {'${DateFormat('dd-MM-yyyy').format(DateTime.now())}': count}});
  }

  // Create a fresh copy of questions in the seniors doc
  Future<void> createTodaysQuestionnaire() async {
    QuerySnapshot newQues = await Firestore.instance.collection('questionnaire').getDocuments();
    newQues.documents.forEach((doc) {
      _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').document(doc.documentID).setData({
        'options': doc.data['options']
      });
    });
    await _firestore.collection('seniors').document(user.uid).updateData({'quesLastUpdatedAt': DateTime.now().day});
  }

  Future<void> addToReports(String question , String answer) async {
    DocumentSnapshot queDoc = await _firestore.collection('seniors').document(user.uid).collection('reports').document(question).get();

    if(queDoc.exists) {
      List<dynamic> currAnswers = queDoc.data['answers'] ?? [];
      currAnswers.add({'date': '${DateFormat('dd-MM-yyyy').format(DateTime.now())}', 'answer': answer});
      await _firestore.collection('seniors').document(user.uid).collection('reports')
          .document(question).updateData({'answers': currAnswers});
    }
    else {
      List<dynamic> currAnswers = [];
      currAnswers.add({'${DateFormat('dd-MM-yyyy').format(DateTime.now())}': answer});
      await _firestore.collection('seniors').document(user.uid).collection('reports')
          .document(question).setData({'answers': currAnswers});
    }
  }
}
