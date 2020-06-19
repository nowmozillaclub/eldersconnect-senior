import 'package:cached_network_image/cached_network_image.dart';
import 'package:ec_senior/services/auth_service.dart';
import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      body: ChangeNotifierProvider<AuthService>(
        create: (context) => AuthService(),
        child: CustomScrollView(
          slivers: <Widget>[
            Consumer<AuthService>(
              builder: (context, auth, child) {
                return SliverPersistentHeader(
                      delegate: MyDelegate(image: auth.user.photoUrl),
                      pinned: true,
                    );
              },
            ),
            Consumer<AuthService>(
              builder: (context, auth, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return Card(
                        elevation: 8.0,
                        child: Container(
                          height: 170.0,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 8.0, 0.0, 0.0),
                                    child: Text('${details[index]}',
                                      style: MyTextStyles.title,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 0.0, 0.0, 0.0),
                                    child: Text('${details[index]} dataaa',
                                      style: MyTextStyles.subtitle,
                                    ),
                                  )
                                ],
                              ),
                              Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () {
                                    print('tapped');
                                  },
                                  splashColor: MyColors.primary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.edit, size: 24.0,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: details.length,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}



class MyDelegate extends SliverPersistentHeaderDelegate {
  final String image;

  MyDelegate({this.image});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(image),
                  fit: BoxFit.cover
              )
          ),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [MyColors.primary, Colors.transparent],
                  stops: [0.01 + (shrinkOffset/200), 0.2 + (shrinkOffset/200)]
              )
          ),
        ),
        Positioned(
          bottom: 5.0,
          left: 16.0 + (shrinkOffset/200 * (8.0+32.0)),
          child: Text('Profile',
            style: MyTextStyles().variationOfExisting(existing: MyTextStyles.heading, newColor: MyColors.white),
          ),
        ),
        Positioned(
          top: 20.0 * (shrinkOffset/200.0),
          child: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print('leading');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios, size: 24.0, color: MyColors.white,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('trailing');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.menu, size: 24.0, color: MyColors.white,),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 70.0;
}

List<String> details = [
  'Email',
  'Phone Number',
  'Junior Name',
  'Junior Number',
  'Reports',
];