import 'package:flutter/material.dart';
import 'package:neko_poster/utilities/show_generic_dialog.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String content,
}) {
  return showGenereicDialog(
    context: context,
    title: "Error occured...",
    content: content,
    optionsBuilder: () => {'OK :(': null},
  );
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenereicDialog<bool>(
    context: context,
    title: 'Sign out',
    content: 'Are you sure want to sign out?',
    optionsBuilder: () => {'Cancel': false, 'Log out': true},
  ).then((result) => result ?? false);
}

Future<void> showSuccessDialog({
  required BuildContext context,
  required String content,
}) {
  return showGenereicDialog(
    context: context,
    title: "Success",
    content: content,
    optionsBuilder: () => {'Yay!': null},
  );
}
