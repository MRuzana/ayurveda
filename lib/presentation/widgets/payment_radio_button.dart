import 'package:flutter/material.dart';

Widget paymentRadioButtons({
  required String selectedPayment,
  required void Function(String?) onChanged,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      // Cash
      Row(
        children: [
          Radio<String>(
            value: "Cash",
            groupValue: selectedPayment,
            onChanged: onChanged,
          ),
          const Text("Cash"),
        ],
      ),
      const SizedBox(width: 16),

      // UPI
      Row(
        children: [
          Radio<String>(
            value: "UPI",
            groupValue: selectedPayment,
            onChanged: onChanged,
          ),
          const Text("UPI"),
        ],
      ),
      const SizedBox(width: 16),

      // Card
      Row(
        children: [
          Radio<String>(
            value: "Card",
            groupValue: selectedPayment,
            onChanged: onChanged,
          ),
          const Text("Card"),
        ],
      ),
    ],
  );
}