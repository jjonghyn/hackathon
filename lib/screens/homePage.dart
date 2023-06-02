import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePagePageState createState() => _HomePagePageState();
}

class _HomePagePageState extends State<HomePage> {
  // WeatherModel weather = WeatherModel();
  // int temperature = 0;
  // String weatherIcon = '';
  // String cityName = '';
  // String weatherMessage = '';

  @override
  void initState() {
    super.initState();
    // updateUI(widget.locationWeather);
  }

  // void updateUI(dynamic weatherData) {
  //   setState(() {
  //     if (weatherData == null) {
  //       temperature = 0;
  //       weatherIcon = 'Error';
  //       weatherMessage = 'Unable to get weather data';
  //       cityName = '';
  //       return;
  //     }
  //     double temp = weatherData['main']['temp']; //api에서 받은 온도 데이터
  //     temperature = temp.toInt(); //api를 통헤 받은 온도 소수점 없이 출력을 위해 int형변환
  //     var condition = weatherData['weather'][0]['id']; // weather의 첫번째 id값 condition에 담기
  //     weatherIcon = weather.getWeatherIcon(condition); //condition값에 따라 weatherIcon변환
  //     weatherMessage = weather.getMessage(temperature); //온도에 따라 메시지 출력
  //     cityName = weatherData['name'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/backgroundColorBlue.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      // var weatherData = await weather.getLocationWeather();
                      // updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      // var typedName = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return const CityScreen();
                      //     },
                      //   ),
                      // );
                      // if (typedName != null) {
                      //   var weatherData =
                      //   await weather.getCityWeather(typedName);
                      //   updateUI(weatherData);
                      // }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'asd'
                      // '$temperature°',
                      // style: kTempTextStyle,
                    ),
                    Text(
                      'asd'
                      // weatherIcon,
                      // style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  'asd'
                  // '$weatherMessage in $cityName',
                  // textAlign: TextAlign.right,
                  // style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}