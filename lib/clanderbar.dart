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
                )));
      },

      daysTextStyle: TextStyle(
          fontFamily: 'Vazirmatn',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      headerTextStyle: TextStyle(
          fontFamily: 'Vazirmatn',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      inactiveWeekendTextStyle: TextStyle(
          fontFamily: 'Vazirmatn',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      markedDateCustomTextStyle: TextStyle(
          fontFamily: 'Vazirmatn',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      markedDateMoreCustomTextStyle: TextStyle(
          fontFamily: 'Vazirmatn',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      weekdayTextStyle: TextStyle(
        fontFamily: 'Vazirmatn',
        color: Colors.black87,
        fontSize: 15,
      ),
      selectedDayTextStyle: TextStyle(
          fontFamily: 'Vazirmatn',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      nextDaysTextStyle: TextStyle(
          fontFamily: 'Vazirmatn',
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      prevDaysTextStyle: TextStyle(
          fontFamily: 'Vazirmatn',
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      todayTextStyle:
          TextStyle(fontFamily: 'Vazirmatn', color: Colors.white, fontSize: 20),
      iconColor: Colors.black,
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
          fontFamily: 'Vazirmatn',
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600),

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
                      data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                        primary: Theme.of(context)
                            .primaryColor, // header background color
                        onPrimary: Colors.white, // header text color
                        onSurface: Colors.black,
                      )),
                      child: _calendarCarouselNoHeader),
                ), //
              ],
            ),
          )),
    );
  }
}
