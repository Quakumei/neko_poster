import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neko_poster/constants/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    double textOpacity = 0.01;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FutureBuilder(
              future: Future.delayed(
                const Duration(milliseconds: 500),
                () => textOpacity = 1.0,
              ),
              builder: (cont, _) => AnimatedOpacity(
                opacity: textOpacity,
                duration: const Duration(seconds: 2),
                child: FutureBuilder(
                  future: Future.delayed(
                    const Duration(seconds: 3),
                    () async => await Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false),
                  ),
                  builder: (context, snapshot) {
                    return Column(
                      children: [
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
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
