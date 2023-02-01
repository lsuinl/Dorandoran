String? firebasetoken;
String? kakaotoken;
String? useremail;
//서버 url
final signupurl = Uri.parse('http://116.44.231.162:8080/api/signup'); //회원가입 정보 보내기
final namecheckurl=Uri.parse('http://116.44.231.162:8080/api/check-nickname'); //닉네임 중복체크 보내기
final getposturl=Uri.parse('http://124.60.219.83:8080/api/post?userEmail=fsadjklfas&postCnt=0&location=dfa'); //글 가져오기
String kakaonativekey = 'd54cd76337470f87b093bfdadfa53292'; //카카오토큰

final imgurl= 'https://cdn.playforum.net/news/photo/202210/202392_18836_2310.jpg'; //기본 배경화면 가져오기
    //원래 이미지 주소:'http://116.44.231.162:8080/api/background/';
//    image:  DecorationImage(image: img.image, fit: BoxFit.none),
