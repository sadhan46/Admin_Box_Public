import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class CurrencyFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else {
      NumberFormat f = NumberFormat("#,####.##", "en_US");
      double newNumber = 0;
      if ((!newValue.text.contains(".")) && oldValue.text.contains('.')) {
        String tempString = newValue.text
            .replaceAll(f.symbols.GROUP_SEP, '')
            .replaceAll("..", '.');
        tempString = tempString.substring(0, tempString.length - 2) +
            "." +
            tempString.substring(tempString.length - 2);
        newNumber = double.parse(tempString);
      } else {
        newNumber = double.parse(newValue.text
            .replaceAll(f.symbols.GROUP_SEP, '')
            .replaceAll("..", '.'));
      }
      String newString = f.format(newNumber);
      int cursorPosition = 0;
      if (oldValue.text.length > newString.length) {
        cursorPosition = -1;
      } else if (oldValue.text.length < newString.length) {
        cursorPosition = 1;
      } else {
        if (oldValue.text.replaceAll(f.symbols.GROUP_SEP, '').length >
            newValue.text.replaceAll(f.symbols.GROUP_SEP, '').length) {
          cursorPosition = -1;
        } else if (oldValue.text.replaceAll(f.symbols.GROUP_SEP, '').length <
            newValue.text.replaceAll(f.symbols.GROUP_SEP, '').length) {
          cursorPosition = 1;
        }
      }
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: oldValue.selection.extent.offset +
                cursorPosition +
                (f.symbols.GROUP_SEP.allMatches(newString).length -
                    f.symbols.GROUP_SEP.allMatches(oldValue.text).length)),
      );
    }
  }
}