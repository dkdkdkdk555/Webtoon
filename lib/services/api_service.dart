import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons()async{ /* await을 사용하려면 해당 함수는 async 함수여야 한다. 
    : 기본적으로 코드를 위부터 읽으면서 동기적으로 작동하는데, 그럼 await 가 선언된 부분에서 결과를 기다려 웹페이지 전체의 로드가 느려진다.
    이를 방지하기 위해 await는 async 로 비동기 함수로 선언한 함수에서만 동작할 수 있게 만들어 놔
    해당 부분에서 중지되더라도 다른 함수 나 코드의 로드는 진행할 수 있도록 설계되었다. 즉 async 를 선언 해둔 함수는 그 다음 코드와 
    동시에 진행이 된다.
  */
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); // 결과를 반환 받을 때 까지 기다린다.
    /*
      Future<Response> : Future 타입은 미래에 받을 값의 타입을 알려준다. 미래에 받을 타입은 Response 타입,
    */
    if(response.statusCode == 200){
      final List<dynamic> webtoons = jsonDecode(response.body);
      for(var webtoon in webtoons){
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}