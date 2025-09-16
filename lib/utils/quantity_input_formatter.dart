import 'package:flutter/services.dart';
import 'dart:math' as math;

class QuantityInputFormatter extends TextInputFormatter {
  final int decimalDigits;

  QuantityInputFormatter({this.decimalDigits = 3});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove anything that is not a digit
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Convert to number with implied decimals
    final number = double.parse(digitsOnly) / math.pow(10, decimalDigits);

    // Format with fixed decimal digits
    final formatted = number.toStringAsFixed(decimalDigits);

    return TextEditingValue(
      text: formatted,
      // Always keep cursor at the end
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  /// Utility to extract numeric value
  static double getCleanValue(String text) {
    if (text.isEmpty) return 0.0;
    return double.tryParse(text.replaceAll(',', '.')) ?? 0.0;
  }
}
