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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('images/backgroundColorBlue.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
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
                          child: const Icon(
                            Icons.near_me,
                            color: Colors.white,
                            size: 35.0,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Container(
                          height: 37,
                          width: 250,
                          child: const TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red, // 흰색으로 변경
                                ),
                              ),
                              hintText: '도시 검색',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '검색',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          // const Icon(
                          //   Icons.search,
                          //   size: 35.0,
                          // ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: const [
                              Text(
                                '도시표기',
                                style: font30TextStyle,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '온도표기',
                                style: font30TextStyle,
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
                                '습도 :',
                                style: font20TextStyle,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '체감온도 :',
                                style: font20TextStyle,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '풍향/풍속 :',
                                style: font20TextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
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
