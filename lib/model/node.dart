import 'package:flutter/material.dart';

class Node {
  int data;
  Node? left;
  Node? right;
  Offset? center;
  double? xOffset;
  double? yOffset;
  double radius = 20;

  Node({required this.data, this.center, this.xOffset, this.yOffset});
}
