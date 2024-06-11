import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          text: const TextSpan(
              text: "Wall",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              children: [
        TextSpan(
            text: "zy",
            style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 20,
            )),
      ])),
    );
  }
}
