import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';

class NowPlayingState extends Equatable {
  final LoadStatus loadStatus;
  final SongEntity song;
  final Duration position;
  final bool isPlaying;

  const NowPlayingState(
      {required this.loadStatus,
      required this.song,
      required this.position,
      required this.isPlaying});

  @override
  List<Object> get props => [loadStatus, song, position, isPlaying];

  factory NowPlayingState.initial() {
    return NowPlayingState(
      loadStatus: LoadStatus.initial,
      song: SongEntity.empty(),
      position: Duration.zero,
      isPlaying: false,
    );
  }


  

  NowPlayingState copyWith(
      {SongEntity? song,
      LoadStatus? loadStatus,
      Duration? position,
      bool? isPlaying}) {
    return NowPlayingState(
      loadStatus: loadStatus ?? this.loadStatus,
      song: song ?? this.song,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
