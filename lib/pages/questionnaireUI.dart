import 'package:cloud_firestore/cloud_firestore.dart';

      import 'package:carousel_widget/carousel_widget.dart';
      import 'package:carousel_slider/carousel_slider.dart';
      import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

      // import 'package:url_launcher/url_launcher.dart';

      class MyCarousel extends StatefulWidget {

        @override
        _MyCarouselState createState() => _MyCarouselState();

      }
      class _MyCarouselState extends State<MyCarousel> {
      CarouselSlider carouselSlider;
      final dbref = FirebaseDatabase.instance.reference();
      bool done = false;
      bool left = false;
      bool emergency=false;

      int i=0;
     
        @override
        Widget build(BuildContext context) {
          // final Firestore db = Firestore.instance;
          //  Stream slides;
           
     
          initializeData();

          return Scaffold(
            backgroundColor: Colors.white,
            body:
                Carousel(
                  listViews: [
                    Fragment(
                      child: getScreen(i),
                    ),
                  
                  ],
                ),
                
          );
          
        }
       

        Widget getScreen(jag) {
          
          return new ListView(
            children: <Widget>[
              new Container(
                height: 45.0,
                margin: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
                child: Text(
                titles.elementAt(jag),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20,color:Colors.red),
                ),
              ),
              new Container(
                height: 250.0,
                margin: const EdgeInsets.fromLTRB(20.0, 90.0, 20.0, 0.0),
                child: Image.asset(
                  "assets/graphics/emergency.png",
                ),
              ),
              
              
              new Container(
                height: 100.0,
                margin: const EdgeInsets.fromLTRB(50.0, 12.0, 50.0, 0.0),
                child: Text(
               description.elementAt(jag),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                        //transform: Matrix4.translationValues(0.0, fabButtonanim.value * devHeight, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton(
                              elevation: 4.0,
                              onPressed: goToUndoneNext,
                              child: Icon(Icons.close, color: Colors.red),
                              backgroundColor: Colors.white,
                            ),
                            FloatingActionButton(
                              elevation: 4.0,
                              onPressed: goToDoneNext,
                              child: Icon(Icons.assignment_turned_in, color: Colors.green),
                              backgroundColor: Colors.white,
                            ),
                              
                            FloatingActionButton(
                              elevation: 4.0,
                              onPressed: emergencypress,
                              child: Icon(Icons.add_alarm, color: Colors.pink),
                              backgroundColor: Colors.white,
                            )
                          ],
                        ),
                    
                ),
                
            ],
          );
        }

        goToUndoneNext() {
         
          left = true;
          // _responses(done,left,emergency);
          setState(() {
            i=i+1;
          });
         
         
           
           
      }

      goToDoneNext() {
        done = true;
      //  _responses(done,left,emergency);
          setState(() {
            i=i+1;
            
          });
      }

//       _launchMaps() async {
//   const url = "https://www.google.com/maps/search/?api=1&query=LATITUDE,LONGITUDE,17&query_place_id=PLACE_ID";
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch Maps';
//   }
// }

      emergencypress() {       
        emergency = true;
      //  _responses(done,left,emergency);
       setState(() {
            i=i;
          });
      }

        List<String> titles = List();

        List<String> description = List();

        List<String> imagenames = List();

        void initializeData() {
          
      //     StreamBuilder(
      // stream: Firestore.instance.collection('ques').snapshots(),

      // builder: (context,snapshot){
      //   if(!snapshot.hasData) return Text(" hi just wait");
      //       return
      //        Container(
      //          child: Column(
      //           children: <Widget>[
      //             Text(snapshot.data.documents[1]['name'])
      //           ],
               
      //       ),
            
      //        );
             
            
            
            
      //   },
        
      //   ),
      
            titles.add("Hello Jagrit");        
          description.add(
              "How is your leg pain");
          imagenames.add("assets/graphics/man.png");
          
            titles.add("Hello Jagrit");
          description.add(
      "what about HeadAche");
          imagenames.add("assets/graphics/emergency.png");
        

          titles.add("Hello jags");
          description.add(
      "what about HeadAche");
        imagenames.add("assets/graphics/emergency.png");
        }

      }
    //  // saving the responses onto firebase
    Future<void> _responses(bool one,bool two,bool three,) async {
    bool done = one;
    bool not_done = two;
    bool emergency = three;
    String answer="";

    if(done)  answer = "Done";
    else if (not_done)  answer = "remaining";
    else if (emergency)  answer = "emergency";
   

      }

      