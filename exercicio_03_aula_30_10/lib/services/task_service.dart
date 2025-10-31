import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class TaskService {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance
      .collection('tasks');

  // Get all tasks as a stream
  Stream<List<Task>> getTasks() {
    return _tasksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        try {
          return Task.fromFirestore(doc);
        } catch (e) {
          print('Error parsing task ${doc.id}: $e');
          print('Document data: ${doc.data()}');
          rethrow;
        }
      }).toList();
    });
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    try {
      await _tasksCollection.add(task.toMap());
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    try {
      if (task.id != null) {
        await _tasksCollection.doc(task.id).update(task.toMap());
      }
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  // Toggle task completion status
  Future<void> toggleTaskCompletion(Task task) async {
    try {
      if (task.id != null) {
        await _tasksCollection.doc(task.id).update({
          'finished': !task.finished,
        });
      }
    } catch (e) {
      throw Exception('Failed to toggle task completion: $e');
    }
  }
}
