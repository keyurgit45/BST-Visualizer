import 'package:bst_visualizer/consts/my_colors.dart';
import 'package:bst_visualizer/pages/visualization.dart';
import 'package:bst_visualizer/painter/custom_painter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primary,
          title: const Text("Binary Search Tree Visualizer"),
          elevation: 0.1,
        ),
        body: Visualizer());
  }
}
