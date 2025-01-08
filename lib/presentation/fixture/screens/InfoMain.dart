// import 'package:epl/presentation/fixture/screens/matchInfo.dart';
// import 'package:epl/shared/Views/custom/custom_loader.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
//
// import '../../home/screens/widgets/More.dart';
// import '../../league/screens/groupStandings.dart';
// import '../provider/fixtureViewModel.dart';
// import 'H2H.dart';
// import 'Lineup.dart';
// import 'MatchEvent.dart';
// import 'MatchStats.dart';
// import 'PlayerInjured.dart';
// import 'matchStanding.dart';
//
// class InfoMain extends ConsumerStatefulWidget {
//   final String? homeId;
//   final String? awayId;
//   final String? url;
//   final String? comName;
//   final String? matchId;
//   final String? fixtureId;
//   final String? seasonId;
//
//   const InfoMain({
//     this.fixtureId,
//     this.url,
//     this.homeId,
//     this.awayId,
//     this.comName,
//     this.matchId,
//     this.seasonId,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   ConsumerState<InfoMain> createState() => _InfoMainState();
// }
//
// class _InfoMainState extends ConsumerState<InfoMain> {
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_)async{
//     await fetchAllData();
//     });
//   }
//
//   Future<void> fetchAllData() async {
//     try {
//       final matchInfo = await ref.read(MatchInfoProvider.notifier).getMatchInfo(widget.fixtureId!);
//
//       await Future.wait([
//         ref.read(matchEventsProvider.notifier).fetchMatchEvents(widget.fixtureId!),
//         ref.read(matchTeamFormProvider.notifier).fetchMatchTeamForm(widget.fixtureId!),
//         ref.read(matchLineupsProvider.notifier).fetchMatchLineUps(widget.fixtureId!),
//         ref.read(matchTableProvider.notifier).fetchMatchTable(matchInfo!.league.season!),
//         ref.read(matchStatsProvider.notifier).fetchMatchStats(widget.fixtureId!),
//         ref.read(matchH2HProvider.notifier).fetchMatchH2H(widget.fixtureId!),
//       ]);
//     } catch (e) {
//       print("Error fetching data: $e");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // if (isLoading) {
//     //   return Scaffold(body: const Center(child: CustomLoader()));
//     // }
//
//     final matchEventsState = ref.watch(matchEventsProvider);
//     final matchTeamFormState = ref.watch(matchTeamFormProvider);
//     final matchLineupsState = ref.watch(matchLineupsProvider);
//     final matchTableState = ref.watch(matchTableProvider);
//     final matchStatsState = ref.watch(matchStatsProvider);
//     final matchH2HState = ref.watch(matchH2HProvider);
//
//     final tabs = <Widget>[];
//     final tabViews = <Widget>[];
//
//     if (matchEventsState.data!=null || matchTeamFormState.data!=null) {
//       tabs.add(matchEventName());
//       tabViews.add(matchEvent());
//     }
//
//     if (matchLineupsState.data != null) {
//       tabs.add(lineUpName());
//       tabViews.add(lineUp());
//     }
//
//     if (matchStatsState.data != null) {
//       tabs.add(statsName());
//       tabViews.add(stats());
//     }
//
//     if (matchTableState.data != null) {
//       tabs.add(matchTableName());
//       tabViews.add(matchTable());
//     }
//
//     if (matchH2HState.data != null) {
//       tabs.add(matchHTHName());
//       tabViews.add(matchHTH());
//     }
//
//     return MatchInfo(tabs: tabs, tabsView: tabViews, homeId: widget.homeId, awayId: widget.awayId,);
//   }
//
//   Widget matchEventName() => Tab(
//     child: Text(
//       "معاينة ".tr,
//       style: tapbar,
//     ),
//   );
//
//   Widget lineUpName() => Tab(
//     child: Text(
//       "تشكيلة".tr,
//       style: tapbar,
//     ),
//   );
//
//   Widget matchTableName() => Tab(
//     child: Text(
//       "المراكز".tr,
//       style: tapbar,
//     ),
//   );
//
//   Widget statsName() => Tab(
//     child: Text(
//       "إحصائيات".tr,
//       style: tapbar,
//     ),
//   );
//
//   Widget matchHTHName() => Tab(
//     child: Text(
//       "المواجهة ".tr,
//       style: tapbar,
//     ),
//   );
//
//   Widget matchEvent() => ListView(
//     children: [
//       MatchEvents(
//         fixture_id: widget.fixtureId,
//         homeId: widget.homeId,
//         awayId: widget.awayId,
//       ),
//     ],
//   );
//
//   Widget lineUp() => LineUps();
//
//   Widget matchTable() => ListView(children: [MatchStanding()]);
//
//   Widget stats() => MatchStats();
//
//   Widget matchHTH() => ListView(children: [H2H()]);
// }
