import 'package:ec_senior/commons/nav_bar_tile.dart';
import 'package:ec_senior/commons/sos_button.dart';
import 'package:ec_senior/models/nav_bar_element.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/bottom_nav_bar_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int currentSelectedNavBar = 0;

class BottomNavBar extends StatefulWidget {

  final int currentSelected;

  BottomNavBar({@required this.currentSelected});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0.0,
            child: Hero(
              tag: 'bottomNavBar',
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                child: CustomPaint(
                  painter: widget.currentSelected==0?NavBarBackgroundPrimary():NavBarBackgroundSecondary(),
                ),
              ),
            ),
          ),
          Builder(
            builder: (context) {
              if(widget.currentSelected == 0)
                return Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: 60.0,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Hero(
                            tag: 'item${index+1}',
                            child: Material(
                              type: MaterialType.transparency,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    currentSelectedNavBar = index+1;
                                    Navigator.pushAndRemoveUntil(context,
                                        MaterialPageRoute(builder: (context) => navBarElements[index+1].pushToPage),
                                        (Route<dynamic> route) => false);
                                  });
                                },
                                child: NavBarTile(
                                  isSelected: false,
                                  icon: navBarElements[index +1].icon,
                                  title: navBarElements[index +1].name,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: (MediaQuery.of(context).size.width - 45.0 - 80.0),
                          );
                        },
                        itemCount: navBarElements.length - 1,
                      ),
                    ),
                  ),
                );
              else
                return Positioned(
                  bottom: 0.0,
                  child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width*(3/4) - 10.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32.0, 0.0, 16.0, 0.0),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: 'item$index',
                              child: Material(
                                type: MaterialType.transparency,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentSelectedNavBar = index;
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => navBarElements[index].pushToPage),
                                          (Route<dynamic> route) => false);
                                    });
                                  },
                                  child: NavBarTile(
                                    isSelected: widget.currentSelected == index,
                                    icon: navBarElements[index].icon,
                                    title: navBarElements[index].name,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: (MediaQuery.of(context).size.width * (3/4) - 148.0 )/ 3,
                            );
                          },
                          itemCount: navBarElements.length,
                        ),
                      )
                  ),
                );
            },
          ),
          Positioned(
              top: 0.0,
              left: widget.currentSelected == 0?MediaQuery.of(context).size.width/4 + 5.0:MediaQuery.of(context).size.width * (3/4) - 5.0,
              child: Hero(
                  tag: 'SOSButton',
                  child: Consumer<AuthService>(
                    builder: (context, auth, child) {
                      return SOSButton(isPrimary: widget.currentSelected==0, isActive: auth.user.sosStatus,);
                    },
                  )
              )
          ),
        ],
      ),
    );
  }
}
//TODO: Smoother Transition for buttons
//TODO: Improve positioning on elements
