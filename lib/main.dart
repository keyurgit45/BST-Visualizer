import 'package:bst_visualizer/consts/my_colors.dart';
import 'package:bst_visualizer/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BST',
      theme: ThemeData(primaryColor: MyColors.primary),
      home: HomePage(),
    );
  }
}
