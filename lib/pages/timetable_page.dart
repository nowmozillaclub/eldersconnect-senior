import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/services/time_table_provider.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTablePage extends StatefulWidget {
  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {

  @override
  Widget build(BuildContext context) {
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
            if (_timeTableProvider.timetable.length == 0)
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
              return Container(
                height: MediaQuery.of(context).size.height - 100,
                child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('${_currTimetable[index].title}'),
                              );
                            },
                  itemCount: _timeTableProvider.timetable.length,
                        ),
              );
            }
          },
        ),
        bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar),
      ),
    );
  }
}
