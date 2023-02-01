
//00 시간 설절
String getTimeFormat(int number) {
  return number.toString().padLeft(2, '0');
}

//2023-02-01T19:20:48.47707
//0-3:년,4-5:월,6-7:일,8-9:시,10-11:분,11-12:초
String timecount(String time){
  print(time);
  DateTime today=DateTime.now();
  String timer=time.replaceAll(RegExp('\\D'), "");
  int year=int.parse(timer.substring(0,4));
  int month=int.parse(timer.substring(4,6));
  int day=int.parse(timer.substring(6,8));
  int hour=int.parse(timer.substring(8,10));
  int min=int.parse(timer.substring(10,12));
  int second=int.parse(timer.substring(12,14));

  int daycheck;
  daycheck=today.difference(DateTime(year,month,day,hour,min,second)).inDays;
  if(daycheck>365){
    return "${(daycheck/365).toInt()}년 전";
  }
  else if(daycheck>31){
    return "${(daycheck/30).toInt()}달 전";
  }
  else if(daycheck>0){
    return "${daycheck.toInt()}일 전";
  }
  else{
    daycheck=today.difference(DateTime(year,month,day,hour,min,second)).inSeconds;
    if(daycheck>(60*60)){
      return "${(daycheck/(60*60)).toInt()}시간 전";
    }
    else if(daycheck>60){
      return "${(daycheck/60).toInt()}분 전";
    }
    else{
      return "${daycheck.toInt()}초 전";
    }
  }

}
