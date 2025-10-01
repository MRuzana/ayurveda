import 'package:flutter/material.dart';

Widget textField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String labelText,
  required String? Function(String?)? validator,
  required AutovalidateMode autovalidateMode,
  
  bool isObscured = false,
  

}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: isObscured,
    decoration: InputDecoration(
      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10 ))),
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintStyle: const TextStyle(color: Color(0xFF858080),fontSize: 12), // Hint text color
      
      
      
    ),
    validator: validator,
    autovalidateMode: autovalidateMode, 
  );
}
