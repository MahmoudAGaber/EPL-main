import 'package:arseli/matches.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:get/get.dart';

import 'home.dart';

class clanderbar extends StatefulWidget {
  @override
  _clanderbarState createState() => _clanderbarState();
}

class _clanderbarState extends State<clanderbar> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      headerTitleTouchable: true,
      selectedDayButtonColor: Theme.of(context).primaryColor,
      selectedDayBorderColor: Theme.of(context).primaryColor,

      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
        Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
            builder: (context) => home(
                  dateTime: date,
                  index: 0,
                )));
      },

      daysTextStyle: Theme.of(context).textTheme.headline2.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
      headerTextStyle:Theme.of(context).textTheme.headline2.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
      inactiveWeekendTextStyle:Theme.of(context).textTheme.headline2.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
      markedDateCustomTextStyle: Theme.of(context).textTheme.headline2.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
      markedDateMoreCustomTextStyle:Theme.of(context).textTheme.headline2.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
      weekdayTextStyle:Theme.of(context).textTheme.headline2.copyWith(fontSize: 15,fontWeight: FontWeight.bold),
      selectedDayTextStyle: TextStyle(fontFamily: 'Vazirmatn', color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      nextDaysTextStyle: TextStyle(fontFamily: 'Vazirmatn', color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
      prevDaysTextStyle: TextStyle(fontFamily: 'Vazirmatn', color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600),
      todayTextStyle: TextStyle(fontFamily: 'Vazirmatn', color: Colors.white, fontSize: 20),
      iconColor: Theme.of(context).colorScheme.secondary,
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: Theme.of(context).textTheme.headline2.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
      weekFormat: false,
//      firstDayOfWeek: 4,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: ClampingScrollPhysics(),

      minSelectedDate: DateTime(2000),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),

      inactiveDaysTextStyle: TextStyle(
        fontFamily: 'Vazirmatn',
        color: Colors.tealAccent,
        fontSize: 25,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              "اليوم".tr,
              style: TextStyle(fontFamily: 'Vazirmatn', color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //custom icon
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarousel,
                ), // This trailing comma makes auto-formatting nicer for build methods.
                //custom icon without header

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Theme(
                      data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(
                        primary: Theme.of(context).primaryColor, // header background color
                        onPrimary: Theme.of(context).colorScheme.secondary, // header text color
                        onSurface: Theme.of(context).colorScheme.secondary,

                          )),
                      child: _calendarCarouselNoHeader),
                ), //
              ],
            ),
          )),
    );
  }
}
