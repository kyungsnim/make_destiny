import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:make_destiny/controllers/auth_controller.dart';
import 'package:make_destiny/models/favorite_listen_model.dart';
import 'package:make_destiny/ui/components/components.dart';

class IntroduceMyselfSelectUI extends StatefulWidget {
  List<dynamic> introduceMyselfList;

  IntroduceMyselfSelectUI(this.introduceMyselfList);

  @override
  _IntroduceMyselfSelectUIState createState() => _IntroduceMyselfSelectUIState();
}

class _IntroduceMyselfSelectUIState extends State<IntroduceMyselfSelectUI> {
  List<MultiSelectModel> introduces = [
    MultiSelectModel('웃음이 많아요', false),
    MultiSelectModel('울음이 많아요', false),
    MultiSelectModel('이야기를 잘 들어줘요', false),
    MultiSelectModel('상대방을 배려해요', false),
    MultiSelectModel('대부분 계획적이에요', false),
    MultiSelectModel('대부분 즉흥적이에요', false),
    MultiSelectModel('주도적으로 행동해요', false),
    MultiSelectModel('설득하는걸 좋아해요', false),
    MultiSelectModel('매너가 좋은', false),
    MultiSelectModel('유머감각이 좋은', false),
    MultiSelectModel('웃음소리가 깨방정', false),
    MultiSelectModel('분위기 메이커', false),
    MultiSelectModel('자기전 통화 좋아해요', false),
    MultiSelectModel('요리를 자주해요', false),
    MultiSelectModel('요리는 라면뿐', false),
    MultiSelectModel('고기 잘 구워요', false),
    MultiSelectModel('육식보단 채식', false),
    MultiSelectModel('베스트 드라이버', false),
    MultiSelectModel('장롱면허', false),
    MultiSelectModel('외국어 잘해요', false),
    MultiSelectModel('사투리 못고쳐요', false),
    MultiSelectModel('뛰어난 운동신경', false),
    MultiSelectModel('4차원 엉뚱매력', false),
    MultiSelectModel('장난기가 많아요', false),
    MultiSelectModel('상식에 강해요', false),
    MultiSelectModel('소소하게 주식해요', false),
    MultiSelectModel('저축보단 금융투자', false),
    MultiSelectModel('안전주의 따박적금', false),
    MultiSelectModel('연상이 좋아요', false),
    MultiSelectModel('연하가 좋아요', false),
    MultiSelectModel('연애의 끝은 결혼', false),
    MultiSelectModel('비혼을 선호해요', false),
  ];

  List<dynamic> introduceLists = [];

  @override
  void initState() {
    /// DB 데이터 가져오기
    widget.introduceMyselfList.forEach((item) {
      introduceLists.add(item);
    });

    /// DB 데이터 항목들 체크상태로 변경
    introduceLists.forEach((item) {
      introduces.forEach((target) {
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
                title: Text('저는 이런 사람이에요'),
              ),
              body: Container(
                  child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: introduces.length,
                      itemBuilder: (context, index) {
                        return MultiTileItem(introduces[index].text,
                            introduces[index].isSelected, index);
                      },
                    ),
                  ),
                  PrimaryButton(
                      labelText: '저장',
                      onPressed: () {
                        Map<String, dynamic> introduceMyselfMap = {
                          'introduceMyself': introduceLists
                        };

                        // firestore 저장
                        AuthController().updateIntroduceMyselfFirestore(introduceMyselfMap, controller.firebaseUser.value!.uid);
                        Get.back(result: introduceLists);
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
            introduces[index].isSelected = !introduces[index].isSelected;
            if (introduces[index].isSelected == true) {
              introduceLists.add(text);
            } else {
              introduceLists.forEach((item) {
                print(item);
              });
              introduceLists
                  .removeWhere((element) => element == introduces[index].text);
              introduceLists.forEach((item) {
                print(item);
              });
            }
          });
        });
  }
}
