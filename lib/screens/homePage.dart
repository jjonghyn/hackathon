import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/loadingPage.dart';
import 'package:weather_app/screens/searchResultPage.dart';
import 'package:weather_app/servies/location.dart';

import '../constants/commonTextStyle.dart';
import '../constants/timeWidget.dart';
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
  DateTime currentTime = DateTime.now();
  int hours = 24;

  // printNextHour(currentTime, hours);

  // DateTime currentTime = DateTime.now(); //현재시간

  @override
  void initState() {
    super.initState();
    //메서드들...
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectWeatherData();
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
              constraints: const BoxConstraints.expand(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: Row(
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
                          child: TextField(
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
                        IconButton(
                          iconSize: 35,
                          color: Colors.white,
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,0,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '안양시',
                              style: CommonTextStyle.font25TextStyle,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${mapData?['getUltraSrtNcst']['T1H']}°',
                              style: CommonTextStyle.font50TextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,20,0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                '풍향 : ${mapData?['getUltraSrtNcst']['VVV']}${mapData?['getUltraSrtNcst']['UUU']}풍',
                                style: CommonTextStyle.font17TextStyle,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '풍속 : ${mapData?['getUltraSrtNcst']['WSD']}m/s',
                                style: CommonTextStyle.font17TextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "이번 예보기간에는 구름많은 날이 많겠습니다.아침 기온은 14~21도, 낮 기온은 23~30도로 평년(최저기온 15~18도, 최고기온 24~28도)과 비슷하겠습니다.",
                      textAlign: TextAlign.center,
                      style: CommonTextStyle.font17TextStyle,
                    ),
                  ),
                  Container(
                    height: 70,
                    margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Scrollbar(
                      thickness: 0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 24,
                        itemBuilder: (context, int index) {
                          return SizedBox(
                            width: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Text('data'),
                                Text(
                                  '${mapData?['getVilageFcst'][index]['DateTime'].substring(8, 10)}'
                                  '시',
                                  style: CommonTextStyle.font17TextStyle,
                                ),
                                Text(
                                  '${mapData?['getVilageFcst'][index]['SKY']}',
                                  style: CommonTextStyle.font17TextStyle,
                                ),
                                Text(
                                  '${mapData?['getVilageFcst'][index]['TMP']}°',
                                  style: CommonTextStyle.font17TextStyle,
                                ),
                                // Text('${mapData?['getVilageFcst'][]['category']['TMP']}°'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    margin: EdgeInsets.all(8),
                    child: Scrollbar(
                      thickness: 0,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(24, 10, 0, 15),
                                      child: Text(
                                        'ㅁㄴㅇ'
                                        // '${mapData?['getDateValueList'][index]['DateTime'].substring(6, 8)}일',
                                        // style: CommonTextStyle.font17TextStyle,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        '☔0%/0%',
                                        style: CommonTextStyle.font17TextStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        '☀/☀',
                                        style: CommonTextStyle.font17TextStyle,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'ㅁㄴㅇ/ㅁ'
                                        // '${mapData?['getDateValueList'][index]['LowestTMP']}°/${mapData?['getDateValueList'][index]['HighestTMP']}°',
                                        // style: CommonTextStyle.font17TextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           children: const [
                  //             Text('6.6'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☔0%/0%'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☀/☀'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('13°/26°'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           children: const [
                  //             // Text('내일'),
                  //             Text('6.7'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☔0%/0%'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☀/☀'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('13°/26°'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           children: const [
                  //             Text('6.8'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☔0%/0%'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☀/☀'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('13°/26°'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           children: const [
                  //             Text('6.9'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☔0%/0%'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☀/☀'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('13°/26°'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           children: const [
                  //             Text('6.10'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☔0%/0%'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('☀/☀'),
                  //       ),
                  //     ),
                  //     const Expanded(
                  //       child: Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text('13°/26°'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            )
          : const LoadingPage(),
    );
  }
}
