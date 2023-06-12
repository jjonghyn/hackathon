class TimeWidget {
  printNextHour(DateTime currentTime, int hoursRemaining) {
    if (hoursRemaining == 0) {}

    DateTime nextHour = currentTime.add(Duration(hours: 1));
    print(nextHour);

    printNextHour(nextHour, hoursRemaining - 1);

    print(printNextHour(currentTime, hoursRemaining));

    return printNextHour(currentTime, hoursRemaining);
  }
}
