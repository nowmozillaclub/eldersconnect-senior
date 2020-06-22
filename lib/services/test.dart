import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_widget/carousel_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';



class MyCarousel extends StatefulWidget {

  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
CarouselSlider carouselSlider;

int i=0;
final username ='';
  @override
  Widget build(BuildContext context) {



    return Scaffold(appBar: new AppBar(
     title:Text("jagrit here")
   ),
   body:StreamBuilder(
     stream: Firestore.instance.collection('ques').snapshots(),
     builder: (context, snapshot){
       if(!snapshot.hasData) return Text("hi just coming");
      return Column(
      children: <Widget>[
        
        Text(snapshot.data.documents[0]['name']),

        
      ],
      );
     }
     )

    );
        }
      }