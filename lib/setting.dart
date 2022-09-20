import 'package:arseli/Provider/ThemeProvider.dart';
import 'package:arseli/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';

import 'lang/LocalizationService.dart';

class setting extends StatefulWidget {
  @override
  _settingState createState() => _settingState();
}

TextStyle _textStyle = TextStyle(fontFamily: 'Vazirmatn',fontSize: 16);
TextStyle _textStyle1 = TextStyle(fontFamily: 'Vazirmatn',color: Colors.grey, fontSize: 14);

class _settingState extends State<setting> {
  String _selectedLang = LocalizationService.langs.last;
  List<String> theme=['فاتح',"غامق"];
  String selectedTheme = 'فاتح';

  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  VoidCallback _showpersBottomSheetCallBack;
  DarkThemeProvider darkThemeProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      darkThemeProvider = Provider.of(context,listen: false);
      darkThemeProvider.darkTheme;
    });
    super.initState();
    _showpersBottomSheetCallBack = _bottomSheet;
  }

  void _bottomSheet() {
    setState(() {
      _showpersBottomSheetCallBack = null;
    });

    _scaffoldkey.currentState
        .showBottomSheet((BuildContext context) {
          return new Container(
              height: 280,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 20, left: 20, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "تابعنا".tr,
                          style: _textStyle,
                        )
                      ],
                    ),
                    Divider(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          MdiIcons.facebook,
                          size: 30,
                          color: Colors.blue[800],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Facebook".tr,
                          style: _textStyle,
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(MdiIcons.instagram, size: 30, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Instagram".tr,
                          style: _textStyle,
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          MdiIcons.twitter,
                          size: 30,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Twitter".tr,
                          style: _textStyle,
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: InkWell(
                            child: Text(
                              "الغاء".tr,
                              style: TextStyle(                      fontFamily: 'Vazirmatn',
                                  color: Theme.of(context).primaryColor),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showpersBottomSheetCallBack = _bottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<DarkThemeProvider>(
        builder: (context,provider,child){
          return Scaffold(
            key: _scaffoldkey,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                "الاعدادات".tr,
                style: TextStyle( fontFamily: 'Vazirmatn',color: Colors.white),
              ),
            ),
            body: Padding(
              padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/tv');
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Icon(
                            Icons.tv,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "القنوات الناقلة".tr,
                              style: _textStyle,
                            ),
                            Text(
                              "الشرق الاوسط".tr,
                              style: _textStyle1,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          Icons.brightness_4_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DropdownButton(
                              underline: SizedBox(),
                              icon: Icon(Icons.arrow_drop_down),
                              value: selectedTheme,
                              items: theme.map((String lang) {
                                return DropdownMenuItem(
                                    value: lang, child: Text(lang));
                              }).toList(),
                              onChanged: (String value) {
                                selectedTheme = value;
                                if(value=='غامق'){
                                  provider.darkTheme=true;
                                }else{
                                  provider.darkTheme=false;
                                }


                              }
                          )
                        ],

                      )
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.purple[600],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          Icons.language,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "لغة الواجهة".tr,
                            style: _textStyle,
                          ),
                          Text(
                            "اللغة العربية".tr,
                            style: _textStyle1,
                          ),
                          /*
                        DropdownButton(
                          icon: Icon(Icons.arrow_drop_down),
                          value: _selectedLang,
                          items: LocalizationService.langs.map((String lang) {
                            return DropdownMenuItem(
                                value: lang, child: Text(lang));
                          }).toList(),
                          onChanged: (String value) {
                            // updates dropdown selected value
                            setState(() => _selectedLang = value);
                            // gets language and changes the locale
                            LocalizationService().changeLocale(value);
                          },
                        ),

                         */
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: () {
                      final RenderBox box = context.findRenderObject();
                      Share.share('https://www.youtube.com/',
                          sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "مشاركة هذا التطبيق".tr,
                              style: _textStyle,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  GestureDetector(
                    onTap: _showpersBottomSheetCallBack,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Icon(
                            Icons.local_florist,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "تابعنا".tr,
                              style: _textStyle,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Icon(
                          Icons.not_listed_location,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "الدعم".tr,
                            style: _textStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
