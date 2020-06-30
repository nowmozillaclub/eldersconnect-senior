import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileDetailTile extends StatefulWidget {
  final String heading;
  final String data;
  final bool editable;
  final VoidCallback onTap;

  ProfileDetailTile({this.heading, this.data, this.editable, this.onTap});

  @override
  _ProfileDetailTileState createState() => _ProfileDetailTileState();
}

class _ProfileDetailTileState extends State<ProfileDetailTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Container(
        height: 130.0,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                  child: Text('${widget.heading}',
                    style: MyTextStyles.title,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                  child: Text(widget.data??'No data',
                    style: widget.data==null?
                    MyTextStyles().variationOfExisting(existing: MyTextStyles.subtitle, newColor: MyColors.shadow)
                        :MyTextStyles.subtitle,
                  ),
                )
              ],
            ),
            Builder(
              builder: (context) {
                if(widget.editable)
                  return Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: widget.onTap,
                      splashColor: Colors.yellow,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.edit, size: 24.0,),
                      ),
                    ),
                  );
                else
                  return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

