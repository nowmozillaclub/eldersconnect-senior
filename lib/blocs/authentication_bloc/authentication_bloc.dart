import 'package:ec_senior/blocs/authentication_bloc/authentication_event.dart';
import 'package:ec_senior/blocs/authentication_bloc/authentication_state.dart';
import 'package:ec_senior/blocs/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final SharedPreferences _prefs;

  AuthenticationBloc({@required UserRepository userRepository, @required SharedPreferences prefs})
      : assert(userRepository != null),
        assert(prefs != null),
        _userRepository = userRepository,
        _prefs = prefs;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted)
      yield* _mapEventToAppStartState();
    else if (event is LoggedIn)
      yield* _mapEventToLoggedInState();
    else if (event is LoggedOut) yield* _mapEventToLoggedOutState();
  }

  Stream<AuthenticationState> _mapEventToAppStartState() async* {
    try {
      bool isFirstLaunch = _prefs.getBool('isFirstLaunch') ?? true;
      bool isUserLoggedIn = _prefs.getString('user') ?? true;
      if (await _userRepository.isSignedIn() && isUserLoggedIn) {
        yield Authenticated(await _userRepository.getUser());
      } else if (isFirstLaunch) {
        yield FirstLaunch();
      } else {
        yield UnAuthenticated();
      }
    } catch (_) {
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapEventToLoggedInState() async* {
    yield Authenticated(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapEventToLoggedOutState() async* {
    yield UnAuthenticated();
  }
}
