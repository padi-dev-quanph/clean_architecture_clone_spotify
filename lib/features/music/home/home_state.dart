import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_spotify/common/enums/load_status.dart';
import 'package:flutter_clean_architecture_spotify/domain/entities/song.dart';

class HomeState extends Equatable {
  final LoadStatus loadStatus;
  final List<SongEntity> songs;
  final String message;

  const HomeState({
    required this.loadStatus,
    required this.songs,
    required this.message,
  });

  @override
  List<Object?> get props => [loadStatus, songs, message];

  factory HomeState.initial() {
    return const HomeState(
      loadStatus: LoadStatus.initial,
      songs: [],
      message: '',
    );
  }

  HomeState copyWith({
    LoadStatus? loadStatus,
    List<SongEntity>? songs,
    String? message,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      songs: songs ?? this.songs,
      message: message ?? this.message,
    );
  }
}
