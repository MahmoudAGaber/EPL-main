import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../playrers/screens/players.dart';
import '../../team/screens/teamHome.dart';


class TransferCenter extends StatefulWidget {
  String? url;
  TransferCenter({this.url});
  @override
  _TransferCenterState createState() => _TransferCenterState();
}

const TextStyle _textStyle =
    TextStyle(fontFamily: 'Vazirmatn', color: Colors.black54, fontSize: 13);

class _TransferCenterState extends State<TransferCenter> {
  Widget? con;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer(
        builder: (context, provider, child) {
          return  Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => Players())
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 70,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(50)),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                        child: Image.network(
                                                            "https://www.eplworld.com")),
                                                  )
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10,),

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(4),
                                                        color: Theme.of(context).primaryColor
                                                    ),
                                                    /*
                                                  child:Padding(
                                                    padding: const EdgeInsets.all(1.0),
                                                    child: Text('CM',style: TextStyle(color: Colors.white,fontSize: 12),),
                                                  )

                                                   */
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(
                                                      'name',
                                                      style: Theme.of(context).textTheme.bodyMedium
                                                  ),
                                                ],
                                              ),
                                              /*
                                          SizedBox(height: 2,),
                                          Row(
                                            children: [
                                              Text('الجنسيه',style: TextStyle(color: Colors.black54),),
                                              SizedBox(width: 5,),
                                              //CircleAvatar(radius: 10,)
                                            ],
                                          ),


                                          SizedBox(height: 2,),
                                          Text('القيمة السوقيه 80 مليون دولار'),
                                          SizedBox(height: 2,),

                                           */
                                            ],
                                          ),
                                        ],
                                      ),

                                      Expanded(
                                          child: Text('data',
                                            style:Theme.of(context).textTheme.bodyMedium,
                                            textAlign: TextAlign.left,))

                                    ],
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          child: Text("tName",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style:Theme.of(context).textTheme.bodyMedium,
                                          )
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                            width: MediaQuery.of(context).size.width * 0.39,
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 1),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      HomeTeam(
                                                                        teamName:"",
                                                                        teamId: "",)));
                                                        },
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          child:
                                                          Image.network(
                                                              "https://www.eplworld.com"),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 15,right: 15),
                                                        child: Container(
                                                            width: 40,
                                                            height: 16,
                                                            decoration: BoxDecoration(
                                                                color: Color(0xFF42c713),
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        100))),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(3.0),
                                                              child: Container(
                                                                height: 10,width: 25,
                                                                  child: RotatedBox(
                                                                    quarterTurns: 2,
                                                                      child: Image.asset('assets/arrow.png',fit: BoxFit.contain,))),
                                                            )
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      HomeTeam(
                                                                        teamName: "",
                                                                        teamId: "",)
                                                              ));
                                                        },
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          child:
                                                          Image.network(
                                                              "https://www.eplworld.com"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                 // Text('65 مليون دولار',style: TextStyle(color: Colors.green),)
                                                ],
                                              ),
                                            )),
                                        SizedBox(width: 5,),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.21,
                                          child: Text('fromName',
                                            textDirection: TextDirection.rtl,
                                            style:Theme.of(context).textTheme.bodyMedium,
                                        ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('data',
                                        style:Theme.of(context).textTheme.bodyMedium,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
