import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final FirebaseUser firebaseUser;

  LoggedIn({ @required this.firebaseUser });

  FirebaseUser get user => firebaseUser;
}

class LoggedOut extends AuthenticationEvent {}