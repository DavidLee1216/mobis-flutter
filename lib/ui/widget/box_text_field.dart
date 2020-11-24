import 'package:flutter/material.dart';

boxTextField(TextEditingController controller, double fontSize, int kind) {
  //kind:0; text, kind:1; number
  return TextField(
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      contentPadding: EdgeInsets.only(left: 10),
    ),
    keyboardType: kind == 0 ? TextInputType.text : TextInputType.number,
    style: TextStyle(
      fontSize: fontSize,
    ),
    textAlign: TextAlign.left,
    controller: controller,
  );
}
