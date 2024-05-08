import 'dart:async';

class OtpTimer {
  final int durationInSeconds;
  final Function onTimerFinish;
  final Function(String time) getTime;
  final Function(int seconds)? getSecondsRemaining;
  late Timer _timer;
  late int _secondsRemaining;

  OtpTimer({
    required this.durationInSeconds,
    required this.onTimerFinish,
    required this.getTime,
    this.getSecondsRemaining,
  });

  void startTimer() {
    _secondsRemaining = durationInSeconds.abs();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsRemaining = _secondsRemaining - 1;
      if (_secondsRemaining <= 0) {
        _timer.cancel();
        onTimerFinish();
        stopTimer();
      }
      if (getSecondsRemaining != null) {
        getSecondsRemaining!(_secondsRemaining < 1 ? 0 : _secondsRemaining);
      }

      getTime(getFormattedTime());
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  String getFormattedTime() {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    getTime('$minutes:${seconds.toString().padLeft(2, '0')}');
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
