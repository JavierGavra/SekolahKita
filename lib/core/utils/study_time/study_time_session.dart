class StudyTimeSession {
  static DateTime? _startTime;

  static void start() {
    _startTime = DateTime.now();
  }

  static int finish() {
    if (_startTime == null) return 0;

    final seconds = DateTime.now().difference(_startTime!).inSeconds;

    _startTime = null;
    return seconds;
  }

  static void cancel() {
    _startTime = null;
  }
}
