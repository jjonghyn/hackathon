import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
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

  //map형태 데이터 map안에 담기
  Future getMapList () async{
    Map map = {};
    //초단기 실황 map형태 데이터
    map['getUltraSrtNcst'] = await getUltraSrtNcstCategoryValue();
    // map['ccc'] = await getUltraSrtNcstCategoryValue();
    return map;
  }

  //초단기 실황 조회
  Future<Map<String, dynamic>> getUltraSrtNcstWeatherData() async {

    Location location = Location();

    await location.getCurrentLocation();

    double lat = location.latitude;
    double lng = location.longitude;

    var gpsToGridData = ConvGridGps.gpsToGRID(lat, lng); //geolocator 라이브러리로 불러온 현재 나의 위경도 데이터를 격자데이터로 변환

    var x = gpsToGridData['x'];
    var y = gpsToGridData['y'];

    DateTime currentTime = DateTime.now();

    //현재 년도월일
    String baseDate =
        '${currentTime.year}${currentTime.month.toString().padLeft(
        2, '0')}${currentTime.day.toString().padLeft(2, '0')}';

    //현재 시간 -1시간
    String baseTime = '${currentTime.subtract(Duration(hours: 1)).hour.toString()}00';

    NetworkHelper networkHelper = NetworkHelper(
        '$getUltraSrtNcstURL?serviceKey=$serviceKey&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=$x&ny=$y');
    print('Current Base Date: $baseDate');
    print('Current Base Time: $baseTime');
    var weatherData = await networkHelper.getData();
    return weatherData;
    /*
    *********** weatherData의 값 ***********
    *{response:
    * {header:
    * {resultCode: 00, resultMsg: NORMAL_SERVICE},
    * body: {dataType: JSON,
    * items: {item: [
    * {baseDate: 20230609, baseTime: 1400, category: PTY, nx: 60, ny: 121, obsrValue: 0},
    * {baseDate: 20230609, baseTime: 1400, category: REH, nx: 60, ny: 121, obsrValue: 40},
    * {baseDate: 20230609, baseTime: 1400, category: RN1, nx: 60, ny: 121, obsrValue: 0},
    * {baseDate: 20230609, baseTime: 1400, category: T1H, nx: 60, ny: 121, obsrValue: 27},
    * {baseDate: 20230609, baseTime: 1400, category: UUU, nx: 60, ny: 121, obsrValue: -0.4},
    * {baseDate: 20230609, baseTime: 1400, category: VEC, nx: 60, ny: 121, obsrValue: 169},
    * {baseDate: 20230609, baseTime: 1400, category: VVV, nx: 60, ny: 121, obsrValue: 2.4},
    * {baseDate: 20230609, baseTime: 1400, category: WSD, nx: 60, ny: 121, obsrValue: 2.4}]},
    * pageNo: 1,
    * numOfRows: 10,
    * totalCount: 8}}}
    * */
  }

  //초단기 실황 데이터 가공
  Future<Map<String, dynamic>> getUltraSrtNcstCategoryValue() async{
    Map<String, dynamic> categoryValue = {}; //가공할 데이터담을 map 변수 선언

    var weatherData = await getUltraSrtNcstWeatherData(); //전체 데이터 불러오기
    var itemList = weatherData['response']['body']['items']['item']; //item의 List 전체 데이터 추출

    for (var item in itemList) {
      String category = item['category']; //itemList의 category List 추출
      var obsrValue = item['obsrValue']; //itemList의 obsrValue List 추출
      categoryValue[category] = obsrValue; //categoryValue변수에 key:category, value:obsrValue 담기
    }

    print(categoryValue['UUU'].runtimeType);


    if(double.parse(categoryValue['UUU']) < 0.0) categoryValue['UUU'] = '서';
    else if(double.parse(categoryValue['UUU']) > 0.0) categoryValue['UUU'] = '동';
    else if(double.parse(categoryValue['UUU']) == 0.0) categoryValue['UUU'] = '';

    print(categoryValue['UUU'].runtimeType);

    if(double.parse(categoryValue['VVV']) < 0.0) categoryValue['VVV'] = '남';
    else if(double.parse(categoryValue['VVV']) > 0.0) categoryValue['VVV'] = '북';
    else if(double.parse(categoryValue['VVV']) == 0.0) categoryValue['VVV'] = '';

    return categoryValue;
  }

//  초단기 예보 조회
  Future<Map<String, dynamic>> getUltraSrtFcstWeatherData() async {
    Location location = Location();

    await location.getCurrentLocation();

    double lat = location.latitude;
    double lng = location.longitude;

    var gpsToGridData = ConvGridGps.gpsToGRID(lat, lng); //geolocator 라이브러리로 불러온 현재 나의 위경도 데이터를 격자데이터로 변환

    var x = gpsToGridData['x'];
    var y = gpsToGridData['y'];

    final currentTime = DateTime.now();
    final baseDate =
        '${currentTime.year}${currentTime.month.toString().padLeft(
        2, '0')}${currentTime.day.toString().padLeft(2, '0')}';
    const baseTime = '0630';

    NetworkHelper networkHelper = NetworkHelper(
        '$getUltraSrtFcstURL?serviceKey=$serviceKey&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=$x&ny=$y');
    print('Current Base Date: $baseDate');
    print('Current Base Time: $baseTime');
    var weatherData = await networkHelper.getData();
    print('초단기 예보 : $weatherData');
    return weatherData;
  }


}
