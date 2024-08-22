import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> passwordResetSendEmailDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'We sent the link to reassingning your old password.',
    optionBuilder: () {
      return {'OK': null};
    },
  );
}
