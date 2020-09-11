import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/services/questionnaire_reports.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class IndividualRep extends StatefulWidget {
  final String user;
  final String title;
  final List<dynamic> options;

  IndividualRep({this.user, this.title, this.options});

  @override
  _IndividualRepState createState() => _IndividualRepState();
}

class _IndividualRepState extends State<IndividualRep> {
  int maxCountAt;
  int totalCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      body: FutureBuilder(
        future: getAnswers(),
        builder: (context, answers) {
          print(MediaQuery.of(context).size.height);
          if(answers.connectionState == ConnectionState.waiting)
            return Container();
          else
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Text('Most Choosen Answer', style: MyTextStyles.title,),
                          SizedBox(height: 20.0,),
                          Text('${answers.data[maxCountAt].ans}',
                            style: MyTextStyles().variationOfExisting(existing: MyTextStyles.subtitle, newFontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: answers.data.length,
                    itemBuilder: (context, index) {
                        return Container(
                          height: MediaQuery.of(context).size.height/3,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width/3,
                                        child: Text('${answers.data[index].ans}', textAlign: TextAlign.center,),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 2*MediaQuery.of(context).size.width/3 - 18,
                                    height: 2*MediaQuery.of(context).size.width/3 - 18,
                                    child: Stack(
                                      children: [
                                        charts.PieChart(
                                          [charts.Series(
                                            id: '${answers.data[index].ans}',
                                            data: [{'domain': answers.data[index].ans, 'measure': answers.data[index].count}, {'domain': 'other', 'measure': totalCount - answers.data[index].count}],
                                            domainFn: (d, _) => d['domain'],
                                            measureFn: (d, _) => d['measure'],
                                            labelAccessorFn: (d, _) => d['domain'] == 'other' ? 'other': null,
                                            colorFn: (d, _) => d['domain'] == 'other' ? charts.ColorUtil.fromDartColor(MyColors.accent.withOpacity(0.5)): charts.ColorUtil.fromDartColor(MyColors.accent),
                                          )],
                                          animate: true,
                                          defaultRenderer: charts.ArcRendererConfig(arcWidth: 50, arcRendererDecorators: [charts.ArcLabelDecorator()]),
                                        ),
                                        Center(child: Text('${((answers.data[index].count/totalCount)*100.0).toStringAsFixed(2)}%'),)
                                      ],
                                    )
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                )
              ],
            );
        },
      ),
    );
  }

  Future<List<Answer>>getAnswers() async {
    DocumentSnapshot doc = await Firestore.instance.collection('seniors').document(widget.user).collection('reports').document(widget.title).get();
    int maxCount = 0;
    List<Answer> ans = [];
    widget.options.forEach((element) {
      Answer a = Answer(que: doc, ans: element.toString());
      ans.add(a);
      totalCount += a.count;
      print(a.count);
      if( a.count > maxCount) {
        maxCount = a.count;
        maxCountAt = ans.indexOf(a);
      }
    });
    print(totalCount);
    return ans;
  }
}

