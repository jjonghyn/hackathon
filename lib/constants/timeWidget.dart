import 'package:intl/intl.dart';

//현재 시간 기준으로 아래 targetTimes중 가장 가까운 시간값 가져오기
class TimeWidget {
  String? getClosestTime() {
    List<String> targetTimes = [
      '0200',
      '0500',
      '0800',
      '1100',
      '1400',
      '1700',
      '2000',
      '2300'
    ];

    //현재시간 구하기
    DateFormat formatter = DateFormat('HHmm');
    DateTime currentTime = DateTime.now();
    String nowTime = formatter.format(currentTime);

    String? closestTime;
    int? minDifference;

    //현재시간과 구하고자 하는 시간값 계산
    for (String time in targetTimes) {
      int target = int.parse(time);
      int difference = (target - int.parse(nowTime)).abs();

      if (minDifference == null || difference < minDifference) {
        minDifference = difference;
        closestTime = time;
      }
    }
    return closestTime;
  }
}
