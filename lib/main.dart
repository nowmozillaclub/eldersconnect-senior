import 'package:ec_senior/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:ec_senior/pages/authentication/register.dart';
import 'package:provider/provider.dart';
import 'package:ec_senior/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().firebaseUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EldersConnect Senior',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('EldersConnect Senior'),
      ),
    );
  }
}
