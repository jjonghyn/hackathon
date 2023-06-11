import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/loadingPage.dart';
import 'package:weather_app/screens/searchResultPage.dart';
import 'package:weather_app/servies/location.dart';

import '../constants/commonTextStyle.dart';
import '../servies/areaChange.dart';
import '../servies/weatherInfo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePagePageState createState() => _HomePagePageState();
}

class _HomePagePageState extends State<HomePage> {
  bool loding = false; //로딩바 false 선언
  Map? mapData = {}; //초단기실황 데이터 변수 선언


  @override
  void initState() {
    super.initState();
    selectWeatherData();
    //메서드들...
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     //날씨 데이터 가지고오기.
  }

  @override
  void dispose() {
    super.dispose();
  }



  /*
   * 날씨 데이터 가지고오기.
   *
   */
  Future selectWeatherData() async {

    setState(() {
      loding = false; //로딩바 초기화
    });

    //데이터불러오는 코드 심기
    mapData = await WeatherModel().getMapList();
    log("---> " + mapData.toString());
    //categoryValueData = await WeatherModel().getUltraSrtNcstCategoryValue(); //초단기실황조회 map형식 데이터 categoryValueData 변수에 담기
    //var utraSrtFcstWeatherData = await WeatherModel().getUltraSrtFcstWeatherData(); //초단기 예보 조회
    // var weatherData = await WeatherModel().getUltraSrtFcstWeatherData(); //단기 예보 조회
    // var weatherData = await WeatherModel().getUltraSrtFcstWeatherData(); //중기 기온 조회
    // var weatherData = await WeatherModel().getUltraSrtFcstWeatherData(); //중기 육상 예보 조회
    // var weatherData = await WeatherModel().getUltraSrtFcstWeatherData(); //중기 전망 조회
    // print('초단기 실황 : $UltraSrtNcstWeatherData');
    // print('초단기 예보 : $UltraSrtFcstWeatherData');
    //print(utraSrtFcstWeatherData);
    //print ('카테고리가공데이터homepage확인 $categoryValueData');


    setState(() {
      loding = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loding
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/backgroundColorBlue.png'),
                  fit: BoxFit.cover,
                ),
              ),
              // constraints: const BoxConstraints.expand(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: IconButton(
                              iconSize: 35,
                              color: Colors.white,
                              icon: const Icon(Icons.near_me),
                              onPressed: () {
                                selectWeatherData();
                              },
                              // color: Colors.white,
                              // size: 35.0,
                            ),
                          ),
                        ),
                        Container(
                          width: 255,
                          height: 40,
                          child: const TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                // borderSide: BorderSide(
                                //   color: Colors.white,
                                //   width: 30, // 테두리의 굵기 조정
                                // ),
                              ),
                              hintText: '도시 검색',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            iconSize: 35,
                            color: Colors.white,
                            icon: const Icon(Icons.search),
                            onPressed: () {
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '안양시',
                                  style: CommonTextStyle.font25TextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${mapData?['getUltraSrtNcst']['T1H']}°',
                                  style: CommonTextStyle.font60TextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '습도 : ${mapData?['getUltraSrtNcst']['REH']}%',
                                  style: CommonTextStyle.font17TextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                // Text(
                                //   '체감온도 : 24°',
                                //   style: CommonTextStyle.font17TextStyle,
                                //   textAlign: TextAlign.center,
                                // ),
                                Text(
                                  '풍향/풍속 :\n${mapData?['getUltraSrtNcst']['VVV']}${mapData?['getUltraSrtNcst']['UUU']}풍 ${mapData?['getUltraSrtNcst']['WSD']}m/s',
                                  style: CommonTextStyle.font17TextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "이번 예보기간에는 구름많은 날이 많겠습니다.아침 기온은 14~21도, 낮 기온은 23~30도로 평년(최저기온 15~18도, 최고기온 24~28도)과 비슷하겠습니다.",
                        textAlign: TextAlign.center,
                        style: CommonTextStyle.font17TextStyle,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('10시'),
                                Text('☁'),
                                Text('20°'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('11시'),
                                Text('☁'),
                                Text('23°'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('12시'),
                                Text('☁'),
                                Text('25°'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('13시'),
                                Text('☁'),
                                Text('26°'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('14시'),
                                Text('☁'),
                                Text('28°'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('13°/26°'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('13°/26°'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('13°/26°'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('13°/26°'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('13°/26°'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('13°/26°'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : const LoadingPage(),
    );
  }
}
