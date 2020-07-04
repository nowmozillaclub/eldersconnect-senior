import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';

class NavBarTile extends StatefulWidget {

  final IconData icon;
  final String title;
  final bool  isSelected;

  NavBarTile({this.icon, this.title, this.isSelected});

  @override
  _NavBarTileState createState() => _NavBarTileState();
}

class _NavBarTileState extends State<NavBarTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(widget.icon, size: 30.0, color: widget.isSelected?MyColors.accent:MyColors.black,),
          Text('${widget.title}',
            style: MyTextStyles().variationOfExisting(
              existing: MyTextStyles.body,
              newColor: widget.isSelected?MyColors.accent:MyColors.black,
              newFontSize: 8.0,
            ),
          )
        ],
      ),
    );
  }
}
