// FOR PAINTING CIRCLES
import 'package:bst_visualizer/consts/my_colors.dart';
import 'package:bst_visualizer/model/node.dart';
import 'package:flutter/material.dart';

class TreePainter extends CustomPainter {
  final List<int> integers;
  final radius;
  Node? root;
  final circleRadius = 20.0;
  static const xuniversalConstant = -30.0;
  static const yuniversalConstant = 15.0;

  TreePainter({required this.integers, required this.radius});
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
          xuniversalConstant, yuniversalConstant);
    }

    // var inorderPaint = Paint()
    //   ..color = Color.fromARGB(255, 119, 9, 49)
    //   ..strokeWidth = 5
    //   ..style = PaintingStyle.stroke
    //   ..strokeCap = StrokeCap.round;

    // inorder(root, canvas, inorderPaint);
    // inorder(root);
    // root = null;
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
    return true;
  }

  Node? insert(
      Node? root,
      int data,
      Offset center,
      Canvas canvas,
      Path path,
      Paint circlePaint,
      Paint paint,
      double xuniversalConstant,
      double yuniversalConstant) {
    if (root == null) {
      // print("$data ->" + yuniversalConstant.toString());
      drawCircle(canvas, path, circlePaint, center);
      drawData(canvas, center, data);
      return Node(data: data, center: center);
    } else if (root.data > data) {
      if (xuniversalConstant > 180) {
        xuniversalConstant = 180;
      }
      if (yuniversalConstant > 100) {
        yuniversalConstant = 100;
      }
      drawLeftEdge(
          canvas,
          Offset(center.dx, center.dy + circleRadius - 2),
          path,
          paint,
          center.dx - (11 * radius) + xuniversalConstant,
          center.dy + (2 * radius) + yuniversalConstant);
      // print(Offset(center.dx - (9 * radius) + xuniversalConstant,
      //     center.dy + (2 * radius) + yuniversalConstant + circleRadius - 2));

      root.left = insert(
          root.left,
          data,
          Offset(center.dx - (11 * radius) + xuniversalConstant,
              center.dy + (2 * radius) + yuniversalConstant + circleRadius - 2),
          canvas,
          path,
          circlePaint,
          paint,
          xuniversalConstant + 100,
          yuniversalConstant + 100);
    } else {
      if (yuniversalConstant > 100) {
        yuniversalConstant = 100;
      }
      if (xuniversalConstant > 180) {
        xuniversalConstant = 180;
      }

      drawRightEdge(
          canvas,
          Offset(center.dx, center.dy + circleRadius - 2),
          path,
          paint,
          center.dx + (11 * radius) - xuniversalConstant,
          center.dy + (2 * radius) + yuniversalConstant);
      root.right = insert(
          root.right,
          data,
          Offset(center.dx + (11 * radius) - xuniversalConstant,
              center.dy + (2 * radius) + yuniversalConstant + circleRadius - 2),
          canvas,
          path,
          circlePaint,
          paint,
          xuniversalConstant + 100,
          yuniversalConstant + 100);
    }
    return root;
  }

  void inorder(Node? root, Canvas canvas, Paint circlePaint) {
    if (root == null) return;

    inorder(root.left, canvas, circlePaint);
    print(root.data.toString() + " " + root.center.toString());
    canvas.drawCircle(root.center!, radius, circlePaint);
    inorder(root.right, canvas, circlePaint);
  }
}
