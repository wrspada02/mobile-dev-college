import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Add sample data to Firestore
  await addSampleData();
  
  print('Sample data added successfully!');
}

Future<void> addSampleData() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference tasks = firestore.collection('tasks');

  // Sample tasks
  final List<Map<String, dynamic>> sampleTasks = [
    {
      'description': 'Comprar pão',
      'date': Timestamp.fromDate(DateTime(2025, 10, 30)),
      'finished': false,
      'time': '10:00 AM',
    },
    {
      'description': 'Estudar Flutter',
      'date': Timestamp.fromDate(DateTime(2025, 10, 31)),
      'finished': false,
      'time': '2:00 PM',
    },
    {
      'description': 'Ligar para o João',
      'date': Timestamp.fromDate(DateTime(2025, 11, 1)),
      'finished': true,
      'time': '9:00 AM',
    },
    {
      'description': 'Exercícios',
      'date': Timestamp.fromDate(DateTime(2025, 11, 2)),
      'finished': false,
      'time': '6:00 PM',
    },
    {
      'description': 'Fazer almoço',
      'date': Timestamp.fromDate(DateTime(2025, 11, 3)),
      'finished': false,
      'time': '12:00 PM',
    },
  ];

  // Add each task to Firestore
  for (final task in sampleTasks) {
    await tasks.add(task);
    print('Added task: ${task['description']}');
  }
}