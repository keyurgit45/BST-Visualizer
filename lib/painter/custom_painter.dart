// FOR PAINTING CIRCLES
import 'package:bst_visualizer/model/node.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShapePainter extends CustomPainter {
  final radius = 20.0;
  Node? root;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var circlePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var path = Path();
    Offset center = Offset(size.width / 2, size.height / 10);

    var xLeft = (center.dx -
        (10 * radius)); // to where the line end i.e center on child node
    var yLeft = (center.dy + (3 * radius));

    var xRight = (center.dx + (10 * radius));
    var yRight = (center.dy + (3 * radius));

    drawCircle(canvas, path, circlePaint, center);
    drawData(canvas, center, 10); //root

    drawLeftEdge(canvas, Offset(center.dx, center.dy + radius), path, paint,
        xLeft, yLeft);
    drawRightEdge(canvas, Offset(center.dx, center.dy + radius), path, paint,
        xRight, yRight);

    drawCircle(canvas, path, circlePaint, Offset(xLeft, yLeft + radius));
    drawData(canvas, Offset(xLeft, yLeft + radius), 20);
    drawCircle(canvas, path, circlePaint, Offset(xRight, yRight + radius));
    drawData(canvas, Offset(xRight, yRight + radius), 30);

    //! level 1 complete

    drawLeftEdge(canvas, Offset(xLeft, yLeft + radius + radius), path, paint,
        xLeft - (9 * radius), yLeft + (6 * radius));
    drawRightEdge(canvas, Offset(xRight, yRight + radius + radius), path, paint,
        xRight + (9 * radius), yRight + (6 * radius));

    drawCircle(canvas, path, circlePaint,
        Offset(xRight + (9 * radius), yRight + (6 * radius)));
    // drawData(canvas, Offset(xLeft, yLeft), 20);
    // drawCircle(canvas, path, circlePaint, Offset(xRight, yRight));
    // drawData(canvas, Offset(xRight, yRight), 30);
    root = insert(root, 10);
    root = insert(root, 20);
    root = insert(root, 30);
    root = insert(root, 40);
    inorder(root);
  }

  void drawCircle(Canvas canvas, Path path, Paint circlePaint, Offset center) {
    path.moveTo(center.dx, center.dy);
    canvas.drawCircle(center, radius, circlePaint);
  }

  void drawLeftEdge(
    Canvas canvas,
    Offset center,
    Path path,
    Paint paint,
    xLeft,
    yLeft,
  ) {
    path.moveTo(center.dx, center.dy);
    path.lineTo(xLeft, yLeft);
    // path.close();
    canvas.drawPath(path, paint);
  }

  void drawRightEdge(
    Canvas canvas,
    Offset center,
    Path path,
    Paint paint,
    xRight,
    yRight,
  ) {
    path.moveTo(center.dx, center.dy);
    path.lineTo(xRight, yRight);
    path.close();
    canvas.drawPath(path, paint);
  }

  void drawData(Canvas canvas, Offset center, int data) {
    TextSpan span = TextSpan(
        style: const TextStyle(color: Colors.white), text: data.toString());
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(center.dx - 9, center.dy - 7));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  Node? insert(Node? root, int data) {
    if (root == null) {
      return Node(data: data);
    } else if (root.data > data) {
      root.left = insert(root.left, data);
    } else {
      root.right = insert(root.right, data);
    }
    return root;
  }

  void inorder(Node? root) {
    if (root == null) return;

    inorder(root.left);
    print(root.data.toString() + " ");
    inorder(root.right);
  }
}
