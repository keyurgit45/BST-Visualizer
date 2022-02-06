// ignore_for_file: avoid_print

import 'package:bst_visualizer/consts/my_colors.dart';
import 'package:bst_visualizer/model/node.dart';
import 'package:bst_visualizer/painter/tree_painter.dart';
import 'package:bst_visualizer/widgets/bottom_sheet.dart';
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
  Node? root;
  TextEditingController insertController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController deleteController = TextEditingController();
  var _value = 20.0;

  late PersistentBottomSheetController _controller;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _open = false;
  List<int> inorderList = <int>[];
  List<int> searchList = <int>[];

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

  void insertControllerToBST() {
    if (isNumeric(insertController.text.trim())) {
      if (integers.contains(int.parse(insertController.text.trim()))) {
        showMessage("OOPS!", "Entered number is already present in the BST", 2);
      } else {
        integers.add(int.parse(insertController.text.trim()));
        root = insert(root, int.parse(insertController.text.trim()));
      }
      insertController.clear();
    } else {
      showMessage("OOPS!", "Please enter a valid number", 2);
    }
    print("Numbers : " + integers.toString());
  }

  void searchControllerInBST() {
    if (isNumeric(searchController.text.trim())) {
      bool isFound = search(root, int.parse(searchController.text.trim()));
      if (isFound) {
        String s = '';
        searchList.forEach((element) {
          s = s + element.toString() + " -> ";
        });
        s = s + searchController.text.trim();
        showMessage("Success",
            "Entered number is present in the BST. \nTraversal : " + s, 4);
      } else {
        showMessage("OOPS!", "Entered number is NOT present in the BST", 3);
      }
      searchController.clear();
    } else {
      showMessage("OOPS!", "Please enter a valid number", 2);
    }
    print("Numbers : " + integers.toString());
  }

  void deleteControllerFromBST() {
    if (isNumeric(deleteController.text.trim())) {
      bool isRemoved = integers.remove(int.parse(deleteController.text.trim()));
      if (!isRemoved) {
        showMessage("OOPS!", "Entered number is not present in BST", 3);
      }
      deleteController.clear();
    } else {
      showMessage("OOPS!", "Please enter a valid number", 2);
    }
    print("Numbers : " + integers.toString());
  }

  Node insert(Node? root, int data) {
    if (root == null) return Node(data: data);

    if (root.data > data) {
      root.left = insert(root.left, data);
    } else {
      root.right = insert(root.right, data);
    }
    return root;
  }

  bool search(Node? root, int data) {
    if (root == null) return false;

    if (root.data == data) {
      return true;
    } else if (root.data > data) {
      searchList.add(root.data);
      return search(root.left, data);
    } else {
      searchList.add(root.data);
      return search(root.right, data);
    }
  }

  void inorder(Node? root) {
    if (root == null) return;

    inorder(root.left);
    print(root.data.toString());
    inorderList.add(root.data);
    inorder(root.right);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
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
                SizedBox(
                    height: 40,
                    width: 70,
                    child: CustomTextField(
                      controller: insertController,
                    )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      insertControllerToBST();
                    });
                  },
                  child: const Text("insert"),
                  style: ElevatedButton.styleFrom(primary: MyColors.primary),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    height: 40,
                    width: 70,
                    child: CustomTextField(
                      controller: searchController,
                    )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        searchControllerInBST();
                      });
                    },
                    child: const Text("search"),
                    style: ElevatedButton.styleFrom(primary: MyColors.primary)),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    height: 40,
                    width: 70,
                    child: CustomTextField(
                      controller: deleteController,
                    )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        deleteControllerFromBST();
                      });
                    },
                    child: const Text("delete"),
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
                      // if (integers.isEmpty) return;
                      // List<int> nums = <int>[];
                      // for (var element in integers) {
                      //   nums.add(element);
                      // }
                      // nums.sort();
                      // showMessage("Inorder Traversal", nums.toString(), 5);
                      inorderList.clear();
                      inorder(root);
                      String des = '';
                      for (var element in inorderList) {
                        des = des + element.toString() + " -> ";
                      }
                      des = des + " NULL";
                      if (!_open) {
                        _controller = _key.currentState!.showBottomSheet(
                            (_) => CustomBottomSheet(
                                  title: "Inorder Traversal",
                                  description: des,
                                ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            backgroundColor: MyColors.primary);
                      } else {
                        _controller.close();
                      }
                      setState(() => _open = !_open);
                    },
                    child: Text(_open ? "Close" : "Inorder Traversal"),
                    style: ElevatedButton.styleFrom(primary: MyColors.primary)),
                const SizedBox(
                  width: 80,
                ),
                const Text(
                  "Adjust Size : ",
                  style: const TextStyle(
                      fontSize: 18,
                      color: MyColors.primary,
                      fontWeight: FontWeight.bold),
                ),
                Slider(
                  min: 5,
                  max: 40,
                  activeColor: MyColors.primary,
                  inactiveColor: const Color(0xffF8BBD0),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: RepaintBoundary(
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 2),
                    painter: TreePainter(integers: integers, radius: _value),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
