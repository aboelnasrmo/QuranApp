import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quranapp/core/constant/my_text.dart';

import '../../data/play_list/play_list.dart';

class QuranView extends StatelessWidget {
  QuranView({super.key});
  final _playList = PlayList.playList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Color(0xff144771), Color(0xff071A2C)],
          ),
        ),
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(MyText.playSurah);
              },
              child: const Text('Go')),
        ),
      ),
    );
  }
}
