import 'package:flutter_clean_architecture_spotify/common/app_navigator.dart';
import 'package:flutter_clean_architecture_spotify/core/routes/routes.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:go_router/go_router.dart';

class HomeNavigator extends AppNavigator {
  HomeNavigator({required super.context});

  void goToNowPlaying(SongEntity song) {
    GoRouter.of(context).pushNamed(AppRoutes.nowPlaying, extra: {'song': song, 
      'uniqueTag': 'winter'
    });
  }
}
