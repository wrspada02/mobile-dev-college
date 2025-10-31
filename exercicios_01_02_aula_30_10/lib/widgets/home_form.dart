import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);
  
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  // Text controllers to capture input from TextFields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _saveDataToFirestore() async {
    try {
      String name = _nameController.text.trim();
      String phone = _phoneController.text.trim();
      String date = _dateController.text.trim();

      // Validate that fields are not empty
      if (name.isEmpty || phone.isEmpty || date.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please fill in all fields'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      await _firestore.collection('users').add({
        'nome': name,
        'telefone': phone,
        'data': date,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }

      _nameController.clear();
      _phoneController.clear();
      _dateController.clear();

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        spacing: 20,
        children: [
          TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              )
          ),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Telefone',
              hintText: 'Phone',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
            )
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(
              labelText: 'Data',
              hintText: 'Dob',
              prefixIcon: Icon(Icons.calendar_month),
              border: OutlineInputBorder(),
            )
          ),
          ElevatedButton(
            onPressed: _saveDataToFirestore,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}