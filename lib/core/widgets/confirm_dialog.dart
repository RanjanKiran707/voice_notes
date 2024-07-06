import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ConfirmDialog {
  static show({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
    required VoidCallback onDismiss,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            FilledButton(
                onPressed: () {
                  onConfirm.call();
                  Navigator.pop(context);
                },
                child: Text("Yes")),
            ElevatedButton(
                onPressed: () {
                  onDismiss.call();
                  Navigator.pop(context);
                },
                child: Text("No")),
          ],
        );
      },
    );
  }
}
