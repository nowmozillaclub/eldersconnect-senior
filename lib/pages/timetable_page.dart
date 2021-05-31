import 'dart:math';

import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/commons/circle_progress_bar.dart';
import 'package:ec_senior/services/time_table_provider.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class TimeTablePage extends StatefulWidget {
  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  static final channel = MethodChannel("ec_senior/alarm_service");

  @override
  Widget build(BuildContext context) {

    List<String> days = ['Monday', 'Teusday', 'Wednusday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          currentSelectedNavBar = 0;
        });
        print(Navigator.canPop(context));
        if(!Navigator.canPop(context))
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('TimeTable', style: MyTextStyles.heading,),
          elevation: 0.0,
        ),
        body: Consumer<TimeTableProvider>(
          builder: (context, _timeTableProvider, child) {
            if(_timeTableProvider.state) {
              return Center(
                  child: Container(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator()
                  )
              );
            }
            else if (_timeTableProvider.timetable.length == 0)
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/graphics/empty_list_bg.png'),
                        fit: BoxFit.contain
                    )
                ),
              );
            else {
              var _currTimetable = _timeTableProvider.timetable;
              var length = _currTimetable.length;
              var completed = _currTimetable.where((element) => element.completed).length;
              var value = completed/length;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/4,
                          color: MyColors.primary,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 25.0,
                                bottom: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                  ),
                                  width: MediaQuery.of(context).size.width/2,
                                  height: MediaQuery.of(context).size.height/8,
                                  child: AspectRatio(
                                      aspectRatio: 1/1,
                                      child: CustomPaint(
                                        child: Container(),
                                        foregroundPainter: MediaQuery.of(context).size.height > MediaQuery.of(context).size.width ?
                                        CircleProgressBar(
                                          value: value,
                                          foregroundColor: Colors.purple,
                                          backgroundColor: Colors.blueGrey,
                                        ) :
                                            null
                                      )
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 30.0,
                                bottom: 32.0,
                                child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text('${DateFormat('dd').format(DateTime.now())}', style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.w600),),
                                        Text('${days[DateTime.now().weekday - 1]}', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),),
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          DateTime time = DateFormat('kk:mm').parse(_currTimetable[index].time);
                          return Card(
                            elevation: 3.0,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text('${_currTimetable[index].title}', style: MyTextStyles().variationOfExisting(existing: MyTextStyles.heading, newColor: _currTimetable[index].completed ? MyColors.primary : MyColors.shadow),),
                                  reminderButton(time.hour, time.minute, _currTimetable[index].title, !_currTimetable[index].completed, Scaffold.of(context)),
                                ],
                              ),
                              subtitle: Text('Time: ${_currTimetable[index].time}', style: MyTextStyles.subtext,),
//                              _currTimetable[index].otherDays.length == 0 ? null :
//                                Builder(
//                                      builder: (context) {
//                                        String otherDays = '';
//                                        for(int i=0; i < _currTimetable[index].otherDays.length - 1; i++) {
//                                          var val = _currTimetable[index].otherDays[i] - 1;
//                                          otherDays += days[val]+', ';
//                                        }
//                                        otherDays += days[(_currTimetable[index].otherDays[_currTimetable[index].otherDays.length - 1]) - 1];
//                                        return Text('$otherDays', maxLines: 1, overflow: TextOverflow.ellipsis,);
//                                      },
//                                    ),
                              trailing: Material(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                child: InkWell(
                                  child: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: _currTimetable[index].completed ? MyColors.primary: MyColors.shadow,
                                    child: Icon(Icons.check, size: 20.0, color: MyColors.white,),
                                  ),
                                  onTap: () {
                                      _timeTableProvider.toggleStatus(index);
                                    }
                                ),
                              ),
                            ),
                          );
                          },
                        itemCount: _timeTableProvider.timetable.length,
                      ),
                  ),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar),
      ),
    );
  }

  Widget reminderButton(int hour, int minute, String title, bool active, ScaffoldState state) {
    return InkWell(
      child: Container(child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text("Set Reminder", style: active? MyTextStyles().variationOfExisting(existing: MyTextStyles.subtext, newColor: MyColors.primary): MyTextStyles.subtext,),
      )),
      onTap: () {
        //TODO: Add recurring alarms for recurring tasks
        if(active) {
          if (DateTime.now().isBefore(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute, DateTime.now().second, DateTime.now().microsecond, DateTime.now().millisecond)))
            channel.invokeMethod('schedule_alarm', {
              "alarmId": Random().nextInt(1000),
              "hour": hour,
              "minute": minute,
              "title": title,
              "created": Random().nextInt(100),
              "started": false,
              "recurring": false,
              "monday": true,
              "tuesday": false,
              "wednesday": false,
              "thursday": false,
              "friday": false,
              "saturday": false,
              "sunday": false
            });
          else
            state.showSnackBar(SnackBar(
              content: Text("Time Already Passed"),
            ));
        }
        else
          state.showSnackBar(SnackBar(
            content: Text("Task Already Completed"),
          ));
      },
    );
  }
}
