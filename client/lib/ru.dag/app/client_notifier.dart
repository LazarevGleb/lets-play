import 'package:flutter/material.dart';

import '../widget/snack_bar_widget.dart';

class ClientNotifier {
  static void showError(BuildContext context, String header, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SnackBarWidget(header: header, text: text, color: Colors.red),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}
