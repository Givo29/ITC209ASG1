import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _firstname = '';
  String _lastname = '';
  String _email = '';
  String _studentId = '';
  String _address = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _displayFailureDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invalid Data"),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
              if (_firstname != '') Text(_firstname),
              if (_lastname != '') Text(_lastname),
              if (_email != '') Text(_email),
              if (_studentId != '') Text(_studentId),
              if (_address != '') Text(_address),
            ])
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _displaySuccessDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Student Details'),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
              Text('Name: ${_firstname} ${_lastname}'),
              Text('Email: ${_email}'),
              Text('Student ID: ${_studentId}'),
              Text('Address: ${_address}'),
            ]),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildFirstname() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'First Name',
      ),
      validator: (String? value) {
        _firstname = '';
        if (value!.isEmpty) {
          _firstname = "First name is required";
          return _firstname;
        }

        if (!RegExp(r'^[a-zA-Z .-]+$').hasMatch(value)) {
          _firstname = 'First name can only contain alphabet and ".", "-"';
          return _firstname;
        }

        return null;
      },
      onSaved: (String? value) {
        _firstname = value!;
      },
    );
  }

  Widget _buildLastname() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Last Name',
      ),
      validator: (String? value) {
        _lastname = '';
        if (value!.isEmpty) {
          _lastname = 'Last name is required';
          return _lastname;
        }

        if (!RegExp(r'^[a-zA-Z .-]+$').hasMatch(value)) {
          _lastname = 'Last name can only contain alphabet and ".", "-"';
          return _lastname;
        }

        return null;
      },
      onSaved: (String? value) {
        _lastname = value!;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Email',
        ),
        validator: (String? value) {
          _email = '';
          if (value!.isEmpty) {
            _email = 'Email is required';
            return _email;
          }

          if (!RegExp(
                  r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')
              .hasMatch(value)) {
            _email = 'Please return a valid email';
            return _email;
          }

          return null;
        },
        onSaved: (String? value) {
          _email = value!;
        });
  }

  Widget _buildStudentId() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Student ID',
      ),
      validator: (String? value) {
        _studentId = '';
        if (value!.isEmpty) {
          _studentId = 'Student ID is required';
          return _studentId;
        }

        if (value.length != 7) {
          _studentId = 'Student ID must be 7 digits long';
          return _studentId;
        }

        if (value[0] == '0') {
          _studentId = 'Student ID cannot start with 0';
          return _studentId;
        }

        return null;
      },
      onSaved: (String? value) {
        _studentId = value!;
      },
    );
  }

  Widget _buildAddress() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Address',
        ),
        validator: (String? value) {
          _address = '';
          if (value!.isEmpty) {
            _address = 'Address is required';
            return _address;
          }
        },
        onSaved: (String? value) {
          _address = value!;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Form")),
      body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildFirstname(),
                  _buildLastname(),
                  _buildEmail(),
                  _buildStudentId(),
                  _buildAddress(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text('Submit',
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
                    onPressed: () => {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save(), 
                        _displaySuccessDialog()
                      } else {
                        _displayFailureDialog(),
                      },
                    },
                  )
                ],
              ))),
    );
  }
}
