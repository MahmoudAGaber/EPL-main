import 'package:flutter/material.dart';


class FavouriteNotification extends StatefulWidget {
  @override
  _FavouriteNotificationState createState() => _FavouriteNotificationState();
}

class _FavouriteNotificationState extends State<FavouriteNotification> {

  bool light = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("اختر كل الفرق",style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),),
                            Switch(
                              value: light,
                              activeColor:  Color(0xFF77109B),
                              onChanged: (bool value) {
                                setState(() {
                                  light = value;
                                });
                              },
                            )
                          ],
                        ),
                        Divider(height: 0,),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context,index){
                            return  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 30,width: 30,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network("https://www.eplworld.com"),
                                            )
                                        ),
                                        SizedBox(width: 8,),
                                        Text("d",style: Theme.of(context).textTheme.bodyMedium)
                                      ],
                                    ),
                                    Switch(
                                      value: light,
                                      activeColor:  Color(0xFF77109B),
                                      onChanged: (bool value) {
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Divider(height: 0,),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("اختر كل البطولات",style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),),
                            Switch(
                              value: light,
                              activeColor:  Color(0xFF77109B),
                              onChanged: (bool value) {
                                setState(() {
                                  light = value;
                                });
                              },
                            )
                          ],
                        ),
                        Divider(height: 0,),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context,index){
                            return  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 30,width: 30,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network("https://www.eplworld.com"),
                                            )
                                        ),
                                        SizedBox(width: 8,),
                                        Text("f",style: Theme.of(context).textTheme.bodyMedium)
                                      ],
                                    ),
                                    Switch(
                                      value: light,
                                      activeColor:  Color(0xFF77109B),
                                      onChanged: (bool value) {
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Divider(height: 0,),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("اختر كل اللاعيبين",style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),),
                            Switch(
                              value: light,
                              activeColor:  Color(0xFF77109B),
                              onChanged: (bool value) {
                                setState(() {
                                  light = value;
                                });
                              },
                            )
                          ],
                        ),

                        Divider(height: 0,),

                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context,index){
                            return  Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 30,width: 30,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(50),
                                              child: Image.network("https://www.eplworld.com")
                                            )
                                        ),
                                        SizedBox(width: 8,),
                                        Text("text",style: Theme.of(context).textTheme.bodyMedium)
                                      ],
                                    ),
                                    Switch(
                                      value: light,
                                      activeColor:  Color(0xFF77109B),
                                      onChanged: (bool value) {
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Divider(height: 0,)
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            )

      ),
    );
  }
}
