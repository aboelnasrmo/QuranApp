import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quranapp/core/utlis/router.dart';

// Future<void> main() async {
//   await JustAudioBackground.init(
//     androidNotificationChannelId: 'com.aboelnasrmo.quranapp.channel.audio',
//     androidNotificationChannelName: 'Audio playback',
//     androidNotificationOngoing: true,
//   );
//   runApp(const MyApp());
// }
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
