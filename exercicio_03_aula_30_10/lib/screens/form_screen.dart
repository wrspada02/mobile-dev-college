import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _dob = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Flutter Form Demo", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Name',
                ),
                onSaved: (value) => _name = value ?? '',
              ),

              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: 'Phone',
                ),
                keyboardType: TextInputType.phone,
                onSaved: (value) => _phone = value ?? '',
              ),

              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: 'Dob',
                ),
                onSaved: (value) => _dob = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();

                  // Mostra Snackbar com os dados
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Name: $_name, Phone: $_phone, Dob: $_dob"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 82, 84, 85),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
