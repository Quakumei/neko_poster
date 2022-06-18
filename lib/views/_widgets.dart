import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:neko_poster/constants/routes.dart';
import 'package:neko_poster/services/models/model.dart';

const innerPadding = 12.0;

Card infoCard({required Widget child}) {
  return Card(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.white54),
      borderRadius: BorderRadius.circular(8.0),
    ),
    color: Colors.white24,
    child: child,
  );
}

Text appBarTitle({required String title}) {
  return Text(
    title,
    style: GoogleFonts.zenKurenaido(
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
  );
}

StatefulWidget postCard({
  required String? postText,
  required Image? postImage,
  required PostMeta postMeta,
}) {
  return Material(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: infoCard(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(innerPadding),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Icon(Icons.person, size: 42),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                postMeta.author.login,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                DateFormat('hh:mm dd/mm/yy')
                                    .format(postMeta.date),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  if (postText != null && postText.isNotEmpty) Text(postText),
                ],
              ),
            ),
            if (postImage != null) postImage,
            Padding(
              padding: const EdgeInsets.all(innerPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LikeButton(
                      likeCount: postMeta.shareCount,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.share,
                          color: isLiked ? Colors.green : Colors.grey,
                          size: 30,
                        );
                      }),
                  const SizedBox(width: 10),
                  LikeButton(
                    likeCount: postMeta.likeCount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Material writePostButtonCard({required BuildContext context}) {
  return Material(
    child: infoCard(
      child: Padding(
        padding: const EdgeInsets.all(innerPadding),
        child: ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pushNamed(newPostRoute);
          },
          child: const Text("Есть что мяукнуть? Намурчи новость!"),
        ),
      ),
    ),
  );
}
