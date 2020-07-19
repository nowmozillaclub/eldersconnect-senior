import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/question.dart';
import 'package:ec_senior/models/user.dart';
import 'package:flutter/cupertino.dart';

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
    if(userDoc.data['quesLastUpdatedAt'] != DateTime.now().weekday)
      await createTodaysQuestionnaire();
    questionsAndOptions = [];
    QuerySnapshot quesDocs = await _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').getDocuments();
    quesDocs.documents.forEach((doc) {
          questionsAndOptions.add(Question(question: doc.documentID, options: doc.data['options']));
    });
  }

  Future<void> updateQuestionnaire(List<int> asked) async { //TODO: Add them to report collection
    QuerySnapshot currQues = await _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').getDocuments();
    List<DocumentSnapshot> quesList = currQues.documents;
    for(int i=0; i<asked.length; i++) {
      await _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').document(quesList[asked[i]].documentID).delete();
    }
    await getQuestionnaire();
  }

  // Create a fresh copy of questions in the seniors doc
  Future<void> createTodaysQuestionnaire() async {
    QuerySnapshot newQues = await Firestore.instance.collection('questionnaire').getDocuments();
    newQues.documents.forEach((doc) {
      _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').document(doc.documentID).setData({
        'options': doc.data['options']
      });
    });
    await _firestore.collection('seniors').document(user.uid).updateData({'quesLastUpdatedAt': DateTime.now().weekday});
  }
}
