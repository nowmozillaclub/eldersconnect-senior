import 'package:ec_senior/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ec_senior/blocs/authentication_bloc/authentication_event.dart';
import 'package:ec_senior/blocs/repositories/user_repository.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository _userRepository = UserRepository();
  runApp(BlocProvider(
    create: (context) =>
        AuthenticationBloc(userRepository: _userRepository)..add(AppStarted()),
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EldersConnect Senior',
      theme: ThemeData(
        primaryColor: MyColors.primary,
        accentColor: MyColors.accent,
        fontFamily: 'LexendDeca',
      ),
      home: FirstPage(),
    );
  }
}
