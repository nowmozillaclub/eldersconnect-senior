import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/pages/individual_q_report.dart';
import 'package:ec_senior/services/questionnaire_reports.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Reports And Stats'),
      ),
      body: Consumer<QuestionnaireReports>(
        builder: (context, _rep, child) {
          if(_rep.state)
            return CircularProgressIndicator();
          return Column(
            children: [
              Container(
                color: MyColors.primary.withOpacity(0.2),
                height: 200,
                child: charts.TimeSeriesChart(
                  _rep.getCountSeries(),
                  animate: true,
                  dateTimeFactory: charts.LocalDateTimeFactory(),
                  domainAxis: charts.DateTimeAxisSpec(
                    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                      day: charts.TimeFormatterSpec(
                        format: 'dd', transitionFormat: 'dd-MM'
                      ),
                      hour: charts.TimeFormatterSpec(format: 'j', transitionFormat: 'dd-MM'),
                      month: charts.TimeFormatterSpec(format: 'MM', transitionFormat: 'dd-MM'),
                      year: charts.TimeFormatterSpec(format: 'yy', transitionFormat: 'MM-yy')
                    )
                  ),
                )
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: MyColors.accent)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [MyColors.primary.withOpacity(0.2), MyColors.primary.withOpacity(0.4)],
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                  child: Text('Number of Questions Answered Daily', style: MyTextStyles().variationOfExisting(existing: MyTextStyles.title, newColor: MyColors.accent), textAlign: TextAlign.center,),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _rep.queList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Card(
                        elevation: 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${_rep.queList[index].question}", style: MyTextStyles.title,),
                          )
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualRep(user: _rep.user.uid,title: _rep.queList[index].question, options: _rep.queList[index].options,)));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar,),
    );
  }
}

//
//var data = [];
//
//var series = [Series(
//    data: data,
//    domainFn: (Answer _data, _) => _data.ans,
//    measureFn: (Answer _data, _) => _data.count,
//    id: 'Answers'
//)];
//
//SizedBox(
//height: 200.0,
//child: BarChart(
//series,
//animate: true,
//),
//)