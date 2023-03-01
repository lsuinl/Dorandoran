import 'package:dorandoran/common/storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

//00 시간 출력설정
String getTimeFormat(int number) {
  return number.toString().padLeft(2, '0');
}

//년/월/초 출력
String timecount(String time) {
  DateTime today = DateTime.now();
  String timer = time.replaceAll(RegExp('\\D'), "");
  int year = int.parse(timer.substring(0, 4));
  int month = int.parse(timer.substring(4, 6));
  int day = int.parse(timer.substring(6, 8));
  int hour = int.parse(timer.substring(8, 10));
  int min = int.parse(timer.substring(10, 12));
  int second = int.parse(timer.substring(12, 14));

  int daycheck;
  daycheck =
      today.difference(DateTime(year, month, day, hour, min, second)).inDays;
  if (daycheck > 365) {
    return "${(daycheck / 365).toInt()}년 전";
  } else if (daycheck > 31) {
    return "${(daycheck / 30).toInt()}달 전";
  } else if (daycheck > 0) {
    return "${daycheck.toInt()}일 전";
  } else {
    daycheck = today
        .difference(DateTime(year, month, day, hour, min, second))
        .inSeconds;
    if (daycheck > (60 * 60)) {
      return "${(daycheck / (60 * 60)).toInt()}시간 전";
    } else if (daycheck > 60) {
      return "${(daycheck / 60).toInt()}분 전";
    } else {
      return "${daycheck.toInt()}초 전";
    }
  }
}

//권한요청
void permissionquest() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.locationWhenInUse,
    Permission.photos,
  ].request();
  if (statuses.values.every((element) => element.isDenied)) {
    print("실패 ㅠㅠ");
  } else {
    print("성공Vv");
  }
}

//이름체크
String checkname(String name) {
  if (name == '') {
    //null상태
    return "닉네임을 입력해주세요.";
  } else if (name.length <= 1) {
    return "닉네임의 길이는 최소 2글자 이상이어야 합니다.";
  } else if (!RegExp(r"^[가-힣0-9a-zA-Z]*$").hasMatch(name)) {
    //제대로된 문자인지 확인.(특수문자.이모티콘 체크)
    return "올바르지 않은 닉네임입니다.";
  } else {
    //형식은 통과
    return '';
  }
}

void getlocation() async {
  //현재위치 가져오기
  Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude.toString();
    longtitude = position.longitude.toString();
}

