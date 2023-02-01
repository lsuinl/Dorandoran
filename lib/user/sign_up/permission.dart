import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void permissionquest() async{
  Map<Permission, PermissionStatus> statuses = await [
    Permission.locationWhenInUse,
    Permission.photos,
  ].request();
  if (statuses.values.every((element) => element.isDenied)) {
    print("실패 ㅠㅠ");
  } else {
    print("성공Vv");
  }

    // 권한이 제한되었습니다.
}