import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class FirstLaunch extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String _displayName;

  const Authenticated(this._displayName);

  String get displayName => _displayName;

  @override
  String toString() {
    return 'Authenticated {_displayName: $_displayName}';
  }

}

class UnAuthenticated extends AuthenticationState {}
