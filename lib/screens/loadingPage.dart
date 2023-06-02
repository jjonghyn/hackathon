import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
  }

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // getLocationData();
  }
  //
  // //날씨데이터 가져오기
  // void getLocationData() async {
  //   var weatherData = await WeatherModel().getLocationWeather();
  //
  //   //날씨데이터를 가지고 LocationScreen으로
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return LocationScreen(
  //       locationWeather: weatherData,
  //     );
  //   }));
  // }

  //spinKit라이브러리로 로딩구현
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.blueAccent,
          size: 100.0,
        ),
      ),
    );
  }
}