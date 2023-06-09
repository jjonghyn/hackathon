import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0; //위도
  double longitude = 0; //경도


  //현재위치를 기반으로 날씨정보 가져오기 geolocator라이브러리 사용
  Future<void> getCurrentLocation() async {
    //현재위치 위경도가 안 나올 경우를 위해 예외 처리
    try {
      // LocationPermission permission = await Geolocator.requestPermission(); //오류 해결 코드
      Position position = await Geolocator.
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;

      print(position);
    } catch (e) {
      print(e);
    }
    print('위도 : $latitude');
    print('경도 : $longitude');
  }
}


