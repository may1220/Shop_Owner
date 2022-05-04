import 'package:flutter/material.dart';

class ShowAlertBOx extends StatefulWidget {
  final title;
  const ShowAlertBOx({this.title, Key key}) : super(key: key);

  @override
  _ShowAlertBOxState createState() => _ShowAlertBOxState();
}

class _ShowAlertBOxState extends State<ShowAlertBOx> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(widget.title.toString())),
      actions: [
        Center(
          child: TextButton(
            child: const Text('OK',
                style: TextStyle(color: Color(0xFF6600cc), fontSize: 20)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        )
      ],
    );
  }
}
