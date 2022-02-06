import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  String title;
  String description;

  CustomBottomSheet({required this.title, required this.description});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(description,
                  style: TextStyle(color: Colors.white, fontSize: 19)),
            )
          ]),
    );
  }
}
