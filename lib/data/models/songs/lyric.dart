import 'package:flutter_clean_architecture_spotify/domain/entities/lyric.dart';

class Lyric {
  final String? words;
  final DateTime? timeStamp;

  const Lyric(this.words, this.timeStamp);

  factory Lyric.fromJson(Map<String, dynamic> data) {
    return Lyric(data['words'], data['timeStamp']);
  }

  Map<String, dynamic> toJson() {
    return {
      'words': words,
      'timeStamp': timeStamp,
    };
  }
}

extension LyricX on Lyric {
  LyricEntity toEntity() {
    return LyricEntity(
      words: words!,
      timeStamp: timeStamp!,
    );
  }
}
