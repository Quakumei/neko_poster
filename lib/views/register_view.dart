import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neko_poster/constants/routes.dart';
import 'package:neko_poster/services/auth/shared_preferences_auth_service.dart';
import 'package:neko_poster/utilities/dialogs.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool showPassword = false;
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repeatPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _login.dispose();
    _password.dispose();
    _repeatPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "ᓚᘏᗢ - register~",
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
                      "猫になる",
                      style: GoogleFonts.zenKurenaido(
                          fontSize: 32, letterSpacing: 15),
                    ),
                    Text(
                      "Стать котиком",
                      style: GoogleFonts.zenKurenaido(
                          fontSize: 32, letterSpacing: 0),
                    ),
                    Text(
                      "Become a Cat",
                      style: GoogleFonts.zenKurenaido(
                          fontSize: 32, letterSpacing: 1),
                    ),
                    // const Size
                    //dBox(height: 50),
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
                      TextFormField(
                        controller: _repeatPassword,
                        obscureText: !showPassword,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          labelText: 'Повторить пароль',
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
                      FutureBuilder(
                        future: SharedPreferencesAuthService.getInstance(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                            case ConnectionState.active:
                              return const CircularProgressIndicator();
                            case ConnectionState.done:
                              break;
                          }
                          return ElevatedButton(
                            onPressed: () async {
                              String login = _login.text;
                              String password = _password.text;
                              String repeatPassword = _repeatPassword.text;
                              if (login.isNotEmpty &&
                                  password.isNotEmpty &&
                                  repeatPassword.isNotEmpty) {
                                try {
                                  if (password != repeatPassword) {
                                    throw "Пароли не совпадают";
                                  }
                                  if (password.length < 8) {
                                    throw "Пароли слабый";
                                  }
                                  SharedPreferencesAuthService spas = snapshot
                                      .data as SharedPreferencesAuthService;
                                  await spas.register(
                                    username: login,
                                    password: password,
                                  );
                                  if (!mounted) return;
                                  await Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                    mainPageRoute,
                                    (route) => false,
                                  );
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
                                "Стать котиком",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                      Row(
                        children: [
                          const Text("Уже котик? "),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamedAndRemoveUntil(
                              loginRoute,
                              (_) => false,
                            ),
                            child: const Text("Войти"),
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
