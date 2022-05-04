import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_owner/helpers/styleguide.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<String> friendsList = [null];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Dynamic TextFormFields'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name textfield
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'Enter your name'),
                  validator: (v) {
                    if (v.trim().isEmpty) return 'Please enter something';
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Add Friends',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              ..._getFriends(),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
                child: Text('Submit'),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// get firends text-fields
  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < friendsList.length; i++) {
      friendsTextFields.add(Row(
        children: [
          Expanded(child: FriendTextFields(i)),
          SizedBox(
            width: 16,
          ),
          // we need add button at last friends row
          _addRemoveButton(i == friendsList.length - 1, i),
        ],
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, null);
        } else
          friendsList.removeAt(index);
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        height: 36,
        width: 38,
        decoration: BoxDecoration(
          color: (add) ? color : Colors.red,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.black38),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Icon(
          (add) ? FontAwesomeIcons.plus : Icons.remove,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _MyFormState.friendsList[widget.index] ?? '';
    });

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: leftPadding,
      child: TextFormField(
        style: editTextStyle,
        controller: _nameController,
        onChanged: (v) => _MyFormState.friendsList[widget.index] = v,
        decoration: InputDecoration(
          hintText: 'Share available space with',
          border: InputBorder.none,
        ),
        validator: (v) {
          if (v.trim().isEmpty) return 'Please enter something';
          return null;
        },
      ),
    );
  }
}
