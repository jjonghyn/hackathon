import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/homePage.dart';

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

//  날씨데이터 가져오기
//   void getLocationData()
  // async
  // {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const HomePage()),
  //   );
    // var weatherData = await WeatherModel().getLocationWeather();

    //날씨데이터를 가지고 homePage push
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return HomePage(
    //       // locationWeather: weatherData,
    //       );
    // }));
  // }

  //spinKit 라이브러리로 로딩구현
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/backgroundColorWhite.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SpinKitDoubleBounce(
                color: Colors.blue,
                size: 70.0,
              ),
              SizedBox(height: 16.0), // 추가: 텍스트와 SpinKit 간격 조절을 위한 SizedBox
              Text(
                '날씨를 조회 중입니다...',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}