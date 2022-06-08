import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> datePickerFactory({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  required ValueChanged<DateTime> onDateTimeChanged,
}) async {
  if (Platform.isAndroid) {
    final picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (picked != null && picked != initialDate) {
      onDateTimeChanged.call(picked);
    }
  } else {
    await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (context) => Container(
              height: 220,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: CupertinoDatePicker(
                  backgroundColor: Colors.white,
                  initialDateTime: initialDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: onDateTimeChanged,
                ),
              ),
            ));
  }
}
