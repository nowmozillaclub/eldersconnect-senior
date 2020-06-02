import 'package:cached_network_image/cached_network_image.dart';
import 'package:ec_senior/models/user_repository.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => UserRepository(),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Consumer<UserRepository>(
                builder: (context, userRepo, child) {
                  return FutureBuilder(
                        future: userRepo.getUser(),
                        builder: (context, user) {
                          if(user.connectionState == ConnectionState.waiting) {
                            return Text('Loading...');
                          }
                          else {
                            return Container(
                                color: MyColors.white,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 70.0,
                                      ),
                                      Hero(
                                        tag: 'icon',
                                        child: Container(
                                          width: 50.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(user.data.photoUrl),
                                            ),
                                          ),
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
                                          GestureDetector(
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              elevation: 5.0,
                                              child: Container(
                                                height: 150.0,
                                                width: 150.0,
                                                child: Image.asset(
                                                  'assets/graphics/heart.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            onTap: () => print('Card tapped'),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          GestureDetector(
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              elevation: 5.0,
                                              child: Container(
                                                height: 150.0,
                                                width: 150.0,
                                                child: Image.asset(
                                                  'assets/graphics/man.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
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
                                          GestureDetector(
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              elevation: 5.0,
                                              child: Container(
                                                height: 150.0,
                                                width: 150.0,
                                                child: Image.asset(
                                                  'assets/graphics/moon.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            onTap: () => print('Card tapped'),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          GestureDetector(
                                            child: Card(
                                              semanticContainer: true,
                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              elevation: 5.0,
                                              child: Container(
                                                height: 150.0,
                                                width: 150.0,
                                                child: Image.asset(
                                                  'assets/graphics/emergency.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            onTap: () => print('Card tapped'),
                                          ),
                                        ],
                                      ),
                                    ],
                                ),
                            );
                          }
                        },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



