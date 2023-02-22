import 'package:go_router/go_router.dart';
import 'package:quranapp/core/constant/my_text.dart';
import 'package:quranapp/view/quran/quran_view.dart';

import '../../view/play_surah/home_view.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: MyText.playSurah,
        builder: (context, state) => const PlaySurah(),
      ),
      GoRoute(
        path: MyText.quranPage,
        builder: (context, state) => QuranView(),
      ),
    ],
  );
}
