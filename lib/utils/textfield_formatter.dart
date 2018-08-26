import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CapSentenceTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = toBeginningOfSentenceCase(newValue.text);
    return newValue.copyWith(text: newText);
  }
}

class AllCapsTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text.toUpperCase();
    return newValue.copyWith(text: newText);
  }
}
