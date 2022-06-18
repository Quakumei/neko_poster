import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neko_poster/constants/image_assets.dart';
import 'package:neko_poster/services/models/model.dart';
import 'package:neko_poster/views/_widgets.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final DateFormat dateFormatter = DateFormat('mm:hh MM-dd-yyyy');

  static const loremIpsum =
      """Maiores soluta porro nulla architecto omnis accusantium fugit. Iste optio harum assumenda nam. Quibusdam id tenetur nihil. Magni vel et et minima. Quo dolorem et repudiandae dolore. Dolor aut rerum aperiam facere voluptatem.""";

  final cardList = <StatefulWidget>[
    postCard(
      postText: loremIpsum,
      postImage: postImageSample,
      postMeta: PostMeta(
        id: 0,
        date: DateTime.now(),
        likeCount: 0,
        shareCount: 0,
        author: const UserData("Neko-ark"),
      ),
    ),
    postCard(
      postText: loremIpsum,
      postImage: postImageSample,
      postMeta: PostMeta(
        id: 0,
        date: DateTime.now(),
        likeCount: 0,
        shareCount: 0,
        author: const UserData("Neko-ark"),
      ),
    ),
    postCard(
      postText: null,
      postImage: postImageSample,
      postMeta: PostMeta(
        id: 0,
        date: DateTime.now(),
        likeCount: 0,
        shareCount: 0,
        author: const UserData("Neko-ark"),
      ),
    ),
    postCard(
      postText: loremIpsum,
      postImage: null,
      postMeta: PostMeta(
        id: 0,
        date: DateTime.now(),
        likeCount: 0,
        shareCount: 0,
        author: const UserData("Neko-ark"),
      ),
    ),
    postCard(
      postText: null,
      postImage: null,
      postMeta: PostMeta(
        id: 0,
        date: DateTime.now(),
        likeCount: 0,
        shareCount: 0,
        author: const UserData("Neko-ark"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: appBarTitle(title: "Лента 🧶"),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Text("Новости"),
              ),
              Tab(icon: Text("Для вас")),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: TabBarView(children: [
            ListView(
              children: <StatefulWidget>[
                    writePostButtonCard(context: context),
                  ] +
                  cardList,
            ),
            ListView(
              children: [cardList[2]],
            ),
          ]),
        ),
      ),
    );
  }
}
