import 'package:cached_network_image/cached_network_image.dart';
import 'package:ec_senior/commons/bottom_nav_bar.dart';
import 'package:ec_senior/commons/display_picture.dart';
import 'package:ec_senior/commons/custom_tile.dart';
import 'package:ec_senior/commons/pop_up_questions.dart';
import 'package:ec_senior/pages/account_detail_page.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/services/questionnaire_provider.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<dynamic> quesForPopUp = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      Questionnaire questionnaire = Provider.of<Questionnaire>(context, listen: false);
      questionnaire.getQuestionnaire().then((onValue) {
        if(questionnaire.questions.length != 0) {
          quesForPopUp = questionnaire.questions;
          _showPopUpQuestion();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AuthService(),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //TODO: Add Material Banner
              SizedBox(
                height: 90.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AccountPage()));
                },
                child: Consumer<AuthService>(
                  builder: (context, auth, child) {
                    return Container(
                            color: MyColors.white,
                            child: Hero(
                              tag: 'icon',
                              child: DisplayPicture(img: CachedNetworkImageProvider(auth.user.photoUrl),)
                            ),
                          );
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'EldersConnect Senior',
                style: MyTextStyles.heading,
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomTile(
                    imgPath: 'assets/graphics/heart.png',
                    onTap: () => print('Card tapped'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CustomTile(
                    imgPath: 'assets/graphics/man.png',
                    onTap: () => print('Card tapped'),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomTile(
                    imgPath: 'assets/graphics/moon.png',
                    onTap: () => print('Card tapped'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CustomTile(
                    imgPath: 'assets/graphics/emergency.png',
                    onTap: () => print('Card tapped'),
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentSelected: currentSelectedNavBar,),
    );
  }

  _showPopUpQuestion() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          AuthService _auth = Provider.of<AuthService>(context);
          return Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 32.0, 0.0, 16.0),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      left: 20.0,
                      top: 25.0,
                      child: PopUpQuestion(questionsAndOptions: quesForPopUp,)
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: CachedNetworkImageProvider(_auth.user.photoUrl),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}