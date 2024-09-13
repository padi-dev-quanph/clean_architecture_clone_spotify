import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_cubit.dart';
import 'package:flutter_clean_architecture_spotify/common/blocs/now_playing/now_playing_state.dart';
import 'package:flutter_clean_architecture_spotify/common/widgets/basic_appbar.dart';
import 'package:flutter_clean_architecture_spotify/data/models/songs/lyric.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';
import 'package:flutter_clean_architecture_spotify/service_locator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LyricPage extends StatefulWidget {
  const LyricPage({super.key, required this.song});
  final SongEntity song;

  @override
  State<LyricPage> createState() => _LyricPageState();
}

class _LyricPageState extends State<LyricPage> {
  List<Lyric>? lyrics;
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
      if (lyrics != null) {
        for (int index = 0; index < lyrics!.length; index++) {
          if (index > 4 && lyrics![index].timeStamp!.isAfter(dt)) {
            itemScrollController.scrollTo(
                index: index - 3, duration: const Duration(milliseconds: 600));
            break;
          }
        }
      }
    });
    print(
        '---convert: ${converQuery(widget.song.title)}%${converQuery(widget.song.artist)}---');
    final response = await http.get(Uri.parse(
        'https://paxsenixofc.my.id/server/getLyricsMusix.php?q=${converQuery(widget.song.title)}%${converQuery(widget.song.artist)}&type=default'));

    String data = response.body;
    lyrics = data
        .split('\n')
        .map((e) => Lyric(e.split(' ').sublist(1).join(' '),
            DateFormat("[mm:ss.SS]").parse(e.split(' ')[0])))
        .toList();

    setState(() {});
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
          appBar: BasicAppbar(
            title: Text(state.song.title),
          ),
          body: lyrics != null
              ? SafeArea(
                  bottom: false,
                  child: Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0)
                        .copyWith(top: 20),
                    child: StreamBuilder<Duration>(
                        stream: cubit.player.positionStream,
                        builder: (context, snapshot) {
                          return ScrollablePositionedList.builder(
                            itemCount: lyrics!.length,
                            itemBuilder: (context, index) {
                              Duration duration =
                                  snapshot.data ?? const Duration(seconds: 0);
                              DateTime dt = DateTime(1970, 1, 1).copyWith(
                                  hour: duration.inHours,
                                  minute: duration.inMinutes.remainder(60),
                                  second: duration.inSeconds.remainder(60));
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  lyrics![index].words!,
                                  style: TextStyle(
                                    color: lyrics![index].timeStamp!.isAfter(dt)
                                        ? Colors.white38
                                        : Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            itemScrollController: itemScrollController,
                            scrollOffsetController: scrollOffsetController,
                            itemPositionsListener: itemPositionsListener,
                            scrollOffsetListener: scrollOffsetListener,
                          );
                        }),
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }
}

// Bo Toc mixigaming -> botocmixigamin

String converQuery(String str) {
  return str.replaceAll(' ', '').toLowerCase();
}
