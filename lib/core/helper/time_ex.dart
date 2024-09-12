String convertDurationFromNum(num duration) {
  int intPart = duration.toInt();

  int decimalPart = ((duration - intPart) * 100).round();

  return '$intPart:$decimalPart';
}

String convertDurationTimeToString(double duration) {
  int intDuration = duration.toInt();

  int minutes = intDuration ~/ 60;
  int seconds = intDuration % 60;

  return '$minutes:${seconds < 10 ? '0$seconds' : seconds}';
}

double getTimeFollowSecond(num duration) {
  int intPart = duration.toInt();

  int decimalPart = ((duration - intPart) * 100).round();

  int timeFollowSecond = (intPart * 60) + decimalPart;
  return timeFollowSecond.toDouble();
}

String formatDuration(Duration d) {
  final minutes = d.inMinutes.remainder(60);
  final seconds = d.inSeconds.remainder(60);
  return '$minutes:${seconds < 10 ? '0$seconds' : seconds}';
}
