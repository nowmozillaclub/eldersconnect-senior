import 'package:ec_senior/blocs/authentication_bloc/bloc.dart';
import 'package:ec_senior/blocs/authentication_bloc/delegate.dart';
import 'package:ec_senior/blocs/repositories/user_repository.dart';
import 'package:ec_senior/pages/home_page.dart';
import 'package:ec_senior/pages/login_page.dart';
import 'package:ec_senior/pages/splash_page.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = AuthenticationBlocDelegate();
  final UserRepository _userRepository = UserRepository();
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  runApp(BlocProvider(
    create: (context) =>
        AuthenticationBloc(userRepository: _userRepository, prefs: _prefs)
          ..add(AppStarted()),
    child: App(prefs: _prefs,),
  ));
}

class App extends StatelessWidget {
  final SharedPreferences prefs;

  App({Key key, @required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EldersConnect Senior',
      theme: ThemeData(
        primaryColor: MyColors.primary,
        accentColor: MyColors.accent,
        fontFamily: 'LexendDeca',
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashPage();
          }
          if (state is UnAuthenticated) {
            return MyLoginPage(prefs: prefs);
          }
          if (state is Authenticated) {
            return MyHomePage(prefs: prefs);
          }
          return Container();
        },
      ),
    );
  }
}
