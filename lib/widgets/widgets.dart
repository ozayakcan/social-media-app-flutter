import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/colors.dart';
import '../utils/shared_pref.dart';
import '../utils/variables.dart';
import 'texts.dart';

class ScaffoldSnackbar {
  ScaffoldSnackbar(this.context);
  final BuildContext context;

  factory ScaffoldSnackbar.of(BuildContext context) {
    return ScaffoldSnackbar(context);
  }
  void show(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}

Scaffold formPage(
  BuildContext context,
  List<Widget> list,
) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: formList(list),
          ),
        ),
      ),
    ),
  );
}

List<Widget> formList(List<Widget> oldList) {
  List<Widget> newList = [];
  for (int i = 0; i < oldList.length; i++) {
    newList.add(oldList[i]);
    newList.add(
      SizedBox(
        height: (i >= oldList.length - 1) ? 40 : 10,
      ),
    );
  }
  return newList;
}

Widget loadingRow(BuildContext context, bool darkTheme,
    {double width = 15, double height = 15}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: width,
        height: height,
        child: CircularProgressIndicator(
          semanticsLabel: AppLocalizations.of(context).loading,
          color:
              darkTheme ? ThemeColorDark.textPrimary : ThemeColor.textPrimary,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        AppLocalizations.of(context).loading,
        style: TextStyle(
          color:
              darkTheme ? ThemeColorDark.textPrimary : ThemeColor.textPrimary,
          fontSize: Variables.fontSizeMedium,
        ),
        textAlign: TextAlign.center,
      )
    ],
  );
}

Widget darkThemeSwitch(BuildContext context, bool darkTheme) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context).dark_theme,
          style: simpleTextStyle(
            Variables.fontSizeMedium,
            darkTheme,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Switch(
          value: darkTheme,
          onChanged: (value) {
            SharedPref.setDarkThemeRestart(context, value);
          },
          activeColor:
              darkTheme ? ThemeColorDark.textPrimary : ThemeColor.textPrimary,
          activeTrackColor: darkTheme
              ? ThemeColorDark.textSecondary
              : ThemeColor.textSecondary,
        ),
      ],
    ),
  );
}

Future<void> defaultAlertbox(
  BuildContext _context, {
  required String title,
  required List<Widget> descriptions,
  required bool darkTheme,
  bool dismissible = true,
  VoidCallback? actionOk,
  VoidCallback? actionYes,
  VoidCallback? actionNo,
  VoidCallback? actionCancel,
}) {
  return showDialog(
    context: _context,
    barrierDismissible: dismissible,
    builder: (context) {
      return AlertDialog(
        backgroundColor: darkTheme
            ? ThemeColorDark.alertBoxBackground
            : ThemeColor.alertBoxBackground,
        title: Text(
          title,
          style: simpleTextStyle(Variables.fontSizeMedium, darkTheme),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: descriptions,
          ),
        ),
        actions: [
          if (actionOk != null)
            TextButton(
              onPressed: () {
                actionOk();
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context).ok,
                style: simpleTextStyle(Variables.fontSizeNormal, darkTheme),
              ),
            ),
          if (actionYes != null)
            TextButton(
              onPressed: () {
                actionYes();
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context).yes,
                style: simpleTextStyle(Variables.fontSizeNormal, darkTheme),
              ),
            ),
          if (actionNo != null)
            TextButton(
              onPressed: () {
                actionNo();
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context).no,
                style: simpleTextStyle(Variables.fontSizeNormal, darkTheme),
              ),
            ),
          if (actionCancel != null)
            TextButton(
              onPressed: () {
                actionCancel();
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context).cancel,
                style: simpleTextStyle(Variables.fontSizeNormal, darkTheme),
              ),
            ),
        ],
      );
    },
  );
}
