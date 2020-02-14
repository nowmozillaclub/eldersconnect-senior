import 'package:ec_senior/blocs/authentication_bloc/authentication_event.dart';
import 'package:ec_senior/blocs/authentication_bloc/authentication_state.dart';
import 'package:ec_senior/blocs/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

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
      if (await _userRepository.isSignedIn()) {
        yield Authenticated(await _userRepository.getUser());
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
