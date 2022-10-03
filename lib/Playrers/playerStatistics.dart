import 'package:arseli/Provider/EachPlayerViewModel.dart';
import 'package:arseli/main.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'playerStatistics.D.dart';

class playerStatistics extends StatefulWidget {
  String url;
  playerStatistics({this.url});
  @override
  _playerStatisticsState createState() => _playerStatisticsState();
}

const TextStyle _textStyle = TextStyle(
    fontFamily: 'Vazirmatn',
    color: Colors.grey,
    fontSize: 15,
    fontWeight: FontWeight.w500);

class _playerStatisticsState extends State<playerStatistics> {

  EachplayerViewModel eachplayerViewModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eachplayerViewModel = Provider.of(context, listen: false);
      eachplayerViewModel.getProfile(widget.url);
    }); //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Consumer<EachplayerViewModel>(builder: (context, provider, child) {
       return provider.loadingPlayer
           ? Padding(
         padding: const EdgeInsets.only(top: 35),
         child: Center(
           child: CircularProgressIndicator(
             color: Theme
                 .of(context)
                 .primaryColor,
           ),
         ),
       )
           : Padding(
             padding: const EdgeInsets.all(12),
             child: ListView(
         shrinkWrap: true,
         scrollDirection: Axis.vertical,
         physics: BouncingScrollPhysics(),
         children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   width: MediaQuery
                       .of(context)
                       .size
                       .width,
                   child: Card(
                     shape: RoundedRectangleBorder(
                         borderRadius:
                         BorderRadius.all(Radius.circular(10.0))),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Text(
                            'النادي الحالي',
                             style: Theme.of(context).textTheme.headline2
                           ),
                         ),
                         Divider(),
                         Column(

                           children: [
                             ListView.builder(
                                 shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                 itemCount: 1,
                                 itemBuilder: (context, index) {
                                   return Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.all(12),
                                         child: Row(
                                           children: [
                                             Container(
                                               width: 40,
                                               height: 40,
                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.all(
                                                   Radius.circular(50),
                                                 ),
                                                 child: Image.network(
                                                   "https://www.eplworld.com${provider.piModel.career[index].Logo}",fit: BoxFit.contain,),
                                               ),
                                             ),
                                             SizedBox(width: 12,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text(provider.piModel.career[index].teamName,style: Theme.of(context).textTheme.bodyText1),
                                                 Text(provider.piModel.career[index].startDate,style: Theme.of(context).textTheme.bodyText2),
                                               ],
                                             )
                                           ],
                                         ),
                                       ),
                                     ],

                                   );
                                 })
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
                 SizedBox(height: 8,),
                 Container(
                   width: MediaQuery
                       .of(context)
                       .size
                       .width,
                   child: Card(
                     shape: RoundedRectangleBorder(
                         borderRadius:
                         BorderRadius.all(Radius.circular(10.0))),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Text(
                             provider.piModel.type=='player'?'الانديه التي لعب بها':'مهنة التدريب',
                               style: Theme.of(context).textTheme.headline2
                           ),
                         ),
                         Divider(),
                         Column(

                           children: [
                             ListView.builder(
                                 shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                 itemCount: provider.piModel.career.length,
                                 itemBuilder: (context, index) {
                                   return Column(
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.all(16),
                                         child: Row(
                                           children: [
                                             Container(
                                               width: 40,
                                               height: 40,
                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.all(
                                                   Radius.circular(50),
                                                 ),
                                                 child: Image.network(
                                                   "https://www.eplworld.com${provider.piModel.career[index].Logo}",fit: BoxFit.contain,),
                                               ),
                                             ),
                                             SizedBox(width: 12,),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text(provider.piModel.career[index].teamName,style: Theme.of(context).textTheme.bodyText1),
                                                 Text(provider.piModel.career[index].startDate,style: Theme.of(context).textTheme.bodyText2),
                                               ],
                                             )
                                           ],
                                         ),
                                       ),

                                       Divider()
                                     ],

                                   );
                                 })
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ],
             ),
         ],

             ),
           );
     });
  }
}
