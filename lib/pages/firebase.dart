

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_widget/carousel_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';



class MyCarousel extends StatelessWidget {

CarouselSlider carouselSlider;
int i=0;
  @override
  Widget build(BuildContext context) {

    // initializeData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:new Text("firestore"),
      ),
      body: StreamBuilder(
      stream: Firestore.instance.collection('ques').snapshots(),

      builder: (context,snapshot){
        if(!snapshot.hasData) return Text(" hi just wait");
            return
             Container(
               child: Column(
                children: <Widget>[
                  Text(snapshot.data.documents[1]['name'])
                ],
               
            ),
            
             );
             
            
            
            
        },
        
        ),
        
    );
     } }