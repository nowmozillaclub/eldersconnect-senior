import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/commons/circle_progress_bar.dart';
import 'package:ec_senior/services/time_table_provider.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTablePage extends StatefulWidget {
  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {

  @override
  Widget build(BuildContext context) {

    List<String> days = ['Monday', 'Teusday', 'Wednusday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          currentSelectedNavBar = 0;
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('TimeTable', style: MyTextStyles.heading,),
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
                          height: MediaQuery.of(context).size.height/3 + 25,
                          color: Colors.yellow,
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 20.0,
                                bottom: 32.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width>MediaQuery.of(context).size.height?MediaQuery.of(context).size.height/3 - 64.0: MediaQuery.of(context).size.width/2 - 64.0,
                                  child: AspectRatio(
                                      aspectRatio: 1/1,
                                      child: CustomPaint(
                                        child: Container(),
                                        foregroundPainter: CircleProgressBar(
                                          value: value,
                                          foregroundColor: Colors.purple,
                                          backgroundColor: Colors.blueGrey,
                                        ),
                                      )
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 20.0,
                                bottom: 32.0,
                                child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('${DateTime.now().day}', style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.w600),),
                                        Text('${days[DateTime.now().weekday]}', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),),
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
                          return Card(
                            elevation: 3.0,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('${_currTimetable[index].title}', style: MyTextStyles().variationOfExisting(existing: MyTextStyles.heading, newColor: _currTimetable[index].completed ? MyColors.shadow : MyColors.primary),),
                                  Text('Time: ${_currTimetable[index].time}'),
                                ],
                              ),
                              subtitle: Builder(
                                    builder: (context) {
                                      String otherDays = '';
                                      for(int i=0; i < _currTimetable[index].days.length - 1; i++) {
                                        var val = _currTimetable[index].days[i] - 1;
                                        otherDays += days[val]+', ';
                                      }
                                      otherDays += days[(_currTimetable[index].days[_currTimetable[index].days.length - 1]) - 1];
                                      return Text('$otherDays', maxLines: 1, overflow: TextOverflow.ellipsis,);
                                    },
                                  ),
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
                                    if(!_currTimetable[index].completed)
                                      _timeTableProvider.markAsCompleted(index);
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
}
