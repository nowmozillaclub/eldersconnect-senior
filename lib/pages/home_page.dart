import 'package:cached_network_image/cached_network_image.dart';
import 'package:ec_senior/commons/custom_tile.dart';
import 'package:ec_senior/services/auth_service.dart';
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
              SizedBox(
                height: 90.0,
              ),
              Consumer<AuthService>(
                builder: (context, auth, child) {
                  return FutureBuilder(
                    future: auth.getUser(),
                    builder: (context, user) {
                      if(user.connectionState == ConnectionState.waiting)
                        return Text("Loading...");
                      else
                        return Container(
                          color: MyColors.white,
                          child: Hero(
                            tag: 'icon',
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(user.data.photoUrl)
                                )
                              ),
                            ),
                          ),
                        );
                    },
                  );
                },
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
    );
  }
}



