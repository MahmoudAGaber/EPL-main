

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Oops extends StatefulWidget {
  @override
  _OopsState createState() => _OopsState();
}

class _OopsState extends State<Oops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
                height: 200,
                child: Image.asset('assets/EPL-Logo.png')),
            SizedBox(height: 15,),
            Center(
              child: Text(
                "لا توجد بيانات متوفرة", style: TextStyle(fontSize: 22,),),
            )
          ],
        ),
      ),
    );
  }
}
