
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PlayerInjured extends StatefulWidget {
  @override
  _PlayerInjuredState createState() => _PlayerInjuredState();
}

class _PlayerInjuredState extends State<PlayerInjured> {

  @override
  void initState() {

    super.initState();
  }

//todo
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'اللاعبون المصابون والمطردون',
                        style: Theme.of(context).textTheme.headline2
                      ),
                      Divider(),
                      Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 15),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 68,
                                  width: 110,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration:
                                        BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(50),
                                            ),
                                            child: Image.asset("assets/Marcelo.jpg"),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child:Icon(Icons.add,color: Colors.red,size: 25,)),
                                      Positioned(
                                          left: 2,bottom: 0,
                                          child:  Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("مارسيلو",style: Theme.of(context).textTheme.bodyText1,),
                                              Text('مهاجم',style: Theme.of(context).textTheme.bodyText2,)
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Text('اصابة بالعضلة الخلفيه',
                                style: Theme.of(context).textTheme.bodyText2,)
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
