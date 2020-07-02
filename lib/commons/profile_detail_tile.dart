import 'package:ec_senior/utils/colors.dart';
import 'package:ec_senior/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ec_senior/services/auth_service.dart';

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

// Alert dialog with updatable text field
class CustomAlterDialog extends StatefulWidget {
  final String initial;

  CustomAlterDialog({this.initial});

  @override
  _CustomAlterDialogState createState() => _CustomAlterDialogState();
}

class _CustomAlterDialogState extends State<CustomAlterDialog> {
  TextEditingController _newData = TextEditingController();
  bool _valid = true;

  bool validate() {
    if (_newData.text.length == 10)
      return true;
    else
      setState(() {
        _newData.text = null;
        _valid = false;
      });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    _newData.text = widget.initial;
    return Container(
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
              child: Text('New Phone Number', style: MyTextStyles.title,),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                  child: Text('+91'),
                ),
                Flexible(
                  child: TextField(
                    controller: _newData,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      errorText: _valid?null:'Invalid Number',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,)
          ],
        ),
          actions: <Widget>[
            FlatButton(
              child: Text('CLOSE', style: MyTextStyles.subtext,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlineButton(
              child: Text('ADD',
                style: MyTextStyles().variationOfExisting(
                  existing: MyTextStyles.subtext, newColor: MyColors.primary,
                ),
              ),
              borderSide: BorderSide(
                color: MyColors.primary,
                width: 1.0,
              ),
              onPressed: () async {
                if(validate()) {
                  Navigator.of(context).pop();
                  await auth.verifyAndChangePhone(_newData.text);
                }
              },
            )
          ],
      ),
    );
  }
}

void showCustom(BuildContext context, String initial) {
  showDialog(
      context: context,
      builder: (context) {
        return CustomAlterDialog(
          initial: initial,
        );
      }
  );
}