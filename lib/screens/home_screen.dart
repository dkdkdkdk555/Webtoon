import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widget/webtton_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2, // 앱바 경계선의 음영?
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text("오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            ),
        ),
      ),
      body: FutureBuilder(/*
        StatefullWidget을 고집할 필요 없다.
        FutureBuilder 를 통하면 State 없이도 api 의 리턴 결과를 동적으로 반영할 수 있다.
      */
        future: webtoons, // FutureBuilder 가 await 해준다.
        builder: (context, snapshot){
            // snapshot을 이용하면 Future의 상태를 알 수 있다.
            if(snapshot.hasData){
              return Column(
                children: [
                  const SizedBox(height: 50,),
                  Expanded( // 리스트 뷰는 높이가 정해져 있지 않아서 무한히 큰 것으로 생각됨(?)
                  // 그래서 Expanded 위젯으로 감싸주면 상위 칼럼에 sizedbox 공간 외에 나머지 공간을
                  // 차지하게 함
                    child: makeList(snapshot)
                  )
                ],
              );
            } 
            return const Center(
              child: CircularProgressIndicator(), // 로딩
            );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated( 
              // ListView.builder 는 필요할때 아이템을 로드해 메모리를 절약한다.
              // ListView.separated 는 'separatorBuilder' 라는 필수 인자를 하나 더 받아 리스트를 구분 시켜줄 위젯을 하나 더 받는다.
              scrollDirection: Axis.horizontal,
              itemCount:snapshot.data!.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              itemBuilder: (context, index) {
                var webtoon = snapshot.data![index];
                return Webtoon(title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id,);
              },
              separatorBuilder:(context, index) => const SizedBox(
                width: 40,
              ),
            );
  }
}