import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class SOSButton extends StatefulWidget {

  final bool isPrimary;
  final bool isActive;

  SOSButton({this.isPrimary, this.isActive});

  void makeCall(String tel) async {
    UrlLauncher.launch('tel:'+Uri.encodeComponent('+91'+tel));
  }

  @override
  _SOSButtonState createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> {
  @override
  Widget build(BuildContext context) {

    final double primaryWidth = MediaQuery.of(context).size.width/2.0 - 10.0;
    final double secondaryWidth = MediaQuery.of(context).size.width/4.0 - 10.0;
    final user = Provider.of<AuthService>(context).user;

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
            if(widget.isActive) {
              widget.makeCall(user.connectedToPhone);
            }
            else
              showDialog(
                  context: context,
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
                        child: Builder(
                            builder: (context) {
                              if(user.phone == null)
                                return Container(
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.warning),
                                        ),
                                        Container(
                                            child: Expanded(
                                                child: Text('TO ENABLE SOS BUTTON ADD PHONE NUMBER')
                                            )
                                        ),
                                      ],
                                    )
                                );
                              else
                                return Container();
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
                        child: Builder(
                          builder: (context) {
                            if(user.connectedToPhone == null)
                              return Container(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.warning),
                                      ),
                                      Container(
                                          child: Expanded(
                                              child: Text('TO ENABLE SOS BUTTON ADD JUNIOR\'S PHONE NUMBER')
                                          )
                                      ),
                                    ],
                                  )
                              );
                            else
                              return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              );
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
