import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;

  const DetailScreen({super.key,
   required this.title,
   required this.thumb, 
   required this.id});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2, // 앱바 경계선의 음영?
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                clipBehavior: Clip.hardEdge, // clipBehavior는 자식이 부모 영역을 침범하는 속성
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(10), // clipbehavior를 적용해야만 적용됨
                  boxShadow: [ // 그림자 효과
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(10, 0),
                      color: Colors.black.withOpacity(0.5),
                    )
                  ]
                ),
                child: Image.network(
                  thumb,
                  headers: const { 
                    // 밑에는 안드로이드 나 IOS 를 에뮬레이터를 사용할 경우 CORS 문제를 해결하기 위해 넣어야 하는 헤더 내용이다.
                    // 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                    // 'Referer': 'https://comic.naver.com',
              
                    // chrome 에서 할때는 
                    // flutter run -d chrome --web-renderer html
                    // 명령어로 실행하여 해결함. HTML 랜더링 엔진을 사용하도록 설정하는 것
                  },
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}