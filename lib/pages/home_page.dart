import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
//  final FirebaseUser user;
//  MyHomePage(this.user, {Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('EldersConnect Senior'),
//                Text(widget.user.displayName),
                Text('EldersConnect Senior'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
