import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/models/user.dart';
import 'package:flutter/cupertino.dart';

class Questionnaire extends ChangeNotifier{
  final Firestore _firestore = Firestore.instance;
  final User user;
  static List<dynamic> questionsAndOptions;

  List<dynamic> get questions => questionsAndOptions;

  Questionnaire({this.user});

  Future<void> getQuestionnaire() async{
    DocumentSnapshot userDoc = await _firestore.collection('seniors').document(user.uid).get();
    if(userDoc.data['quesLastUpdatedAt'] != DateTime.now().weekday)
      await createTodaysQuestionnaire();
    questionsAndOptions = [];
    QuerySnapshot quesDocs = await _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').getDocuments();
    quesDocs.documents.forEach((doc) {
          questionsAndOptions.add({'question': doc.documentID, 'options': doc.data['options']});
    });
  }

  Future<void> updateQuestionnaire(List<int> asked) async { //TODO: Add them to report collection
    QuerySnapshot currQues = await _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').getDocuments();
    List<DocumentSnapshot> quesList = currQues.documents;
    for(int i=0; i<asked.length; i++) {
      questionsAndOptions.removeAt(asked[i]);
      await _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').document(quesList[asked[i]].documentID).delete();
    }
  }

  // Create a fresh copy of questions in the seniors doc
  Future<void> createTodaysQuestionnaire() async {
//    QuerySnapshot prevQues = await _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').getDocuments();
//    prevQues.documents.forEach((doc) {
//      _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').document(doc.documentID).delete();
//    }); // not required mostly
    QuerySnapshot newQues = await Firestore.instance.collection('questionnaire').getDocuments();
    newQues.documents.forEach((doc) {
      _firestore.collection('seniors').document(user.uid).collection('todaysQuestions').document(doc.documentID).setData({
        'options': doc.data['options']
      });
    });
    await _firestore.collection('seniors').document(user.uid).updateData({'quesLastUpdatedAt': DateTime.now().weekday});
  }
}
