import 'package:cached_network_image/cached_network_image.dart';
import 'package:ec_senior/commons/popup_menu.dart';
import 'package:ec_senior/commons/profile_detail_tile.dart';
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

  TextEditingController _newData = TextEditingController();

  bool validate() {
    return _newData.text.length == 10;
  }

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
                        delegate: ProfileDelegate(image: auth.user.photoUrl, name: auth.user.name),
                        pinned: true,
                      );
                },
              ),
            Consumer<AuthService>(
              builder: (context, auth, child) {
                return SliverToBoxAdapter(
                  child: ProfileDetailTile(
                    heading: 'Email',
                    data: auth.user.email,
                    editable: false,
                  ),
                );
              },
            ),
            Consumer<AuthService>(
              builder: (context, auth, child) {
                return SliverToBoxAdapter(
                  child: ProfileDetailTile(
                    heading: 'Phone Number',
                    data: auth.user.phone,
                    editable: true,
                    onTap: () {
                      showCustom(context, auth.user.phone);
                    },
                  ),
                );
              },
            ),
            Consumer<AuthService>(
              builder: (context, auth, child) {
                return SliverToBoxAdapter(
                  child: ProfileDetailTile(
                    heading: 'Junior Name',
                    data: auth.user.connectedToName,
                    editable: false,
                  ),
                );
              },
            ),
            Consumer<AuthService>(
              builder: (context, auth, child) {
                return SliverToBoxAdapter(
                  child: ProfileDetailTile(
                    heading: 'Junior Id',
                    data: auth.user.connectedToUid,
                    editable: false,
                  ),
                );
              },
            ),
            Consumer<AuthService>(
              builder: (context, auth, child) {
                return SliverToBoxAdapter(
                  child: ProfileDetailTile(
                    heading: 'Junior Phone Number',
                    data: auth.user.connectedToPhone,
                    editable: true,
                    onTap: () {
                      showDialog(
                          context: context,
                        child: AlertDialog(
                          content: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 0),
                                  child: Icon(Icons.warning),
                                ),
                                Builder(
                                  builder: (context) {
                                    if(auth.user.connectedToPhone == null)
                                      return Expanded(
                                          child: Text("YOUR JUNIOR DOES NOT HAVE A PHONE NUMBER REGISTERED."
                                              "\nTO ADD PHONE NUMBER AND ACTIVATE SOS BUTTON ASK JUNIOR TO ADD CONTACT INFO USING THE JUNIOR APP.")
                                      );
                                    else
                                      return Expanded(
                                          child: Text("TO CHANGE CONNECT TO A NEW JUNIOR USING THE RECCONECT TO JUNIOR OPTION")
                                      );
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      );
                    },
                  ),
                );
              },
            ),
            Consumer<AuthService>(
              builder: (context, auth, child) {
                return SliverToBoxAdapter(
                  child: ProfileDetailTile(
                    heading: 'SOS Status',
                    data: auth.user.sosStatus?'Active':'Inactive',
                    editable: !auth.user.sosStatus,
                    onTap: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
                                  child: Builder(
                                    builder: (context) {
                                      if(auth.user.phone == null)
                                        return Container(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(Icons.warning),
                                                ),
                                                Container(
                                                    child: Expanded(
                                                        child: Text('TO ENABLE SOS BUTTON ADD PHONE NUMBER')
                                                    )
                                                ),
                                              ],
                                            )
                                        );
                                      else
                                        return Container();
                                    }
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
                                  child: Builder(
                                    builder: (context) {
                                      if(auth.user.connectedToPhone == null)
                                        return Container(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(Icons.warning),
                                                ),
                                                Container(
                                                    child: Expanded(
                                                        child: Text('TO ENABLE SOS BUTTON ADD JUNIOR\'S PHONE NUMBER')
                                                    )
                                                ),
                                              ],
                                            )
                                        );
                                      else
                                        return Container();
                                    },
                                  ),
                                ),
                              ],
                            )
                          )
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



class ProfileDelegate extends SliverPersistentHeaderDelegate {
  final String image;
  final String name;

  ProfileDelegate({this.image, this.name});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: 'icon',
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(image),
                    fit: BoxFit.cover
                )
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [MyColors.primary, Colors.transparent],
                  stops: [0.01 + (shrinkOffset/maxExtent), 0.2 + (shrinkOffset/maxExtent)]
              )
          ),
        ),
        Positioned(
          bottom: 5.0,
          left: 16.0 + (shrinkOffset/maxExtent * 32.0),
          child: Text('$name',
            style: MyTextStyles().variationOfExisting(existing: MyTextStyles.heading, newColor: MyColors.white),
          ),
        ),
        Positioned(
          top: 20.0,
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
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios, size: 24.0, color: MyColors.white,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomPopUpMenu(),
                ),
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
  double get maxExtent => 300.0;

  @override
  double get minExtent => 70.0;
}

//TODO: Smoll bug fix later

//AlertDialog(
//content: Column(
//mainAxisSize: MainAxisSize.min,
//children: <Widget>[
//Padding(
//padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
//child: Text('New Phone Number', style: MyTextStyles.title,),
//),
//Row(
//children: <Widget>[
//Padding(
//padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
//child: Text('+91'),
//),
//Flexible(
//child: TextField(
//controller: _newData,
//keyboardType: TextInputType.phone,
//decoration: InputDecoration(
//errorText: _valid?null:'Invalid Number',
//),
//),
//),
//],
//),
//SizedBox(height: 20.0,)
//],
//),
//actions: <Widget>[
//FlatButton(
//child: Text('CLOSE', style: MyTextStyles.subtext,),
//onPressed: () {
//Navigator.of(context).pop();
//},
//),
//OutlineButton(
//child: Text('ADD',
//style: MyTextStyles().variationOfExisting(
//existing: MyTextStyles.subtext, newColor: MyColors.primary,
//),
//),
//borderSide: BorderSide(
//color: MyColors.primary,
//width: 1.0,
//),
//onPressed: () async {
//setState(() {
//_valid = validate();
//});
//if(_valid) {
//Navigator.of(context).pop();
//await auth.verifyAndChangePhone(_newData.text);
//}
//else {
//
//}
//},
//)
//],
//)