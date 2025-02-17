import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_senior/services/timetable_report.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class IndividualDayRep extends StatefulWidget {
  final String title;
  final int index;
  final String user;
  final List<charts.Series<Count, DateTime>> series;

  IndividualDayRep({this.title, this.index, this.user, this.series});
  @override
  _IndividualDayRepState createState() => _IndividualDayRepState();
}

class _IndividualDayRepState extends State<IndividualDayRep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: FutureBuilder(
        future: getTasks(),
        builder: (context, tasks) {
          if(tasks.connectionState == ConnectionState.waiting)
            return Container();
          else if(tasks.data.length == 0)
            return Center(child: Text('No Tasks on ${widget.title}'),);
          else
            return Column(
              children: [
                Container(
                    color: MyColors.primary.withOpacity(0.2),
                    height: 200,
                    child: charts.TimeSeriesChart(
                      widget.series,
                      animate: true,
                      dateTimeFactory: charts.LocalDateTimeFactory(),
                      domainAxis: charts.DateTimeAxisSpec(
                          tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                              day: charts.TimeFormatterSpec(
                                  format: 'dd-MM', transitionFormat: 'dd-MM'
                              ),
                              hour: charts.TimeFormatterSpec(format: 'j-dd', transitionFormat: 'dd-MM'),
                              month: charts.TimeFormatterSpec(format: 'dd-MM', transitionFormat: 'dd-MM'),
                              year: charts.TimeFormatterSpec(format: 'MM-yy', transitionFormat: 'MM-yy')
                          )
                      ),
                    )
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: tasks.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
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
                                        child: Text('${tasks.data[index].task.documentID}', textAlign: TextAlign.center,),
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
                                              id: '${tasks.data[index].task.documentID}',
                                              data: [{'domain': tasks.data[index].task.documentID, 'measure': tasks.data[index].count}, {'domain': 'not completed', 'measure': tasks.data[index].totalCount - tasks.data[index].count}],
                                              domainFn: (d, _) => d['domain'],
                                              measureFn: (d, _) => d['measure'],
                                              labelAccessorFn: (d, _) => null,
                                              colorFn: (d, _) => d['domain'] == 'not completed' ? charts.ColorUtil.fromDartColor(MyColors.accent.withOpacity(0.5)): charts.ColorUtil.fromDartColor(MyColors.accent),
                                            )],
                                            animate: true,
                                            defaultRenderer: charts.ArcRendererConfig(arcWidth: 50, arcRendererDecorators: [charts.ArcLabelDecorator()]),
                                          ),
                                          Center(child: Text('${(tasks.data[index].count)}/${tasks.data[index].totalCount} times'),)
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

  Future<List<Task>>getTasks() async {
    DocumentSnapshot doc = await Firestore.instance.collection('timetable').document('example').collection('timetable').document('${widget.index}').get();
    if((!doc.exists) || doc.data['tasks'] == null) {
      print('in if');
      return [];
    }
    List<dynamic> tasks = doc.data['tasks'];
    print(tasks.length);
    List<Task> statuses = [];
    List<Task> data = await Future.forEach(tasks, (element) async {
      DocumentSnapshot taskDoc = await Firestore.instance.collection('seniors').document(widget.user).collection('timetableReports').document(element['title']).get();
      Task t = Task(task: taskDoc, day: widget.index);
      statuses.add(t);
    }).then((value) => statuses);
    print('length: ${data.length}');
    return data;
  }
}
