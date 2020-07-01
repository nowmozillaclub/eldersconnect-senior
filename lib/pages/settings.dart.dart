import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashBoardPage(),
    );
  }
}

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  List<Color> _backgroundColor;
  Color _iconColor;
  Color _textColor;
  List<Color> _actionContainerColor;
  Color _borderContainer;
  bool colorSwitched = false;
  var logoImage;

  void changeTheme() async {
     {
      setState(() {
        logoImage = 'assets/name.png';
        _borderContainer = Colors.purple;
        _backgroundColor = [
          Color.fromRGBO(249, 249, 249, 1),
          Color.fromRGBO(241, 241, 241, 1),
          Color.fromRGBO(233, 233, 233, 1),
          Color.fromRGBO(222, 222, 222, 1),
        ];
        _iconColor = Colors.white;
        _textColor = Colors.white;
        _actionContainerColor = [
          Colors.purple,
          Colors.purple,
          Colors.purple,
          Colors.purple,
        ];
      });
    }
  }

  @override
  void initState() {
    changeTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.2, 0.3, 0.5, 0.8],
                    colors: _backgroundColor)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  logoImage,
                  fit: BoxFit.contain,
                  height: 100.0,
                  width: 100.0,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Hello',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      'Jagrit',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  height: 220.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: _borderContainer,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.2, 0.4, 0.6, 0.8],
                              colors: _actionContainerColor)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         
                          // Divider(
                          //   height: 0.5,
                          //   color: Colors.grey,
                          // ),
                          Table(
                            border: TableBorder.symmetric(
                              inside: BorderSide(
                                  color: Colors.purple,
                                  style: BorderStyle.solid,
                                  width: 0.5),
                            ),
                            children: [
                              TableRow(children: [
                                _actionList(
                                        'assets/edit (1).png', 'Change Name'),
                                                                        _actionList(
                                                                            'assets/name.png', 'Change Photo'),
                                                                      ]),
                                                                      TableRow(children: [
                                                                       
                                                                        
                                                                    _actionListSenior('assets/edit.png',
                                                                        
                                                                        'Change Senior Name'),
                                                                    _actionListSenior('assets/name (1).png',

                                                                        'Change Senior Photo')
                                                                  ])
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          
                                        );
                                      }
                                    
                                    // custom action widget
                                      Widget _actionList(String iconPath, String desc) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             
                                              Image.asset(
                                                iconPath,
                                                fit: BoxFit.contain,
                                                height: 45.0,
                                                width: 45.0,
                                                color: _iconColor,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                desc,
                                                style: TextStyle(color: _textColor),
                                              ),
                                              
                                             
                                               
                                            ],
                                          ),
                                        );
                                      }

                                      Widget _actionListSenior(String iconPath, String desc) {
                                        return Container(
                                           decoration: BoxDecoration(
                                              color: Colors.purple,
                          borderRadius: BorderRadius.all(
                              // topLeft: Radius.circular(25),
                              // topRight: Radius.circular(25)
                              Radius.circular(25),
                              ),
                              
                                           ),
                                           
                                         child :Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          
                                          child: Column(
                                            
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                             
                                              Image.asset(
                                                iconPath,
                                                fit: BoxFit.contain,
                                                height: 45.0,
                                                width: 45.0,
                                                color: _iconColor,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                desc,
                                                style: TextStyle(color: _textColor),
                                              ),
                                              
                                             
                                               
                                            ],
                                          ),
                                        )
                                        );
                                      }
                                    }

                                    
                                    
                                  
