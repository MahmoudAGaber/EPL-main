import 'package:arseli/Provider/ThemeProvider.dart';
import 'package:arseli/Themes/Colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'lang/LocalizationService.dart';

class setting extends StatefulWidget {
  @override
  _settingState createState() => _settingState();
}

TextStyle _textStyle = TextStyle(fontFamily: 'Vazirmatn',fontSize: 16);
TextStyle _textStyle1 = TextStyle(fontFamily: 'Vazirmatn',color: Colors.grey, fontSize: 14);

class _settingState extends State<setting> {
  String _selectedLang = LocalizationService.langs.last;

  List<String> theme=['فاتح',"داكن"];
  String selectedTheme;

  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  VoidCallback _showpersBottomSheetCallBack;
  DarkThemeProvider darkThemeProvider;
  Future<void> _launched;

  Future<void> getTheme()async{
    var prefs = await SharedPreferences.getInstance();
    selectedTheme = 'فاتح';
    setState(() {
      selectedTheme = prefs.getString('selected');
    });

  }
  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      darkThemeProvider = Provider.of(context,listen: false);
      darkThemeProvider.darkTheme;
      getTheme();

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
              height: 180,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 20, left: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            launch('https://www.instagram.com/eplworld/?fbclid=IwAR1XE1MWPHsHQoVc9gXu4F875DydtvvzopI9lXJpj-NWZ5k3hGVB_DHF8FI');
                          },
                            child: Icon(MdiIcons.instagram,
                                size: 40,
                                color: Theme.of(context).colorScheme.secondary)
                        ),
                        SizedBox(
                          width: 10,
                        ),

                      ],
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){

                              launch('https://twitter.com/eplworld/?fbclid=IwAR1gHoxqvdnt1cia3-x86izw8QjTmWOwnlRw5ellKTn_Pag4baXVNBTA8tQ');
                          },
                          child: Icon(
                            MdiIcons.twitter,
                            size: 40,
                            color: Theme.of(context).colorScheme.secondary),
                        ),
                        SizedBox(
                          width: 10,
                        ),

                      ],
                    ),
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
                style: TextStyle( fontFamily: 'Vazirmatn',color: Colors.white,fontSize: 20),
              ),
            ),
            body: Padding(
              padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              child: ListView(
                children: <Widget>[
                  /*
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

                   */
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
                              items: theme.map((String them) {
                                return DropdownMenuItem(
                                    value: them, child: Text(them));
                              }).toList(),
                              onChanged: (String value) async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setString('selected', value);
                                getTheme();
                                selectedTheme = value;
                                if(value=='داكن'){
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
                           style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            "اللغة العربية".tr,
                            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)
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
                              style: Theme.of(context).textTheme.headline2,
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
                              style: Theme.of(context).textTheme.headline2,
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
                    onTap: (){
                      launch('mailto:eplworld@eplworld.net');
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
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        )
                      ],
                    ),
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
