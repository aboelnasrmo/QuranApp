import 'package:go_router/go_router.dart';
import 'package:quranapp/core/constant/my_text.dart';

import '../../view/home/home_view.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: MyText.homePage,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
