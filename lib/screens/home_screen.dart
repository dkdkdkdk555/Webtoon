import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
            // snapshoㅅ을 이용하면 Future의 상태를 알 수 있다.
            if(snapshot.hasData){
              return const Text("There is data!");
            } 
            return const Text("Loading..");
        },
      ),
    );
  }
}