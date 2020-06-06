import 'package:flutter/material.dart';
import 'package:carousel_widget/carousel_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';



class MyCarousel extends StatelessWidget {

CarouselSlider carouselSlider;
int i=0;
  @override
  Widget build(BuildContext context) {

    initializeData();

    return Scaffold(
      backgroundColor: Colors.white,
      body:
          Carousel(
            listViews: [
              Fragment(
                child: getScreen(0),
              ),
              Fragment(
                child: getScreen(1),
              ),
              Fragment(
                child: getScreen(2),
              )
            ],
          )
    );
  }

  Widget getScreen(index) {
    return new ListView(
      children: <Widget>[
        new Container(
          height: 45.0,
          margin: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
          child: Text(
            titles.elementAt(index-i),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20,color:Colors.red),
          ),
        ),
        new Container(
          height: 250.0,
          margin: const EdgeInsets.fromLTRB(20.0, 90.0, 20.0, 0.0),
          child: Image.asset(
            imagenames.elementAt(index-i),
          ),
        ),
        
        new Container(
          height: 100.0,
          margin: const EdgeInsets.fromLTRB(50.0, 12.0, 50.0, 0.0),
          child: Text(
            description.elementAt(index-i),
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
                        onPressed: goToNext,
                        child: Icon(Icons.close, color: Colors.red),
                        backgroundColor: Colors.white,
                      ),
                      FloatingActionButton(
                        elevation: 4.0,
                        onPressed: goToNext,
                        child: Icon(Icons.assignment_turned_in, color: Colors.green),
                        backgroundColor: Colors.white,
                      ),
                        
                      FloatingActionButton(
                        elevation: 4.0,
                        onPressed: () {} ,
                        child: Icon(Icons.add_alarm, color: Colors.pink),
                        backgroundColor: Colors.white,
                      )
                    ],
                  ),
              
           )
      ],
    );
  }
 goToPrevious() {
    i=i+1;
  }
 
  goToNext() {
    i=i-1;
}
  List<String> titles = List();
  List<String> description = List();
  List<String> imagenames = List();

  void initializeData() {
    titles.add("Hello Jagrit");
    description.add("Do you have a fever");
    imagenames.add("assets/graphics/emergency.png");

    titles.add("Question from Urmil");
    description.add(
        "How is your leg pain");
    imagenames.add("assets/graphics/man.png");

    titles.add("Hello Jagrit");
    description.add(
"what about HeadAche");
    imagenames.add("assets/graphics/emergency.png");
  }
}

