import 'package:ec_senior/pages/individual_day_report.dart';
import 'package:ec_senior/services/timetable_report.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class TimetableReportsPage extends StatefulWidget {
  @override
  _TimetableReportsPageState createState() => _TimetableReportsPageState();
}

class _TimetableReportsPageState extends State<TimetableReportsPage> {
  List<String> days = ['Monday', 'Teusday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Timetable Reports And Stats', overflow: TextOverflow.ellipsis,),
      ),
      body: Consumer<TimetableReports>(
        builder: (context, _rep, child) {
          if(_rep.state)
            return CircularProgressIndicator();
          print(_rep.dailyCounts.length);
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
                                format: 'dd-MM', transitionFormat: 'dd-MM'
                            ),
                            hour: charts.TimeFormatterSpec(format: 'j', transitionFormat: 'dd-MM'),
                            month: charts.TimeFormatterSpec(format: 'dd-MM', transitionFormat: 'dd-MM'),
                            year: charts.TimeFormatterSpec(format: 'MM-yy', transitionFormat: 'MM-yy')
                        )
                    ),
                  )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: MyColors.accent)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [MyColors.primary.withOpacity(0.2), MyColors.primary.withOpacity(0.4)],
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
                  child: Text('Number of Tasks Completed Daily', style: MyTextStyles().variationOfExisting(existing: MyTextStyles.title, newColor: MyColors.accent), textAlign: TextAlign.center,),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Card(
                          elevation: 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${days[index]}", style: MyTextStyles.title,),
                          )
                      ),
                      onTap: () {
                        List<charts.Series<Count, DateTime>> series = _rep.getDaySeries(index+1);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualDayRep(title: days[index], index: index+1, series: series, user: _rep.user.uid,)));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
