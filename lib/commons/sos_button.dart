import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';

class SOSButton extends StatefulWidget {

  final bool isPrimary;
  final bool isActive;

  SOSButton({this.isPrimary, this.isActive});

  @override
  _SOSButtonState createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> {
  @override
  Widget build(BuildContext context) {

    final double primaryWidth = MediaQuery.of(context).size.width/2.0 - 10.0;
    final double secondaryWidth = MediaQuery.of(context).size.width/4.0 - 10.0;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: MyColors.shadow, offset: Offset(0, 3), blurRadius: 3.0)
        ],
        color: widget.isActive?MyColors.accent:MyColors.shadow,
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: 55.0,
      width: widget.isPrimary?primaryWidth:secondaryWidth,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: widget.isActive?MyColors.deepPurple:MyColors.black,
          onTap: () {
            if(widget.isActive)
              print('Active');
            else
              print('Inactive');
          },
          child: Center(
            child: Text(
              'SOS',
              style: MyTextStyles().variationOfExisting(
                existing: MyTextStyles.heading,
                newColor: MyColors.white
              )
            ),
          ),
        ),
      ),
    );
  }
}
