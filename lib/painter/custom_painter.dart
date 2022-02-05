// FOR PAINTING CIRCLES
import 'package:bst_visualizer/consts/my_colors.dart';
import 'package:bst_visualizer/model/node.dart';
import 'package:flutter/material.dart';

class ShapePainter extends CustomPainter {
  final List<int> integers;
  final radius;
  Node? root;
  final circleRadius = 20.0;
  static const universalConstant = 3;
  ShapePainter({required this.integers, required this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    print("In method paint" + integers.toString());
    var paint = Paint()
      ..color = MyColors.primary
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var circlePaint = Paint()
      ..color = MyColors.primary
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var path = Path();
    Offset center = Offset(size.width / 2, size.height / 20);
    print(center);
    // var xLeft = (center.dx -
    //     (10 * radius)); // to where the line end i.e center on child node
    // var yLeft = (center.dy + (3 * radius));

    // var xRight = (center.dx + (10 * radius));
    // var yRight = (center.dy + (3 * radius));

    // drawCircle(canvas, path, circlePaint, center);
    // drawData(canvas, center, 10); //root

    // drawLeftEdge(canvas, Offset(center.dx, center.dy + radius), path, paint,
    //     xLeft, yLeft);
    // drawRightEdge(canvas, Offset(center.dx, center.dy + radius), path, paint,
    //     xRight, yRight);

    // drawCircle(canvas, path, circlePaint, Offset(xLeft, yLeft + radius));
    // drawData(canvas, Offset(xLeft, yLeft + radius), 20);
    // drawCircle(canvas, path, circlePaint, Offset(xRight, yRight + radius));
    // drawData(canvas, Offset(xRight, yRight + radius), 30);

    //! level 1 complete

    // drawLeftEdge(canvas, Offset(xLeft, yLeft + radius + radius), path, paint,
    //     xLeft - (9 * radius), yLeft + (6 * radius));
    // drawRightEdge(canvas, Offset(xRight, yRight + radius + radius), path, paint,
    //     xRight + (9 * radius), yRight + (6 * radius));

    // drawCircle(canvas, path, circlePaint,
    //     Offset(xRight + (9 * radius), yRight + (6 * radius)));
    // drawData(canvas, Offset(xLeft, yLeft), 20);
    // drawCircle(canvas, path, circlePaint, Offset(xRight, yRight));
    // drawData(canvas, Offset(xRight, yRight), 30);

    // root = insert(root, 10, center, canvas, path, circlePaint);
    // root = insert(root, 20, center, canvas, path, circlePaint);
    // root = insert(root, 5, center, canvas, path, circlePaint);
    // root = insert(root, 40, center, canvas, path, circlePaint);
    // inorder(root);

    for (int i = 0; i < integers.length; i++) {
      root = insert(root, integers[i], center, canvas, path, circlePaint, paint,
          universalConstant);
    }
    // inorder(root);
    root = null;
  }

  void drawCircle(Canvas canvas, Path path, Paint circlePaint, Offset center) {
    path.moveTo(center.dx, center.dy);
    canvas.drawCircle(center, circleRadius, circlePaint);
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
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        text: data.toString());
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(
        canvas,
        data > 9
            ? Offset(center.dx - 9, center.dy - 7)
            : Offset(center.dx - 4, center.dy - 7));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Node? insert(Node? root, int data, Offset center, Canvas canvas, Path path,
      Paint circlePaint, Paint paint, int universalConstant) {
    if (root == null) {
      drawCircle(canvas, path, circlePaint, center);
      drawData(canvas, center, data);
      return Node(data: data, center: center);
    } else if (root.data > data) {
      drawLeftEdge(canvas, Offset(center.dx, center.dy + circleRadius - 2),
          path, paint, center.dx - (10 * radius), center.dy + (3 * radius));
      root.left = insert(
          root.left,
          data,
          Offset(center.dx - (10 * radius),
              center.dy + (3 * radius) + circleRadius - 2),
          canvas,
          path,
          circlePaint,
          paint,
          universalConstant);
    } else {
      drawRightEdge(canvas, Offset(center.dx, center.dy + circleRadius - 2),
          path, paint, center.dx + (10 * radius), center.dy + (3 * radius));
      root.right = insert(
          root.right,
          data,
          Offset(center.dx + (10 * radius),
              center.dy + (3 * radius) + circleRadius - 2),
          canvas,
          path,
          circlePaint,
          paint,
          universalConstant);
    }
    return root;
  }

  void inorder(Node? root) {
    if (root == null) return;

    inorder(root.left);
    print(root.data.toString() + " " + root.center.toString());
    inorder(root.right);
  }
}
