import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {


  @override
  List<Object> get props => [];
}

class Success extends LoginState {}

class Failure extends LoginState {
  final String _error;

  Failure(String error) : _error = error;

  @override
  String toString() {
    return 'Failure {error: $_error}';
  }

}