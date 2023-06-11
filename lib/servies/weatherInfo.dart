import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/servies/netWork.dart';

import 'areaChange.dart';
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
    Location location = Location();

    await location.getCurrentLocation();

    double lat = location.latitude;
    double lng = location.longitude;

    var gpsToGridData = ConvGridGps.gpsToGRID(
        lat, lng); //geolocator 라이브러리로 불러온 현재 나의 위경도 데이터를 격자데이터로 변환

    var x = gpsToGridData['x'];
    var y = gpsToGridData['y'];

    DateTime currentTime = DateTime.now();

    //현재 년도월일
    String baseDate =
    '20230611';
        // '${currentTime.year}${currentTime.month.toString().padLeft(2, '0')}${currentTime.day.toString().padLeft(2, '0')}';

    //현재 시간 -1시간
    String baseTime =
    '2300';
        // '${currentTime.subtract(Duration(hours: 1)).hour.toString()}00';

    NetworkHelper networkHelper = NetworkHelper(
        '$getUltraSrtNcstURL?serviceKey=$serviceKey&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=$x&ny=$y');
    var weatherData = await networkHelper.getData();
    return weatherData;
    /*
    *********** weatherData의 값 ***********
    *{response:
    * {header:{resultCode: 00, resultMsg: NORMAL_SERVICE},
    * body: {dataType: JSON,items:{item:
    * [{baseDate: 20230609, baseTime: 1400, category: PTY, nx: 60, ny: 121, obsrValue: 0},
    * {baseDate: 20230609, baseTime: 1400, category: REH, nx: 60, ny: 121, obsrValue: 40},
    * {baseDate: 20230609, baseTime: 1400, category: RN1, nx: 60, ny: 121, obsrValue: 0},
    * {baseDate: 20230609, baseTime: 1400, category: T1H, nx: 60, ny: 121, obsrValue: 27},
    * {baseDate: 20230609, baseTime: 1400, category: UUU, nx: 60, ny: 121, obsrValue: -0.4},
    * {baseDate: 20230609, baseTime: 1400, category: VEC, nx: 60, ny: 121, obsrValue: 169},
    * {baseDate: 20230609, baseTime: 1400, category: VVV, nx: 60, ny: 121, obsrValue: 2.4},
    * {baseDate: 20230609, baseTime: 1400, category: WSD, nx: 60, ny: 121, obsrValue: 2.4}]
    * },
    * pageNo: 1,
    * numOfRows: 10,
    * totalCount: 8}}}
    * */
  }

  //초단기 실황 데이터 가공
  Future<Map<String, dynamic>> getUltraSrtNcstCategoryValue() async {
    //가공할 데이터담을 map 변수 선언
    Map<String, dynamic> categoryValue = {};

    //전체 데이터 불러오기
    var weatherData = await getUltraSrtNcstWeatherData();

    print('asdasd: $weatherData');

    //item의 List 전체 데이터 추출
    var itemList = weatherData['response']['body']['items']['item'];

    for (var item in itemList) {
      //itemList의 category List 추출
      String category = item['category'];

      //itemList의 obsrValue List 추출
      var obsrValue = item['obsrValue'];

      //categoryValue변수에 key:category, value:obsrValue 담기
      categoryValue[category] = obsrValue;
    }

    //string타입의 UUU를 0.0과 비교를 위하여 string->double타입 변환

    if (double.parse(categoryValue['UUU']) < 0.0)
      categoryValue['UUU'] = '서';
    else if (double.parse(categoryValue['UUU']) > 0.0)
      categoryValue['UUU'] = '동';
    else if (double.parse(categoryValue['UUU']) == 0.0)
      categoryValue['UUU'] = '';

    if (double.parse(categoryValue['VVV']) < 0.0)
      categoryValue['VVV'] = '남';
    else if (double.parse(categoryValue['VVV']) > 0.0)
      categoryValue['VVV'] = '북';
    else if (double.parse(categoryValue['VVV']) == 0.0)
      categoryValue['VVV'] = '';

    return categoryValue;
  }

  //초단기 실황 조회
  Future<Map<String, dynamic>> getVilageFcstURLWeatherData() async {
    Location location = Location();

    await location.getCurrentLocation();

    double lat = location.latitude;
    double lng = location.longitude;

    var gpsToGridData = ConvGridGps.gpsToGRID(
        lat, lng); //geolocator 라이브러리로 불러온 현재 나의 위경도 데이터를 격자데이터로 변환

    var x = gpsToGridData['x'];
    var y = gpsToGridData['y'];

    DateTime currentTime = DateTime.now();

    DateTime oneHourAgo = currentTime.subtract(Duration(hours: 1));
    String formattedTime = DateFormat('HH').format(oneHourAgo).toString();

    //현재 년도월일
    String baseDate =
        '20230611';
    // '${currentTime.year}${currentTime.month.toString().padLeft(2, '0')}${currentTime.day.toString().padLeft(2, '0')}';

    //현재 시간 -1시간
    String baseTime = '0500';
    // '${currentTime.subtract(Duration(hours: 1)).hour.toString()}00';

    NetworkHelper networkHelper = NetworkHelper(
        '$getVilageFcstURL?serviceKey=$serviceKey&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=$x&ny=$y');
    var weatherData = await networkHelper.getData();
    print('단기예보조회 이친구가 24시간치 데이터 뽑아줌:$weatherData');

    return weatherData;

  }

  //초단기 예보 조회
  // Future<Map<String, dynamic>> getUltraSrtFcstWeatherData() async {
  //   Location location = Location();
  //
  //   await location.getCurrentLocation();
  //
  //   double lat = location.latitude;
  //   double lng = location.longitude;
  //
  //   //geolocator 라이브러리로 불러온 현재 나의 위경도 데이터를 격자데이터로 변환
  //   var gpsToGridData = ConvGridGps.gpsToGRID(lat, lng);
  //
  //   var x = gpsToGridData['x'];
  //   var y = gpsToGridData['y'];
  //
  //   DateTime currentTime = DateTime.now();
  //
  //   String baseDate =
  //       '20230612';
  //       // '${currentTime.year}${currentTime.month.toString().padLeft(2, '0')}${currentTime.day.toString().padLeft(2, '0')}';
  //
  //   var oneHourAgo = currentTime.subtract(Duration(hours: 1));
  //   var formattedTime = DateFormat('HH').format(oneHourAgo);
  //
  //
  //   String baseTime =
  //   '0100';
  //       // '${formattedTime}00';
  //       // '${currentTime.subtract(Duration(hours: 1)).hour.toString()}00';
  //
  //   NetworkHelper networkHelper = NetworkHelper(
  //       '$getUltraSrtFcstURL?serviceKey=$serviceKey&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=$x&ny=$y');
  //   print('Current Base Date: $baseDate');
  //   print('Current Base Time: $baseTime');
  //   var weatherData = await networkHelper.getData();
  //   print('초단기 예보 : $weatherData');
  //   return weatherData;
  //
  //   /*
  //   * {response: {header: {resultCode: 00, resultMsg: NORMAL_SERVICE},
  //   * body: {dataType: JSON, items: {item:
  //   * [{baseDate: 20230611, baseTime: 0030, category: LGT, fcstDate: 20230611, fcstTime: 0100, fcstValue: 1, nx: 60, ny: 121},
  //   * {baseDate: 20230611, baseTime: 0030, category: LGT, fcstDate: 20230611, fcstTime: 0200, fcstValue: 0, nx: 60, ny: 121},
  //   * {baseDate: 20230611, baseTime: 0030, category: LGT, fcstDate: 20230611, fcstTime: 0300, fcstValue: 0, nx: 60, ny: 121},
  //   * {baseDate: 20230611, baseTime: 0030, category: LGT, fcstDate: 20230611, fcstTime: 0400, fcstValue: 0, nx: 60, ny: 121},
  //   * {baseDate: 20230611, baseTime: 0030, category: LGT, fcstDate: 20230611, fcstTime: 0500, fcstValue: 0, nx: 60, ny: 121},
  //   * {baseDate: 20230611, baseTime: 0030, category: LGT, fcstDate: 20230611, fcstTime: 0600, fcstValue: 0, nx: 60, ny: 121},
  //   * {baseDate: 20230611, baseTime: 0030, category: PTY, fcstDate: 20230611, fcstTime: 0100, fcstValue: 1, nx: 60, ny: 121},
  //   * {baseDate: 20230611, baseTime: 0030, category: PTY, fcstDate:
  //   * */
  // }

  //map형태 데이터 map안에 담기
  Future getMapList() async {
    Map map = {};
    //초단기 실황 map형태 데이터
    map['getUltraSrtNcst'] = await getUltraSrtNcstCategoryValue();
    map['getVilageFcst'] = await getVilageFcstURLWeatherData();
    return map;
  }
}
