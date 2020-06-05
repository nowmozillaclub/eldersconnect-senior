import 'package:flutter/material.dart';

class CustomTile extends StatefulWidget {
  final String imgPath;
  final VoidCallback onTap;

  CustomTile({this.onTap, this.imgPath});

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        child: Container(
          height: 150.0,
          width: 150.0,
          child: Image.asset(
            '${widget.imgPath}',
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
