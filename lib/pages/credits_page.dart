import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:ec_senior/utils/ui_helpers.dart';
import 'package:ec_senior/widgets/sexy_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCreditsPage extends StatefulWidget {
  @override
  _MyCreditsPageState createState() => _MyCreditsPageState();
}

class _MyCreditsPageState extends State<MyCreditsPage> {
//  _launchURL(String url) async {
//    if (await canLaunch(url)) {
//      print('Launching $url...');
//      await launch(url);
//    } else {
//      print('Error launching $url!');
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: invertInvertColorsStrong(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 40.0,
                left: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    tooltip: 'Go back',
                    iconSize: 20.0,
                    color: invertColorsStrong(context),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Credits',
                    style: MyTextStyles.title,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 2.3, // increase/decrease tile height
                children: <Widget>[
                  SexyTile(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 75.0,
                          height: 75.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('./assets/credits/urmil.jpg'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Urmil Shroff',
                              style: MyTextStyles.title,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'I like developing apps.',
                              style: MyTextStyles.subtitle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    splashColor: MyColors.primary,
                    onTap: () => doNothing(),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Built using Flutter 📲'
                          '\nCompletely free & Open Source'
                          '\nMade with ❤️ in Mumbai, India',
                          style: MyTextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Text('GitHub'),
                              textColor: invertColorsStrong(context),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              onPressed: () => doNothing(),
                            ),
                            FlatButton(
                              child: Text('Feedback'),
                              textColor: invertColorsStrong(context),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              onPressed: () => doNothing(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
