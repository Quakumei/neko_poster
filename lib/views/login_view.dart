import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neko_poster/constants/routes.dart';
import 'package:neko_poster/utilities/dialogs.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool showPassword = false;
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _login.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ᓚᘏᗢ - meow~",
          style: GoogleFonts.zenKurenaido(fontSize: 16, letterSpacing: 2.7),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (!isKeyboard)
                Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      "ねこポスター",
                      style: GoogleFonts.zenKurenaido(
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      "Кото постер",
                      style: GoogleFonts.zenKurenaido(
                          fontSize: 32, letterSpacing: 3),
                    ),
                    Text(
                      "Neko Poster",
                      style: GoogleFonts.zenKurenaido(
                          fontSize: 32, letterSpacing: 2.7),
                    ),
                  ],
                ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: (!isKeyboard)
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _login,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          labelText: 'Логин',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.account_box_rounded,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _password,
                        obscureText: !showPassword,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          labelText: 'Пароль',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.password_rounded,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: showPassword,
                            onChanged: (value) {
                              setState(() {
                                showPassword = value!;
                              });
                            },
                          ),
                          const Text("Показать пароль"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          String login = _login.text;
                          String password = _password.text;
                          if (login.isNotEmpty && password.isNotEmpty) {
                            try {
                              print('login attempt: $login $password');
                            } catch (e) {
                              showErrorDialog(
                                context: context,
                                content: e.toString(),
                              );
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            "Войти",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Text("Ещё не котик? "),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed(registerRoute),
                            child: const Text("Зарегистрироваться"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
