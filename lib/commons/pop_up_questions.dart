import 'dart:math';
import 'package:ec_senior/commons/pop_up_decor.dart';
import 'package:ec_senior/models/question.dart';
import 'package:ec_senior/services/questionnaire.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopUpQuestion extends StatefulWidget {
  final List<Question> questionsAndOptions;

  PopUpQuestion({@required this.questionsAndOptions});

  @override
  _PopUpQuestionState createState() => _PopUpQuestionState();
}

class _PopUpQuestionState extends State<PopUpQuestion> {

  String question;
  List<dynamic> options;
  int selectedOption;
  Color color;
  int currQuestionIndex;
  List<String> asked = [];
  List<String> answers = [];

  @override
  void initState() {
    setQuestionAndOptions();
    selectedOption = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          color: MyColors.white,
          height: 150+(70.0*options.length)+80,
          width: MediaQuery.of(context).size.width - 50,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0.0,
                          left: 0.0,
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width - 50,
                            child: CustomPaint(
                              painter: PopUpDecor(color: color),
                            ),
                          ),
                        ),
                        Center(child: Text('$question', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),)),
                      ],
                    )
                ),
                Container(
                  height: 75.0*options.length,
                  child: Column(
                    children: <Widget>[
                      Expanded(

                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                              child: ListTile(

                                selected: index == selectedOption,
                                title: Text('${options[index]}',
                                  style: TextStyle(
                                      fontSize: index == selectedOption?24.0:18.0,
                                      fontWeight: index == selectedOption?FontWeight.w600:FontWeight.w400,
                                      color: index == selectedOption?color:Colors.black),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedOption = index;
                                  });
                                },
                              ),
                            );
                          },
                          itemCount: options.length,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        child: Text('Close',
                          style: TextStyle(color: asked.length>0?MyColors.black:MyColors.shadow),
                        ),
                        onPressed: () {
                          if(asked.length>0) {
                            Questionnaire _questionnaire = Provider.of<Questionnaire>(context, listen: false);
                            _questionnaire.updateQuestionnaire(asked, answers);
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      OutlineButton(
                        borderSide: BorderSide(width: 2.0, color: color),
                        child: Text('Next',
                          style: TextStyle(color: color),),
                        onPressed: () {
                          setState(() {
                            asked.add(question);
                            answers.add(options[selectedOption]);
                            if(asked.length == widget.questionsAndOptions.length) {
                              Questionnaire _questionnaire = Provider.of<Questionnaire>(context, listen: false);
                              _questionnaire.updateQuestionnaire(asked, answers);
                              Navigator.of(context).pop(asked);
                            }
                            else
                              setQuestionAndOptions();
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  void setQuestionAndOptions() {
    int rand;
    while(true) {
      rand = Random().nextInt(widget.questionsAndOptions.length);
      bool repeated = false;
      for(int i= 0; i<asked.length; i++) {
        if (widget.questionsAndOptions[rand].question == asked[i])
          repeated = true;
      }
      if(!repeated)
        break;
    }
    int r = Random().nextInt(255) - 45;
    int g = Random().nextInt(255) - 45;
    int b = Random().nextInt(255) - 45;
    color = Color.fromRGBO(r, g, b, 1);
    question = widget.questionsAndOptions[rand].question;
    options = widget.questionsAndOptions[rand].options;
    currQuestionIndex = rand;
  }
}
