extension DurationString on Duration{
  String get str {
    return '$inMinutes:${(inSeconds % 60).toString().padLeft(2, '0')}';
  }
}