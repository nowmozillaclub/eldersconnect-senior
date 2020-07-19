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

    TimeTableProvider _timeTableProvider = Provider.of<TimeTableProvider>(context);
    print(_timeTableProvider.timetable.length);

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
        body: CustomScrollView(
          slivers: <Widget>[
            Builder(
              builder: (context) {
                if(_timeTableProvider.timetable.length == 0)
                  return SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/frame_101_delay-0.03s.png'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  );
                else {
                  var _currTimetable = _timeTableProvider.timetable;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return Container(
                          child: Text('${_currTimetable[index].title}', style: MyTextStyles.title,),
                        );
                      },
                      childCount: _timeTableProvider.timetable.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar),
      ),
    );
  }
}
