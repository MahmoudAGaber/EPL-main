
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Data/RequestHandler.dart';
import '../../../Data/StateModel.dart';

import '../../../domain/Models/Event.dart';
import '../../../domain/Models/Formation.dart';
import '../../../domain/Models/H2H.dart';
import '../../../domain/Models/MatchInfo.dart';
import '../../../domain/Models/MatchStatistics.dart';
import '../../../domain/Models/Standing.dart';
import '../../../domain/Models/TeamForm.dart';
import '../../../domain/repository/MatchRepositry.dart';
import '../../../domain/usecases/FixtureUseCases.dart';



enum FixtureStandingType {All, Home, Away }

final FixtureStandingTypeProvider = StateProvider<FixtureStandingType>((ref) => FixtureStandingType.All);

final MatchInfoProvider = StateNotifierProvider<MatchInfoNotifier,StateModel<MatchInfoModel>>((ref) => MatchInfoNotifier(ref));


final TableProvider = StateNotifierProvider<TableNotifier,StateModel<TableModel>>((ref) => TableNotifier(ref));

final TableInOverviewProvider = StateNotifierProvider<TableInOverViewNotifier,StateModel<TableModel>>((ref) => TableInOverViewNotifier(ref));




class MatchInfoNotifier extends StateNotifier<StateModel<MatchInfoModel>>{
  Ref ref;
  MatchInfoNotifier(this.ref):super(StateModel.loading());

  Future<MatchInfoModel?> getMatchInfo(String fixture_id) async{
    RequestHandler requestHandler = RequestHandler();
    MatchInfoModel matchInfoModel;
    Map<String, dynamic> body;
    try {

      body = {
        "fixture_id": fixture_id,
        "lang": "ar"
      };

      state = StateModel.loading();
      matchInfoModel = await requestHandler.postData(
        endPoint: "soccer/fixture/info/main",
        auth: true,
        requestBody: body,
        fromJson: (json)=> MatchInfoModel.fromJson(json),
      );

      state = StateModel.success(matchInfoModel);

      return matchInfoModel;

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
      return null;
    }
  }
}




class TableNotifier extends StateNotifier<StateModel<TableModel>>{
  Ref ref;
  TableModel? tableModel;
  TableNotifier(this.ref):super(StateModel.loading());

  Future<void> getTable(String season_id,String type) async{
    RequestHandler requestHandler = RequestHandler();
    Map<String, dynamic> body;


    try{
      body = {
        "season_id": season_id,
        "lang": "ar",
        "type": type
      };

      state = StateModel.loading();
      final jsonResponse = await requestHandler.postData(
        endPoint: "soccer/team/table",
        auth: true,
        requestBody: body,
        fromJson: (json) => json,
      );
      tableModel = TableModel.fromJson(jsonResponse);
      // print("HELLOTABLEMODEL${jsonResponse['format']}");
      // if(jsonResponse['format'] == 'default'){
      //   tableModel = TableModel.fromJson(jsonResponse);
      // }
      // else if(jsonResponse['format'] == 'groups'){
      //   tableModel = GroupTableModel.fromJson(jsonResponse);
      //
      // }
      if(tableModel!.standings[0].isNotEmpty){
        print(tableModel!.seasonId);

        state = StateModel.success(tableModel);

      }else{
        state = StateModel.empty();
      }

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }

  Future<List<Standing>?> getTeamsInTable(String homeId, String awayId) async{
    var table = ref.read(TableProvider);
    List<Standing> standings = [];
    try{
      if(table.data != null){
        for(var row in table.data!.standings![0]){
          if(row.team.id == homeId || row.team.id == awayId){
            standings.add(row);
          }
        }
      }
      print("hohoaa${standings}");
      return standings;
    }catch(e){
    print(e);
    return null;
    }
  }

  List<LeagueZones> getLeagueZones(){
    List<LeagueZones> leagueZones = [];
    for(var item in tableModel!.standings[0]){
      if(item.all.zoneStart.isNotEmpty){
        leagueZones.add(LeagueZones(zoneStart: item.all.zoneStart, zoneColor: item.all.zoneColor));
      }
    }
  return leagueZones;
  }
}

class TableInOverViewNotifier extends StateNotifier<StateModel<TableModel>>{
  Ref ref;
  TableInOverViewNotifier(this.ref):super(StateModel.loading());

  Future<List<Standing>?> getTeamsInTable(String homeId, String awayId) async{
    var table = ref.read(TableProvider);
    List<Standing> standings = [];
    try{
      if(table.data != null){
        for(var row in table.data!.standings![0]){
          if(row.team.id == homeId || row.team.id == awayId){
            standings.add(row);
          }
        }
      }
      return standings;
    }catch(e){
      print(e);
      return null;
    }
  }

}




//// test useCases with provider



class MatchEvents1Notifier extends StateNotifier<StateModel<List<EventModel>>> {
  final GetMatchEventsUseCase useCase;

  MatchEvents1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchMatchEvents(String fixtureId) async {
    try {
      state = StateModel.loading();
      final events = await useCase.execute(fixtureId);
      state = events.isNotEmpty
          ? StateModel.success(events)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch events: $e");
    }
  }
}

class MatchTeamForm1Notifier extends StateNotifier<StateModel<TeamFormModel>> {
  final GetMatchTeamFormUseCase useCase;

  MatchTeamForm1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchMatchTeamForm(String fixtureId) async {
    try {
      state = StateModel.loading();
      final teamForm = await useCase.execute(fixtureId);
      state = teamForm.teamForm2.isNotEmpty
          ? StateModel.success(teamForm)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch events: $e");
    }
  }
}

class MatchLineUps1Notifier extends StateNotifier<StateModel<FormationsModel>> {
  final GetLineUpsUseCase useCase;

  MatchLineUps1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchMatchLineUps(String fixtureId) async {
    try {
      state = StateModel.loading();
      final lineups = await useCase.execute(fixtureId);
      state = lineups.formations[0].startXI.isNotEmpty
          ? StateModel.success(lineups)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch events: $e");
    }
  }
}

class MatchTable1Notifier extends StateNotifier<StateModel<dynamic>> {
  final GetTableUseCase useCase;

  MatchTable1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchMatchTable(String seasonId,String type) async {
    try {
      state = StateModel.loading();
      final table = await useCase.execute(seasonId,type);
      print("${table}");
      state = table.standings.isNotEmpty
          ? StateModel.success(table)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch events: $e");
    }
  }
}

class MatchStatistics1Notifier extends StateNotifier<StateModel<List<MatchStatisticsModel>>> {
  final GetStatisticsUseCase useCase;

  MatchStatistics1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchMatchStats(String fixtureId) async {
    try {
      state = StateModel.loading();
      final stats = await useCase.execute(fixtureId);
      state = stats[0].statistics.isNotEmpty
          ? StateModel.success(stats)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch events: $e");
    }
  }
}

class MatchH2H1Notifier extends StateNotifier<StateModel<H2HModel>> {
  final GetH2HUseCase useCase;

  MatchH2H1Notifier(this.useCase) : super(StateModel.loading());

  Future<void> fetchMatchH2H(String fixtureId) async {
    try {
      state = StateModel.loading();
      final h2h = await useCase.execute(fixtureId);
      state = h2h.h2h.isNotEmpty
          ? StateModel.success(h2h)
          : StateModel.empty();
    } catch (e) {
      state = StateModel.fail("Failed to fetch events: $e");
    }
  }
}


final fixtureLoadingTabsProvider = StateProvider<bool>((ref) => true);


final matchEventsProvider = StateNotifierProvider<MatchEvents1Notifier, StateModel<List<EventModel>>>((ref) {
    final getMatchEventsUseCase = ref.read(getMatchEventsUseCaseProvider);
    return MatchEvents1Notifier(getMatchEventsUseCase);
  },
);

final matchTeamFormProvider = StateNotifierProvider<MatchTeamForm1Notifier, StateModel<TeamFormModel>>((ref) {
  final getMatchTeamFormUseCase = ref.read(getMatchTeamFormUseCaseProvider);
  return MatchTeamForm1Notifier(getMatchTeamFormUseCase);
},
);

final matchLineupsProvider = StateNotifierProvider<MatchLineUps1Notifier, StateModel<FormationsModel>>(
      (ref) {
    final getMatchLineupsUseCase = ref.read(getMatchLineupsUseCaseProvider);
    return MatchLineUps1Notifier(getMatchLineupsUseCase);
  },
);

final matchTableProvider = StateNotifierProvider<MatchTable1Notifier, StateModel<dynamic>>(
      (ref) {
    final getMatchTableUseCase = ref.read(getMatchTableUseCaseProvider);
    return MatchTable1Notifier(getMatchTableUseCase);
  },
);

final matchStatsProvider = StateNotifierProvider<MatchStatistics1Notifier, StateModel<List<MatchStatisticsModel>>>(
      (ref) {
    final getMatchStatsUseCase = ref.read(getMatchStatsUseCaseProvider);
    return MatchStatistics1Notifier(getMatchStatsUseCase);
  },
);

final matchH2HProvider = StateNotifierProvider<MatchH2H1Notifier, StateModel<H2HModel>>(
      (ref) {
    final getMatchH2HUseCase = ref.read(getMatchH2HUseCaseProvider);
    return MatchH2H1Notifier(getMatchH2HUseCase);
  },
);



final getMatchEventsUseCaseProvider = Provider<GetMatchEventsUseCase>((ref) {
  final repository = ref.read(matchRepositoryProvider);
  return GetMatchEventsUseCase(repository);
});

final getMatchTeamFormUseCaseProvider = Provider<GetMatchTeamFormUseCase>((ref) {
  final repository = ref.read(matchRepositoryProvider);
  return GetMatchTeamFormUseCase(repository);
});


final getMatchLineupsUseCaseProvider = Provider<GetLineUpsUseCase>((ref) {
  final repository = ref.read(matchRepositoryProvider);
  return GetLineUpsUseCase(repository);
});

final getMatchTableUseCaseProvider = Provider<GetTableUseCase>((ref) {
  final repository = ref.read(matchRepositoryProvider);
  return GetTableUseCase(repository);
});

final getMatchStatsUseCaseProvider = Provider<GetStatisticsUseCase>((ref) {
  final repository = ref.read(matchRepositoryProvider);
  return GetStatisticsUseCase(repository);
});

final getMatchH2HUseCaseProvider = Provider<GetH2HUseCase>((ref) {
  final repository = ref.read(matchRepositoryProvider);
  return GetH2HUseCase(repository);
});









final apiServiceProvider = Provider<RequestHandler>((ref) {
  return RequestHandler();
});

final matchRepositoryProvider = Provider<MatchRepositoryImpl>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return MatchRepositoryImpl(apiService);
});

class LeagueZones{
  final String zoneStart;
  final String zoneColor;

  LeagueZones({
    required this.zoneStart,
    required this.zoneColor
  });
}
