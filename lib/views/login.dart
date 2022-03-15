import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sosyal/main.dart';
import 'package:sosyal/utils/colors.dart';
import 'package:sosyal/utils/shared_pref.dart';
import 'package:sosyal/utils/variables.dart';
import 'package:sosyal/widgets/texts.dart';

import '../widgets/buttons.dart';
import '../widgets/text_fields.dart';
import '../widgets/widgets.dart';

class Login extends StatefulWidget {
  Login({Key? key, required this.redirectEnabled, required this.darkTheme})
      : super(key: key);

  final bool redirectEnabled;
  bool darkTheme;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                googleAuthBtn(
                  context,
                  widget.redirectEnabled,
                  widget.darkTheme,
                ),
                const SizedBox(
                  height: 10,
                ),
                emailLoginBtn(
                  context,
                  widget.redirectEnabled,
                  widget.darkTheme,
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).dark_theme,
                        style: simpleTextStyle(
                          Variables.normalFontSize,
                          widget.darkTheme,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Switch(
                        value: widget.darkTheme,
                        onChanged: (value) {
                          SharedPref.setDarkThemeRestart(context, value);
                        },
                        activeColor: widget.darkTheme
                            ? ThemeColorDark.textPrimary
                            : ThemeColor.textPrimary,
                        activeTrackColor: widget.darkTheme
                            ? ThemeColorDark.textSecondary
                            : ThemeColor.textSecondary,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailLogin extends StatelessWidget {
  EmailLogin({Key? key, required this.darkTheme}) : super(key: key);

  final bool darkTheme;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final CustomAuthButton loginBtnVar = loginBtn(
      context,
      emailController,
      passwordController,
      darkTheme,
    );
    return formPage(
      context,
      [
        emailTextField(
          context,
          darkTheme,
          emailController: emailController,
          nextFocus: passwordFocus,
        ),
        passwordTextField(
          context,
          darkTheme,
          pwtext: AppLocalizations.of(context).password,
          passwordController: passwordController,
          authButton: loginBtnVar,
          prevFocus: passwordFocus,
        ),
        loginBtnVar,
        routeBtn(
          context,
          ResetPassword(
            darkTheme: darkTheme,
          ),
          AppLocalizations.of(context).reset_password,
          darkTheme,
        ),
        routeBtn(
          context,
          EmailRegister(
            darkTheme: darkTheme,
          ),
          AppLocalizations.of(context).register,
          darkTheme,
        ),
        backBtn(context, darkTheme),
      ],
    );
  }
}

class EmailRegister extends StatelessWidget {
  EmailRegister({Key? key, required this.darkTheme}) : super(key: key);

  final bool darkTheme;

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRpController = TextEditingController();
  final usernameFocus = FocusNode();
  final nameFocus = FocusNode();
  final passwordFocus = FocusNode();
  final passwordRpFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final CustomAuthButton registerBtnVar = registerBtn(
      context,
      emailController,
      usernameController,
      nameController,
      passwordController,
      passwordRpController,
      darkTheme,
    );
    return WillPopScope(
      onWillPop: () async {
        back(context);
        return false;
      },
      child: formPage(
        context,
        [
          emailTextField(
            context,
            darkTheme,
            emailController: emailController,
            nextFocus: usernameFocus,
          ),
          customTextField(
            context,
            darkTheme,
            labelText: AppLocalizations.of(context).username,
            maxLength: Variables.maxLengthUsername,
            nameController: usernameController,
            prevFocus: usernameFocus,
            nextFocus: nameFocus,
          ),
          customTextField(
            context,
            darkTheme,
            labelText: AppLocalizations.of(context).name,
            maxLength: Variables.maxLengthName,
            nameController: nameController,
            prevFocus: nameFocus,
            nextFocus: passwordFocus,
          ),
          passwordTextField(
            context,
            darkTheme,
            pwtext: AppLocalizations.of(context).password,
            passwordController: passwordController,
            prevFocus: passwordFocus,
            nextFocus: passwordRpFocus,
          ),
          passwordTextField(
            context,
            darkTheme,
            pwtext: AppLocalizations.of(context).password_repeat,
            passwordController: passwordRpController,
            authButton: registerBtnVar,
            prevFocus: passwordRpFocus,
          ),
          registerBtnVar,
          backBtn(
            context,
            darkTheme,
            action: () {
              back(context);
            },
          ),
        ],
      ),
    );
  }

  void back(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EmailLogin(
          darkTheme: darkTheme,
        ),
      ),
    );
  }
}

class ResetPassword extends StatelessWidget {
  ResetPassword({Key? key, required this.darkTheme}) : super(key: key);

  final bool darkTheme;

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CustomAuthButton resetPasswordBtnVar = resetPasswordBtn(
      context,
      emailController,
      darkTheme,
    );
    return WillPopScope(
      onWillPop: () async {
        back(context);
        return false;
      },
      child: formPage(
        context,
        [
          emailTextField(
            context,
            darkTheme,
            emailController: emailController,
            authButton: resetPasswordBtnVar,
          ),
          resetPasswordBtnVar,
          backBtn(
            context,
            darkTheme,
            action: () {
              back(context);
            },
          ),
        ],
      ),
    );
  }

  void back(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EmailLogin(
          darkTheme: darkTheme,
        ),
      ),
    );
  }
}
