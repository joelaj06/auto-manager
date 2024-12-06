import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class AppDialogs {
  AppDialogs._();

  static Future<void> showDialogWithButtons(BuildContext context,{
    required VoidCallback onConfirmPressed,
    String? confirmText,
    required Widget content,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      // Close the dialog by tapping outside
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      // Background color
      transitionDuration: const Duration(milliseconds: 300),
      // Animation duration
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent, // Makes the background transparent
            child: AlertDialog(
              content: content,
              icon: const Icon(
                IconlyBold.info_circle,
                size: 50,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: onConfirmPressed,
                  child: Text(confirmText ?? 'Ok'),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        // Custom transition animation
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
    );
  }
}
