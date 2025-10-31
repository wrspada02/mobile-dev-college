import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class FirestoreMigration {
  static Future<void> migrateStringDatesToTimestamps() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference tasks = firestore.collection('tasks');

    try {
      // Get all documents
      QuerySnapshot snapshot = await tasks.get();
      
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        
        // Check if date is a string
        if (data['date'] is String) {
          String dateString = data['date'];
          DateTime parsedDate;
          
          try {
            // Try to parse DD/MM/YYYY format
            final parts = dateString.split('/');
            if (parts.length == 3) {
              final day = int.parse(parts[0]);
              final month = int.parse(parts[1]);
              final year = int.parse(parts[2]);
              parsedDate = DateTime(year, month, day);
            } else {
              parsedDate = DateTime.now();
            }
          } catch (e) {
            parsedDate = DateTime.now();
          }
          
          // Update the document with Timestamp
          await doc.reference.update({
            'date': Timestamp.fromDate(parsedDate),
          });
          
          print('Migrated document ${doc.id}: $dateString -> ${parsedDate.toString()}');
        }
      }
      
      print('Migration completed successfully');
    } catch (e) {
      print('Migration failed: $e');
    }
  }
}

// Standalone script to run migration
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  print('Starting Firestore date migration...');
  await FirestoreMigration.migrateStringDatesToTimestamps();
}