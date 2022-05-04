import 'package:flutter/material.dart';

class FormStateScreen extends StatefulWidget {
  const FormStateScreen({Key key}) : super(key: key);

  @override
  _FormStateScreenState createState() => _FormStateScreenState();
}

class _FormStateScreenState extends State<FormStateScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email must not be empty";
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  // return false;
                }
              },
              child: Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
