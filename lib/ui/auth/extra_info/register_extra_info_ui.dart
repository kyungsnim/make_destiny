import 'package:flutter/material.dart';

class RegisterExtraInfoUI extends StatefulWidget {
  const RegisterExtraInfoUI({Key? key}) : super(key: key);

  @override
  _RegisterExtraInfoUIState createState() => _RegisterExtraInfoUIState();
}

class _RegisterExtraInfoUIState extends State<RegisterExtraInfoUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Column(
          children: [
            Text('프로필 작성하기'),
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.indigo
              ),
              child: Text('작성 시작', style: TextStyle(
                color: Colors.white
              ))
            )
          ],
        ))
      )
    );
  }
}
