import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatefulWidget {
  final String title;
  final String imgPath;
  final VoidCallback onTap;

  CustomTile({this.onTap, this.imgPath, this.title});

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
        child: Stack(
          children: [
            Container(
              height: 150.0,
              width: 150.0,
              child: Image.asset(
                '${widget.imgPath}',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [MyColors.black.withOpacity(0.0), MyColors.black.withOpacity(0.7)],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  stops: [1.0, 0.2]
                )
              ),
            ),
            Text(widget.title == null ? '${widget.title}': '',
              style: MyTextStyles().variationOfExisting(existing: MyTextStyles.subtitle, newColor: MyColors.white),
            ),
          ],
        )
      ),
      onTap: widget.onTap,
    );
  }
}
