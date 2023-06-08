import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/servies/netWork.dart';

import 'location.dart';

//기상청 api 초단기 실황 조회
const getUltraSrtNcstURL =
    'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst';
//기상청 api 초단기 예보 조회
const getUltraSrtFcstURL =
    'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst';
//기상청 api 단기 예보 조회
const getVilageFcstURL =
    'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst';
//기상청 api 중기 기온 조회
const getMidTaURL =
    'https://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa';
//기상청 api 중기 육상 예보 조회
const getMidLandFcstURL =
    'https://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst';

//공공데이터에서 발급받은 나의 기상청 api key
const serviceKey =
    '9OX4Slh4W3dxrLci5bFKmza/QEZJp8tfW9cna8a6T7GjZEwX1RSQPO/wXg4vemOPpQIh6S23eDDgT0SDDfTiRw==';



class WeatherModel {

  //초단기 실황 조회
  Future<Map<String, dynamic>> getUltraSrtNcstWeatherData() async {

    final currentTime = DateTime.now();
    final baseDate =
        '${currentTime.year}${currentTime.month.toString().padLeft(2, '0')}${currentTime.day.toString().padLeft(2, '0')}';
    const baseTime = '0600';

    NetworkHelper networkHelper = NetworkHelper(
        '$getUltraSrtNcstURL?serviceKey=$serviceKey&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=60&ny=127');
    print('Current Base Date: $baseDate');
    print('Current Base Time: $baseTime');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  //초단기 예보 조회
  Future<Map<String, dynamic>> getUltraSrtFcstWeatherData() async {
    final currentTime = DateTime.now();
    final baseDate =
        '${currentTime.year}${currentTime.month.toString().padLeft(2, '0')}${currentTime.day.toString().padLeft(2, '0')}';
    const baseTime = '0630';

    NetworkHelper networkHelper = NetworkHelper(
        '$getUltraSrtFcstURL?serviceKey=$serviceKey&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=60&ny=127');
    print('Current Base Date: $baseDate');
    print('Current Base Time: $baseTime');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }


}
