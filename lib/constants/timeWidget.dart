import 'package:intl/intl.dart';
class TimeWidget {
  void displayClosestTime() {
    DateTime now = DateTime.now();
    List<String> targetTimes = ['02:00', '05:00', '08:00', '11:00', '14:00', '17:00', '20:00', '23:00'];

    // Format current time
    DateFormat formatter = DateFormat('HH:mm');
    String currentTime = formatter.format(now);

    print('Current Time: $currentTime');

    String? closestTime = getClosestTime(currentTime, targetTimes);
    print('Closest Time: $closestTime');
  }

  String? getClosestTime(String currentTime, List<String> targetTimes) {
    DateFormat formatter = DateFormat('HH:mm');
    DateTime current = formatter.parse(currentTime);

    Duration? minDifference;
    String? closestTime;

    for (String time in targetTimes) {
      DateTime target = formatter.parse(time);
      Duration difference = current.difference(target).abs();

      if (minDifference == null || difference < minDifference) {
        minDifference = difference;
        closestTime = time;
      }
    }

    return closestTime;
  }
}
