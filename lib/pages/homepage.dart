import 'package:bst_visualizer/painter/custom_painter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Binary Search Tree Visualizer"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(height: 40, width: 100, child: TextField()),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      print("ok");
                    },
                    child: const Text("Insert")),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(height: 40, width: 100, child: TextField()),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      print("ok");
                    },
                    child: const Text("Search")),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(height: 40, width: 100, child: TextField()),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      print("ok");
                    },
                    child: const Text("Delete")),
              ],
            ),
          ),
          Flexible(
            child: CustomPaint(
              painter: ShapePainter(),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}
