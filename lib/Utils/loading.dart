import 'package:flutter/material.dart';
import 'package:zene/themes/theme_constants.dart';

unFocus(BuildContext context) {
  FocusManager.instance.primaryFocus!.unfocus();
}

showLoader(BuildContext dialogContext, message) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(1),
          child: CircularProgressIndicator(
            backgroundColor: lightBackgroundColor,
            color: greyColor,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Text(message, maxLines: 5),
          ),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: dialogContext,
    builder: (BuildContext dialogContext) {
      return alert;
    },
  );
}
