extension Dur on Duration {
  String get format {
    return "${inMinutes.toString().padLeft(2, '0')}:${"${inSeconds % 60}".padLeft(2, '0')}";
  }
}
