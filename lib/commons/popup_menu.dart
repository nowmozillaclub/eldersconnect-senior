import 'package:ec_senior/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Options {
  static final String settings  = 'Settings';
  static final String connect = 'Reconnect To Junior';
  static final String signOut = 'Sign Out';

  static List<String> options = [
    settings,
    connect,
    signOut,
  ];

  void onSelected(String selected) {
    print('$selected');
  }
}

class CustomPopUpMenu extends StatefulWidget {
  @override
  _CustomPopUpMenuState createState() => _CustomPopUpMenuState();
}

class _CustomPopUpMenuState extends State<CustomPopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Icon(
        Icons.menu,
        color: MyColors.white,
        size: 32.0,
      ),
      onSelected: Options().onSelected,
      itemBuilder: (context){
        return Options.options.map((String option) {
          return PopupMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList();
      },
    );
  }
}
