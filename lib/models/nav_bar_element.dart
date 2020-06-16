import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/pages/second_page.dart';
import 'package:ec_senior/pages/third_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarElement {
  final IconData icon;
  final String name;
  final Widget pushToPage;

  NavBarElement({this.icon, this.name, this.pushToPage});
}

List<NavBarElement> navBarElements = [
  NavBarElement(icon: Icons.home, name: 'Home', pushToPage: MyHomePage()),
  NavBarElement(icon: Icons.style, name: 'Second', pushToPage: SecondPage()),
  NavBarElement(icon: Icons.table_chart, name: 'Third', pushToPage: ThirdPage())
];