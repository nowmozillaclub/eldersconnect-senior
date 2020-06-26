
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_widget/carousel_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';




class MyCarousell extends StatelessWidget {

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
      body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('seniors').document("6W10dAKIWpU9UWMSWisVXzhU5Em1").collection("default_ques").snapshots(),

      builder: (context,snapshot){
        if(!snapshot.hasData) return Text(" hi just wait");
            return
             Container(
               child: Column(
                 
                children: <Widget>[
                  
                     
                  Text(snapshot.data.documents[0]['q1'])
                ],
               
            ),
            
             );
             
            
            
            
        },
        
        ),
        
    );
     } }