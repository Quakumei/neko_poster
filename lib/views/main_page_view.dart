import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neko_poster/views/feed_view.dart';
import 'package:neko_poster/views/profile_view.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.newspaper_rounded),
            label: 'Новости',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_page_rounded),
            label: 'Профиль',
          ),
        ],
      ),
      body: <Widget>[
        FeedView(),
        ProfileView(),
      ][currentPageIndex],
    );
  }
}
