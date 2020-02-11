import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {


  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class Success extends LoginState {
  final FirebaseUser _firebaseUser;
  Success(FirebaseUser firebaseUser) : _firebaseUser = firebaseUser;

  FirebaseUser get firebaseUser => _firebaseUser;
}

class Failure extends LoginState {
  final String _error;

  Failure(String error) : _error = error;

  @override
  String toString() {
    return 'Failure {error: $_error}';
  }

}