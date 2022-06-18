import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neko_poster/constants/image_assets.dart';
import 'package:neko_poster/constants/routes.dart';
import 'package:neko_poster/services/auth/shared_preferences_auth_service.dart';
import 'package:neko_poster/services/models/model.dart';
import 'package:neko_poster/utilities/dialogs.dart';
import 'package:neko_poster/views/_widgets.dart';

enum MenuElem {
  logout,
}

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(title: "Профиль 👤"),
        actions: [
          PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<MenuElem>(
                value: MenuElem.logout,
                child: Text("Выход"),
              ),
            ];
          }, onSelected: (value) async {
            final MenuElem? val = value as MenuElem;
            if (val == null) {
              return;
            }
            switch (val) {
              case MenuElem.logout:
                bool shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  // TODO: Service logout
                  if (!mounted) return;
                  await Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                }
            }
          }),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            FutureBuilder(
                future: SharedPreferencesAuthService.getInstance(),
                builder: (context, instanceSnapshot) {
                  switch (instanceSnapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return const CircularProgressIndicator();
                    case ConnectionState.done:
                      break;
                  }
                  final SharedPreferencesAuthService spas =
                      instanceSnapshot.data as SharedPreferencesAuthService;
                  return FutureBuilder(
                    future: spas.userName,
                    builder: (context, snapshot) => getProfileCard(
                      UserData(
                        (instanceSnapshot.connectionState ==
                                ConnectionState.done)
                            ? (snapshot.data ?? "loading...") as String
                            : "loading...",
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Card getProfileCard(UserData userData) {
    const buttonColor = Colors.white;
    return infoCard(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 128,
                    child: CircleAvatar(
                      radius: 64,
                      foregroundImage: avatarImageSample.image,
                      backgroundImage: avatarImageSample.image,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "@${userData.login}",
                          style: GoogleFonts.caveat(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          // TODO: Добавить статус
                          "в сети",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {}, child: const Text("Редактировать")),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: profileCardActionButton(
                    action: () {},
                    buttonColor: buttonColor,
                    buttonIcon: Icons.add_a_photo,
                    title: "История",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: profileCardActionButton(
                    action: () async {
                      await Navigator.of(context).pushNamed(newPostRoute);
                    },
                    buttonColor: buttonColor,
                    buttonIcon: Icons.add_circle_outlined,
                    title: "Пост",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: profileCardActionButton(
                    action: () {},
                    buttonColor: buttonColor,
                    buttonIcon: Icons.photo,
                    title: "Альбом",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  OutlinedButton profileCardActionButton({
    required void Function() action,
    required Color buttonColor,
    required IconData buttonIcon,
    required String title,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 1,
          color: Colors.white54,
        ),
      ),
      onPressed: action,
      child: SizedBox(
        height: 60,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(buttonIcon, color: buttonColor),
              const SizedBox(height: 5),
              Text(title, style: TextStyle(color: buttonColor)),
            ],
          ),
        ),
      ),
    );
  }
}
