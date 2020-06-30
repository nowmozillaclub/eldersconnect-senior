import 'package:flutter/material.dart';

class DisplayPicture extends StatefulWidget {
  final ImageProvider img;

  DisplayPicture({@required this.img});

  @override
  _DisplayPictureState createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: widget.img,
          )
      ),
    );
  }
}
