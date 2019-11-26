import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have logged in successfully'),
            FlatButton(
              onPressed: () {},
              child: Text('Log out'),
            )
          ],
        ),
      ),
    );
  }
}

