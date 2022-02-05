// ignore_for_file: avoid_print

import 'package:bst_visualizer/consts/my_colors.dart';
import 'package:bst_visualizer/painter/custom_painter.dart';
import 'package:bst_visualizer/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:edge_alerts/edge_alerts.dart';

class Visualizer extends StatefulWidget {
  const Visualizer({Key? key}) : super(key: key);

  @override
  _VisualizerState createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  List<int> integers = <int>[];
  TextEditingController insert = TextEditingController();
  TextEditingController search = TextEditingController();
  TextEditingController delete = TextEditingController();
  var _value = 20.0;

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  void showMessage(String title, String description, int duration) {
    edgeAlert(context,
        title: title,
        description: description,
        gravity: Gravity.bottom,
        duration: duration,
        backgroundColor: MyColors.primary);
  }

  void insertToBST() {
    if (isNumeric(insert.text.trim())) {
      if (integers.contains(int.parse(insert.text.trim()))) {
        showMessage("OOPS!", "Entered number is already present in the BST", 2);
      } else {
        integers.add(int.parse(insert.text.trim()));
      }
      insert.clear();
    } else {
      showMessage("OOPS!", "Please enter a valid number", 2);
    }
    print("Numbers : " + integers.toString());
  }

  void searchInBST() {
    if (isNumeric(search.text.trim())) {
      bool isFound = integers.contains(int.parse(search.text.trim()));
      if (isFound) {
        showMessage("Success", "Entered number is present in the BST", 3);
      } else {
        showMessage("OOPS!", "Entered number is NOT present in the BST", 3);
      }
      search.clear();
    } else {
      showMessage("OOPS!", "Please enter a valid number", 2);
    }
    print("Numbers : " + integers.toString());
  }

  void deleteFromBST() {
    if (isNumeric(delete.text.trim())) {
      bool isRemoved = integers.remove(int.parse(delete.text.trim()));
      if (!isRemoved) {
        showMessage("OOPS!", "Entered number is not present in BST", 3);
      }
      delete.clear();
    } else {
      showMessage("OOPS!", "Please enter a valid number", 2);
    }
    print("Numbers : " + integers.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                  height: 40,
                  width: 70,
                  child: CustomTextField(
                    controller: insert,
                  )),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    insertToBST();
                  });
                },
                child: const Text("Insert"),
                style: ElevatedButton.styleFrom(primary: MyColors.primary),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                  height: 40,
                  width: 70,
                  child: CustomTextField(
                    controller: search,
                  )),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchInBST();
                    });
                  },
                  child: const Text("Search"),
                  style: ElevatedButton.styleFrom(primary: MyColors.primary)),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                  height: 40,
                  width: 70,
                  child: CustomTextField(
                    controller: delete,
                  )),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      deleteFromBST();
                    });
                  },
                  child: const Text("Delete"),
                  style: ElevatedButton.styleFrom(primary: MyColors.primary)),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      integers.clear();
                    });
                  },
                  child: const Text("Clear All"),
                  style: ElevatedButton.styleFrom(primary: MyColors.primary)),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (integers.isEmpty) return;
                    List<int> nums = <int>[];
                    for (var element in integers) {
                      nums.add(element);
                    }
                    nums.sort();
                    showMessage("Inorder Traversal", nums.toString(), 5);
                  },
                  child: const Text("Inorder Traversal"),
                  style: ElevatedButton.styleFrom(primary: MyColors.primary)),
              SizedBox(
                width: 80,
              ),
              Text(
                "Adjust Size : ",
                style: TextStyle(
                    fontSize: 18,
                    color: MyColors.primary,
                    fontWeight: FontWeight.bold),
              ),
              Slider(
                min: 5,
                max: 50,
                activeColor: MyColors.primary,
                inactiveColor: Color(0xffF8BBD0),
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ],
          ),
        ),
        if (integers.isEmpty)
          const Flexible(
            child: Center(
              child: Text(
                "Binary Search Tree is Empty",
                style: TextStyle(
                    color: MyColors.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        if (integers.isNotEmpty)
          Flexible(
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
              painter: ShapePainter(integers: integers, radius: _value),
            ),
          ),
      ],
    );
  }
}
