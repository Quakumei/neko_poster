import 'package:flutter/material.dart';
import 'package:neko_poster/constants/routes.dart';
import 'package:neko_poster/views/login_view.dart';
import 'package:neko_poster/views/main_page_view.dart';
import 'package:neko_poster/views/new_post_view.dart';
import 'package:neko_poster/views/register_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neko Poster',
      theme: ThemeData.dark(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        mainPageRoute: (context) => const MainPageView(),
        newPostRoute: (context) => const NewPostView(),
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MainPageView();
  }
}
