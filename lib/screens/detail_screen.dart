import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widget/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;


  const DetailScreen({super.key,
   required this.title,
   required this.thumb, 
   required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  /*
    widget.id 이런 식으로 State 내부에서 위 Statefull위젯의 맴버들을
    참조할 수 있는 이유는 State에서 자신이 속한 스테이트풀위젯의 데이터를 받아와서 가능하다.
   */
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {// 해당 상테일대 프로퍼티가 초기화 되기 때문에 이 안에서 api 호출하는 로직이 있는거다.
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2, // 앱바 경계선의 음영?
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
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
                        widget.thumb,
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
                  ),
                ],
              ),
              const SizedBox(height:25),
              FutureBuilder(
                  future: webtoon,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.about,
                            style: const TextStyle(fontSize: 16,),
                          ),
                          const SizedBox(height: 15,),
                          Text(
                            '${snapshot.data!.genre} / ${snapshot.data!.age}',
                            style: const TextStyle(fontSize: 16,),
                          ),
                          
                        ],
                      );
                    }
                    return const Text("...");
                  },
                ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        for(var episode in snapshot.data!)
                        Episode(
                          episode: episode,
                          webtoonId: widget.id,
                        )
                      ],
                    );
                  }
                  return Container();
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}