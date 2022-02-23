import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_video/video_player.dart';
import 'package:youtube_video/youtube_player.dart';
import 'package:youtube_video/youtube_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(     
        primarySwatch: Colors.blue,
      ),
      home: const SingleVideoPlayer() //VideoPlayerScreen() //YouTubePage(title: 'Flutter Demo Home Page'),
    );
  }
}

