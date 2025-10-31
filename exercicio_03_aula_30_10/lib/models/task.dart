import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String? id;
  final String description;
  final DateTime date;
  final bool finished;
  final String time;

  Task({
    this.id,
    required this.description,
    required this.date,
    required this.finished,
    required this.time,
  });

  // Convert Task to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'date': Timestamp.fromDate(date),
      'finished': finished,
      'time': time,
    };
  }

  // Create Task from Firestore DocumentSnapshot
  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Task(
      id: doc.id,
      description: data['description'] ?? '',
      date: _parseDate(data['date']),
      finished: data['finished'] ?? false,
      time: data['time'] ?? '',
    );
  }

  // Create Task from Map
  factory Task.fromMap(Map<String, dynamic> map, String id) {
    return Task(
      id: id,
      description: map['description'] ?? '',
      date: _parseDate(map['date']),
      finished: map['finished'] ?? false,
      time: map['time'] ?? '',
    );
  }

  // Helper method to parse date from various formats
  static DateTime _parseDate(dynamic dateValue) {
    if (dateValue is Timestamp) {
      return dateValue.toDate();
    } else if (dateValue is String) {
      // Try to parse string date in DD/MM/YYYY format
      try {
        final parts = dateValue.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      } catch (e) {
        // If parsing fails, return current date
        return DateTime.now();
      }
    } else if (dateValue is DateTime) {
      return dateValue;
    }
    // Default fallback
    return DateTime.now();
  }

  // Copy with method for updating tasks
  Task copyWith({
    String? id,
    String? description,
    DateTime? date,
    bool? finished,
    String? time,
  }) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      date: date ?? this.date,
      finished: finished ?? this.finished,
      time: time ?? this.time,
    );
  }
}
