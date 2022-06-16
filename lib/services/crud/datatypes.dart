import 'package:flutter/material.dart';

@immutable
class UserData {
  final String login;

  const UserData(this.login);
}

@immutable
class PostMeta {
  final int id;
  final UserData author;
  final DateTime date;
  final int likeCount;
  final int shareCount;

  const PostMeta({
    required this.id,
    required this.author,
    required this.date,
    required this.likeCount,
    required this.shareCount,
  });
}
