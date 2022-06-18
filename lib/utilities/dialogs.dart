import 'package:flutter/material.dart';
import 'package:neko_poster/utilities/show_generic_dialog.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String content,
}) {
  return showGenereicDialog(
    context: context,
    title: "Возник казус...",
    content: content,
    optionsBuilder: () => {'OK :(': null},
  );
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenereicDialog<bool>(
    context: context,
    title: 'Выйти',
    content: 'Вы действительно хотите выйти?',
    optionsBuilder: () => {'Отмена': false, 'Выйти': true},
  ).then((result) => result ?? false);
}

Future<void> showSuccessDialog({
  required BuildContext context,
  required String content,
}) {
  return showGenereicDialog(
    context: context,
    title: "Успех!",
    content: content,
    optionsBuilder: () => {'Ура!': null},
  );
}
