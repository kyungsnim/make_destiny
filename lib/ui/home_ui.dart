import 'package:flutter/material.dart';
import 'package:make_destiny/controllers/controllers.dart';
import 'package:make_destiny/ui/card_view_ui.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:make_destiny/ui/ui.dart';
import 'package:get/get.dart';

import 'chat_ui.dart';

class HomeUI extends StatefulWidget {
  late int getPageIndex;

  HomeUI(this.getPageIndex);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  // 페이지 컨트롤
  PageController? pageController;
  late int getPageIndex;

  @override
  void initState() {
    super.initState();
    setState(() {
      getPageIndex = widget.getPageIndex;
    });
    pageController = PageController(
      // 다른 페이지에서 넘어올 때도 controller를 통해 어떤 페이지 보여줄 것인지 셋팅
        initialPage: this.getPageIndex);
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex) {
    pageController!.animateToPage(pageIndex,
        duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) =>
      // controller.firestoreUser.value!.uid == null
      //     ? Center(
      //   child: CircularProgressIndicator(),
      // )
      //     :
      Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              CardViewUI(),
              ChatUI(),
              CardViewUI(),
              SettingsUI(),
            ],
            controller:
            pageController, // controller를 지정해주면 각 페이지별 인덱스로 컨트롤 가능
            onPageChanged:
            whenPageChanges, // page가 바뀔때마다 whenPageChanges 함수가 호출되고 현재 pageIndex 업데이트해줌
          ),
          bottomNavigationBar: StyleProvider( // bottomBar 텍스트 설정 변경용
            style: Style(), // bottomBar 텍스트 설정 변경용
            child: ConvexAppBar(
              initialActiveIndex: this.getPageIndex,
              onTap: onTapChangePage,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04,
              backgroundColor: Colors.transparent,
              activeColor: Colors.transparent,
              style: TabStyle.titled,
              items: [
                TabItem(
                    icon: Icon(Icons.recommend,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(Icons.recommend,
                      color: Colors.indigo,
                    ),
                    title: '추천'),
                TabItem(
                    icon: Icon(Icons.chat,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(Icons.chat,
                      color: Colors.indigo,
                    ),
                    title: '대화'),
                TabItem(
                    icon: Icon(Icons.notifications_active,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(Icons.notifications_active,
                      color: Colors.indigo,
                    ),
                    title: '알림'),
                TabItem(
                    icon: Icon(Icons.more_horiz,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(Icons.more_horiz,
                      color: Colors.indigo,
                    ),
                    title: '설정'),
              ],
            ),
          )
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 20;

  @override
  double get activeIconMargin => 2;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(fontSize: 18, color: Colors.grey, fontFamily: 'SLEIGothic');
  }
}
