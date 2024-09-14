import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_state.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/core/config/assets/app_vectors.dart';
import 'package:flutter_clean_architecture_spotify/core/config/theme/app_colors.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:flutter_clean_architecture_spotify/features/music/now_playing/widgets/slider_song.dart';
import 'package:flutter_clean_architecture_spotify/features/music/now_playing/widgets/song_action.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LyricPage extends StatefulWidget {
  const LyricPage({super.key, required this.song});
  final SongEntity song;

  @override
  State<LyricPage> createState() => _LyricPageState();
}

class _LyricPageState extends State<LyricPage> {
  late NowPlayingCubit cubit;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  StreamSubscription? streamSubscription;
  @override
  void initState() {
    super.initState();
    _getLyrics();
  }

  Future<void> _getLyrics() async {
    cubit = sl<NowPlayingCubit>();
    streamSubscription = cubit.player.positionStream.listen((duration) {
      DateTime dt = DateTime(1970, 1, 1).copyWith(
          hour: duration.inHours,
          minute: duration.inMinutes.remainder(60),
          second: duration.inSeconds.remainder(60));
      if (widget.song.lyrics.isNotEmpty && widget.song.lyrics.length > 4) {
        for (int index = 3; index < widget.song.lyrics.length; index++) {
          if (widget.song.lyrics[index].timeStamp!.isAfter(dt)) {
            itemScrollController.scrollTo(
                index: index - 3, duration: const Duration(milliseconds: 600));
            break;
          }
        }
      }
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, NowPlayingState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: widget.song.lyrics.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6),
                            BlendMode.darken,
                          ),
                          image: NetworkImage(
                            widget.song.cover,
                          ),
                        )),
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            BasicAppbar(
                                leading: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.04),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  widget.song.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textWhite,
                                  ),
                                )),
                            Expanded(
                              child: StreamBuilder<Duration>(
                                  stream: cubit.player.positionStream,
                                  builder: (context, snapshot) {
                                    return ScrollablePositionedList.builder(
                                      itemCount: widget.song.lyrics.length,
                                      itemBuilder: (context, index) {
                                        Duration duration = snapshot.data ??
                                            const Duration(seconds: 0);
                                        DateTime dt =
                                            DateTime(1970, 1, 1)
                                                .copyWith(
                                                    hour: duration.inHours,
                                                    minute: duration.inMinutes
                                                        .remainder(60),
                                                    second: duration.inSeconds
                                                        .remainder(60));
                                        return GestureDetector(
                                          onTap: () {
                                            Duration d = Duration(
                                                hours: widget.song.lyrics[index]
                                                    .timeStamp!.hour,
                                                minutes: widget
                                                    .song
                                                    .lyrics[index]
                                                    .timeStamp!
                                                    .minute,
                                                seconds: widget
                                                    .song
                                                    .lyrics[index]
                                                    .timeStamp!
                                                    .second,
                                                milliseconds: widget
                                                    .song
                                                    .lyrics[index]
                                                    .timeStamp!
                                                    .millisecond,
                                                microseconds: widget
                                                    .song
                                                    .lyrics[index]
                                                    .timeStamp!
                                                    .microsecond);
                                            sl<NowPlayingCubit>().handleSeek(
                                                d.inSeconds.toDouble());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 16.0),
                                            child: Text(
                                              widget.song.lyrics[index].words!,
                                              style: TextStyle(
                                                color: widget.song.lyrics[index]
                                                        .timeStamp!
                                                        .isAfter(dt)
                                                    ? AppColors.textWhite
                                                    : AppColors.primary,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemScrollController:
                                          itemScrollController,
                                      scrollOffsetController:
                                          scrollOffsetController,
                                      itemPositionsListener:
                                          itemPositionsListener,
                                      scrollOffsetListener:
                                          scrollOffsetListener,
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: Text(
                          'No lyrics found',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    widget.song.cover,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.song.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.song.artist,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                  AppVectors.icFavoriteBottomAppBar))
                        ],
                      ),
                      const Spacer(),
                      SliderSong(duration: widget.song.duration),
                      const Spacer(),
                      const SongAction(),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
