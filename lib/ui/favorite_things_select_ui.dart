import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:make_destiny/controllers/auth_controller.dart';
import 'package:make_destiny/models/favorite_listen_model.dart';
import 'package:make_destiny/ui/components/components.dart';

class FavoriteThingsSelectUI extends StatefulWidget {
  List<dynamic> favoriteThingsList;

  FavoriteThingsSelectUI(this.favoriteThingsList);

  @override
  _FavoriteThingsSelectUIState createState() => _FavoriteThingsSelectUIState();
}

class _FavoriteThingsSelectUIState extends State<FavoriteThingsSelectUI> {
  List<MultiSelectModel> things = [
    MultiSelectModel('영화 보기', false),
    MultiSelectModel('산책 하기', false),
    MultiSelectModel('책 보기', false),
    MultiSelectModel('글 쓰기', false),
    MultiSelectModel('음악 듣기', false),
    MultiSelectModel('요리 하기', false),
    MultiSelectModel('잠 자기', false),
    MultiSelectModel('멍 때리기', false),
    MultiSelectModel('여행 가기', false),
    MultiSelectModel('사진 찍기', false),
    MultiSelectModel('헬스 하기', false),
    MultiSelectModel('자전거 타기', false),
    MultiSelectModel('필라테스 하기', false),
    MultiSelectModel('크로스핏 하기', false),
    MultiSelectModel('반려동물 키우기', false),
    MultiSelectModel('야구시청 하기', false),
    MultiSelectModel('축구시청 하기', false),
    MultiSelectModel('야구직관 하기', false),
    MultiSelectModel('축구직관 하기', false),
    MultiSelectModel('기타운동 시청 하기', false),
    MultiSelectModel('운동 하기', false),
    MultiSelectModel('레고 모으기', false),
    MultiSelectModel('IT 얼리어답터', false),
    MultiSelectModel('애플 제품 3개 이상', false),
    MultiSelectModel('갤럭시 제품 3개 이상', false),
    MultiSelectModel('패션 공부하기', false),
    MultiSelectModel('해외직구 하기', false),
    MultiSelectModel('넷플릭스 시청하기', false),
    MultiSelectModel('그림 그리기', false),
    MultiSelectModel('악기 다루기', false),
    MultiSelectModel('방송댄스 추기', false),
    MultiSelectModel('노래 부르기', false),
    MultiSelectModel('웹툰 보기', false),
    MultiSelectModel('PC/모바일게임 하기', false),
    MultiSelectModel('보드게임 하기', false),
    MultiSelectModel('와인 마시기', false),
    MultiSelectModel('위스키 마시기', false),
  ];

  List<dynamic> thingsLists = [];

  @override
  void initState() {
    /// DB 데이터 가져오기
    widget.favoriteThingsList.forEach((item) {
      thingsLists.add(item);
    });

    /// DB 데이터 항목들 체크상태로 변경
    thingsLists.forEach((item) {
      things.forEach((target) {
        if (item == target.text) {
          target.isSelected = true;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser.value!.uid == null
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(
                title: Text('저의 관심사는요'),
              ),
              body: Container(
                  child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: things.length,
                      itemBuilder: (context, index) {
                        return MultiTileItem(things[index].text,
                            things[index].isSelected, index);
                      },
                    ),
                  ),
                  PrimaryButton(
                      labelText: '저장',
                      onPressed: () {
                        Map<String, dynamic> favoriteThingsMap = {
                          'favoriteThings': thingsLists
                        };

                        // firestore 저장
                        AuthController().updateFavoriteThingsFirestore(
                            favoriteThingsMap,
                            controller.firebaseUser.value!.uid);
                        Get.back(result: thingsLists);
                      }),
                  SizedBox(height: 50),
                ],
              ))),
    );
  }

  Widget MultiTileItem(String text, bool isSelected, int index) {
    return ListTile(
        title: Text(text),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: Colors.indigo)
            : Icon(
                Icons.check_circle_outline,
                color: Colors.grey,
              ),
        onTap: () {
          setState(() {
            things[index].isSelected = !things[index].isSelected;
            if (things[index].isSelected == true) {
              thingsLists.add(text);
            } else {
              thingsLists.forEach((item) {
                print(item);
              });
              thingsLists
                  .removeWhere((element) => element == things[index].text);
              thingsLists.forEach((item) {
                print(item);
              });
            }
          });
        });
  }
}
