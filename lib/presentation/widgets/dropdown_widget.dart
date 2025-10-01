import 'package:flutter/material.dart';

Widget dropdownField<T>({
  required T? value,
  required List<DropdownMenuItem<T>> items,
  required void Function(T?) onChanged,
  required String labelText,
  required String? Function(T?)? validator,
  required AutovalidateMode autovalidateMode,
}) {
  return DropdownButtonFormField<T>(
    value: value,
    items: items,
    onChanged: onChanged,
    decoration: InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintStyle: const TextStyle(
        color: Color(0xFF858080),
        fontSize: 12,
      ),
    ),
    validator: validator,
    autovalidateMode: autovalidateMode,
  );
}