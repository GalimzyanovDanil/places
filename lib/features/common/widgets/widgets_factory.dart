import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class WidgetsFactory {
  static Widget alertDialogWidgetFactory({
    required AsyncCallback onConfirm,
    required String bodyText,
    required String confirmTitle,
    required String declineTitle,
    required String title,
  }) =>
      _alertDialogWidgetFactory(
        onConfirm: onConfirm,
        bodyText: bodyText,
        confirmTitle: confirmTitle,
        declineTitle: declineTitle,
        title: title,
      );

  static Widget _alertDialogWidgetFactory({
    required AsyncCallback onConfirm,
    required String bodyText,
    required String confirmTitle,
    required String declineTitle,
    required String title,
  }) {
    if (Platform.isIOS) {
      return _IosAlertDialog(
        title: title,
        bodyText: bodyText,
        confirmTitle: confirmTitle,
        declineTitle: declineTitle,
        onConfirm: onConfirm,
      );
    }
    return _AndroidAlertDialog(
      title: title,
      bodyText: bodyText,
      confirmTitle: confirmTitle,
      declineTitle: declineTitle,
      onConfirm: onConfirm,
    );
  }
}

class _IosAlertDialog extends StatelessWidget {
  final String bodyText;
  final String confirmTitle;
  final String declineTitle;
  final AsyncCallback onConfirm;
  final String title;

  const _IosAlertDialog({
    required this.bodyText,
    required this.confirmTitle,
    required this.declineTitle,
    required this.onConfirm,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(bodyText),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(declineTitle),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () async {
            await onConfirm().then((value) => Navigator.of(context).pop());
          },
          child: Text(confirmTitle),
        ),
      ],
    );
  }
}

class _AndroidAlertDialog extends StatelessWidget {
  final String bodyText;
  final String confirmTitle;
  final String declineTitle;
  final AsyncCallback onConfirm;
  final String title;

  const _AndroidAlertDialog({
    required this.bodyText,
    required this.confirmTitle,
    required this.declineTitle,
    required this.onConfirm,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: colorScheme.onPrimaryContainer,
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(bodyText),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            declineTitle,
            style: TextStyle(color: colorScheme.outline),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            confirmTitle,
          ),
          onPressed: () async {
            unawaited(onConfirm().then((value) => Navigator.of(context).pop()));
          },
        ),
      ],
    );
  }
}
