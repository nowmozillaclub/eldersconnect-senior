import 'package:ec_senior/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ec_senior/blocs/authentication_bloc/authentication_event.dart';
import 'package:ec_senior/blocs/login_bloc/bloc.dart';
import 'package:ec_senior/blocs/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc, @required this.userRepository})
      : assert(authenticationBloc != null),
        assert(userRepository != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is GoogleSignInButtonPressed)
      try {
        final FirebaseUser _user = await this.userRepository.signInWithGoogle();
        this.authenticationBloc.add(LoggedIn(firebaseUser: _user));
        yield Success(_user);
      } catch (error) {
        yield Failure(error.toString());
      }
  }
}
