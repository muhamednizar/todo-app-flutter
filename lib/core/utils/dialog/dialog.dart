import 'package:flutter/material.dart';

class MyDialog {
  static void ShowLoading(context,
      {String? loadingMessage, bool isDismissible = false}) {
    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            Spacer(),
            Text(loadingMessage ?? ''),
          ],
        ),
      ),
    );
  }

  static void hide(context) {
    Navigator.pop(context);
  }

  static void showMessage(context,
      {String? title,
      String? body,
      String? posActionTitle,
      String? negActionTitle,
      VoidCallback? posAction,
      VoidCallback? negAction}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: body != null ? Text(body) : null,
          actions: [
            if (posActionTitle != null)
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    posAction?.call();
                  },
                  child: Text(posActionTitle)),
            if (negActionTitle != null)
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    negAction?.call();
                  },
                  child: Text(negActionTitle))
          ],
        );
      },
    );
  }
}
