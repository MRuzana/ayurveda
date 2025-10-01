import 'package:flutter/material.dart';

Widget buttonSmall({
  required String buttonText,
  required void Function() buttonPressed,
  Color? color,
  double? size
}) {
  return SizedBox(
  //  width: double.infinity,
    height: 40 ,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: buttonPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white,fontSize: size),
        )),
  );
}