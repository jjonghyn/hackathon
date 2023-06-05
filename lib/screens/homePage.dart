import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/loadingPage.dart';
import 'package:weather_app/screens/searchResultPage.dart';

import '../constants/textStyle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePagePageState createState() => _HomePagePageState();
}

class _HomePagePageState extends State<HomePage> {
  bool loding = false; //로딩바 false 선언

  @override
  void initState() {
    super.initState();
    //메서드들...
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectWeatherData(); //날씨 데이터 가지고오기.
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*
   * 날씨 데이터 가지고오기.
   *
   */

  selectWeatherData() {
    setState(() {
      loding = false; //로딩바 초기화
    });

    //데이터불러오는 코드 심기

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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            //현재위치 조회
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.near_me,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ),
                        ),
                        Container(
                          height: 37,
                          width: 250,
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
                                //         borderSide: BorderSide(
                                //           color: Colors.white,
                                //           width: 30, // 테두리의 굵기 조정
                                //         ),
                              ),
                              hintText: '도시 검색',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              size: 35.0,
                              color: Colors.white,
                            ),
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
                              children: const [
                                Text(
                                  '안양시',
                                  style: font25TextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  ' 25°',
                                  style: font60TextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '습도 : 55%',
                                  style: font17TextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '체감온도 : 24°',
                                  style: font17TextStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '풍향/풍속 :\n서남서 10m/s',
                                  style: font17TextStyle,
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
                        style: font17TextStyle,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  '10시'
                                ),
                                Text(
                                    '☁'
                                ),
                                Text(
                                    '20°'
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                    '11시'
                                ),
                                Text(
                                    '☁'
                                ),
                                Text(
                                    '23°'
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                    '12시'
                                ),
                                Text(
                                    '☁'
                                ),
                                Text(
                                    '25°'
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                    '13시'
                                ),
                                Text(
                                    '☁'
                                ),
                                Text(
                                    '26°'
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                    '14시'
                                ),
                                Text(
                                    '☁'
                                ),
                                Text(
                                    '28°'
                                ),
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
                              children: [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                              children: [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                              children: [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                              children: [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                              children: [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                              children: [
                                Text('내일'),
                                Text('6.6'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☔0%/0%'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('☀/☀'),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
