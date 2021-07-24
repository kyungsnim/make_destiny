import 'package:flutter/material.dart';

class CardViewUI extends StatefulWidget {
  const CardViewUI({Key? key}) : super(key: key);

  @override
  _CardViewUIState createState() => _CardViewUIState();
}

class _CardViewUIState extends State<CardViewUI> {
  // 연결 가능한 회원 수
  var connectMember;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('커피한잔', style: TextStyle(
          color: Colors.indigo,
          fontSize: MediaQuery.of(context).size.width * 0.06,
          fontWeight: FontWeight.bold,
        )),
        actions: [
          Icon(Icons.favorite, color: Colors.indigo),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(' 30', textAlign: TextAlign.start, style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold
                )),
              ],
            ),
          ),
        ],
      ),
      body: Container(
          child: Column(
        children: [
          previewCard(),
          cardList(),
        ],
      )),
    );
  }

  cardList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.people,
                          size: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '지방직 공무원',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '공무원',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                        ],
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('하루하루 잘 만들어가려해요 인성이 좋은 사람',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06)),
                    )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    Icon(Icons.timer),
                    Expanded(
                      child: Text(' 17시간 후 사라집니다.',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03)),
                    ),
                    Spacer(),
                    Text('더보기 > ', style: TextStyle(color: Colors.grey))
                  ],
                ),
              ),
            ],
          )),
    );
  }

  previewCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.find_in_page,
                size: MediaQuery.of(context).size.width * 0.1,
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '정오에 명함이 도착해요',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
                SizedBox(height: 5),
                Text(
                  '나와 연결 가능한 회원 미리보기',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ),
          ])),
    );
  }
}
