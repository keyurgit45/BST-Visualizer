import 'package:bst_visualizer/consts/my_colors.dart';
import 'package:bst_visualizer/pages/visualization.dart';
import 'package:bst_visualizer/painter/custom_painter.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return Visualizer();
        }
        return Center(
          child: Text(
            "Please view on Laptop/Desktop",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: MyColors.primary),
          ),
        );
      }),
    );
  }
}
