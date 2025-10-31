import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:input_e_dialog/screens/task_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: FormScreen(),
      //home: FabBottomItem(),
      home: const TaskScreen(),
    );
  }
}
