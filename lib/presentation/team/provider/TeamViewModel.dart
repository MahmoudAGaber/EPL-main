
import 'package:epl/domain/models/Teams/teamOverview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Data/RequestHandler.dart';
import '../../../Data/StateModel.dart';
import '../../../domain/Models/Standing.dart';
import '../../../domain/Models/TeamForm.dart';
import '../../../domain/Models/Teams/Squad.dart';
import '../../../domain/Models/Teams/TeamSeasons.dart';
import '../../../domain/Models/Teams/TeamTrophy.dart';
import '../../../domain/models/News.dart';


enum StandingType {All, Home, Away }

final TeamOverviewProvider = StateNotifierProvider<TeamOverviewNotifier,StateModel<TeamOverviewModel>>((ref) => TeamOverviewNotifier(ref));

final TeamNewsProvider = StateNotifierProvider<TeamNewsNotifier,StateModel<List<NewsModel>>>((ref) => TeamNewsNotifier(ref));

final TeamVideosProvider = StateNotifierProvider<TeamVideosNotifier,StateModel<List<NewsModel>>>((ref) => TeamVideosNotifier(ref));

final TeamMatchesProvider = StateNotifierProvider<TeamMatchesNotifier,StateModel<List<FixtureOverview>>>((ref) => TeamMatchesNotifier(ref));

final TeamSeasonsProvider = StateNotifierProvider<TeamSeasonsNotifier,StateModel<List<SeasonModel>>>((ref) => TeamSeasonsNotifier(ref));

final TeamTableProvider = StateNotifierProvider<TeamTableNotifier,StateModel<TableModel>>((ref) => TeamTableNotifier(ref));

final StandingTypeProvider = StateProvider<StandingType>((ref) => StandingType.All);

final SquadProvider = StateNotifierProvider<SquadNotifier,StateModel<SquadModel>>((ref) => SquadNotifier(ref));

final TrophyProvider = StateNotifierProvider<TrophyNotifier,StateModel<List<TrophyModel>>>((ref) => TrophyNotifier(ref));



class TeamOverviewNotifier extends StateNotifier<StateModel<TeamOverviewModel>>{
  Ref ref;
  TeamOverviewNotifier(this.ref):super(StateModel.loading());

  Future<void> getTeamOverview(String teamId, String seasonId) async{
    RequestHandler requestHandler = RequestHandler();
    TeamOverviewModel teamOverviewModel ;
    Map<String, dynamic> body;
    try {
      body = {
        "team_id": teamId,
        "season_id": seasonId
      };

      state = StateModel.loading();

      teamOverviewModel = await requestHandler.postData(
        endPoint: "soccer/team/overview",
        auth: true,
        requestBody: body,
        fromJson: (json)=> TeamOverviewModel.fromJson(json),
      );

      print("HELLOGUYS${teamOverviewModel}");

    List<FixtureOverview> finishedFixtures = teamOverviewModel.fixtures
        .where((fixture) => fixture.fixture.status.short == 'FT')
        .toList();

      teamOverviewModel.fixtures = finishedFixtures;
    teamOverviewModel.fixtures.sort((a, b) => b.fixture.timestamp.compareTo(a.fixture.timestamp));

      state = StateModel.success(teamOverviewModel);

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }

}

class TeamNewsNotifier extends StateNotifier<StateModel<List<NewsModel>>>{
  Ref ref;
  TeamNewsNotifier(this.ref):super(StateModel.loading());

  Future<void> getNews(String teamName) async{
    RequestHandler requestHandler = RequestHandler();
    NewsResponse newsResponse;
    List<NewsModel> news = [];
    Map<String, dynamic> body;
    try {
      body = {
        "search_string": teamName,
      };

      state = StateModel.loading();

      newsResponse = await requestHandler.postData(
        endPoint: "soccer/team/news",
        auth: true,
        requestBody: body,
        fromJson: (json)=> NewsResponse.fromJson(json),
      );

      news = newsResponse.news;

       List<NewsModel> filteredNews = news.where((element) => element.type == "article" || element.type == "tweet").toList();

      state = StateModel.success(filteredNews);

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }

}

class TeamVideosNotifier extends StateNotifier<StateModel<List<NewsModel>>>{
  Ref ref;
  TeamVideosNotifier(this.ref):super(StateModel.loading());


  Future<void> getVideos(String teamName) async{
    RequestHandler requestHandler = RequestHandler();
    NewsResponse newsResponse;
    List<NewsModel> news = [];
    Map<String, dynamic> body;
    try {
      body = {
        "search_string": teamName,
      };

      state = StateModel.loading();

      newsResponse = await requestHandler.postData(
        endPoint: "soccer/team/news",
        auth: true,
        requestBody: body,
        fromJson: (json)=> NewsResponse.fromJson(json),
      );


      news = newsResponse.news;

      List<NewsModel> filteredNews = news.where((element) => element.type == "youtube-video").toList();

      state = StateModel.success(filteredNews);

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }
}

class TeamSeasonsNotifier extends StateNotifier<StateModel<List<SeasonModel>>>{
  Ref ref;
  TeamSeasonsNotifier(this.ref):super(StateModel.loading());


  Future<String?> getTeamSeasons(String teamId) async{
    RequestHandler requestHandler = RequestHandler();
    List<SeasonModel> teamSeasons = [];
    Map<String, dynamic> body;
    try {
      body = {
        "lang": "en",
        "team_id": teamId
      };

      state = StateModel.loading();

      teamSeasons = await requestHandler.postData(
        endPoint: "soccer/team/seasons",
        auth: true,
        requestBody: body,
        fromJson: (json)=> SeasonModel.listFromJson(json),
      );

      teamSeasons =  teamSeasons.where((element) => element.name.contains("/")).toList();
      teamSeasons.sort((a, b) => b.startDate.split("/").first.compareTo(a.startDate.split("/").first));

      state = StateModel.success(teamSeasons);

      return teamSeasons.first.seasonId;
    }catch(e){
      state = StateModel.fail("Faild to get data $e");
      return null;
    }
  }
}

class TeamMatchesNotifier extends StateNotifier<StateModel<List<FixtureOverview>>>{
  Ref ref;
  TeamMatchesNotifier(this.ref):super(StateModel.loading());


  Future<void> getMatches(String teamId, String seasonId) async{
    RequestHandler requestHandler = RequestHandler();
    List<FixtureOverview> matches = [];
    Map<String, dynamic> body;
    try {
      body = {
        "lang": "en",
        "season_id": seasonId,
        "team_id": teamId
      };

      state = StateModel.loading();

      matches = await requestHandler.postData(
        endPoint: "soccer/team/matches",
        auth: true,
        requestBody: body,
        fromJson: (json)=> FixtureOverview.listFromJson(json),
      );


      state = StateModel.success(matches);

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }
}

class TeamTableNotifier extends StateNotifier<StateModel<TableModel>>{
  Ref ref;
  TeamTableNotifier(this.ref):super(StateModel.loading());

  Future<void> getTable(String season_id,String type) async{
    RequestHandler requestHandler = RequestHandler();
    TableModel tableModel;
    Map<String, dynamic> body;

    body = {
      "season_id": season_id,
      "lang": "ar",
      "type": type
    };

    try{
      state = StateModel.loading();
      tableModel = await requestHandler.postData(
        endPoint: "soccer/team/table",
        auth: true,
        requestBody: body,
        fromJson: (json) => TableModel.fromJson(json),
      );
      if(tableModel.standings![0].isNotEmpty){
        state = StateModel.success(tableModel);

      }else{
        state = StateModel.empty();
      }

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }

}

class SquadNotifier extends StateNotifier<StateModel<SquadModel>> {
  Ref ref;
  SquadNotifier(this.ref) : super(StateModel.loading());

  List<Person> players = [];

  Future<void> getSquad(String teamId) async {
    RequestHandler requestHandler = RequestHandler();
    SquadModel squadModel;
    Map<String, dynamic> body;

    body = {
      "team_id": teamId,
      "lang": "en",
    };

    try {
      state = StateModel.loading();
      squadModel = await requestHandler.postData(
        endPoint: "soccer/team/squads",
        auth: true,
        requestBody: body,
        fromJson: (json) => SquadModel.fromJson(json),
      );

      players = squadModel.person;


      state = StateModel.success(squadModel);
    } catch (e) {
      state = StateModel.fail("Failed to get data $e");
    }
  }

  String normalizePosition(String? position) {
    if (position == null) return "unknown";

    switch (position.toLowerCase()) {
      case "goalkeeper":
      case "gk":
        return "goalkeeper";
      case "defender":
      case "df":
        return "defender";
      case "midfielder":
      case "mf":
        return "midfielder";
      case "attacker":
      case "forward":
      case "fw":
        return "attacker";
      default:
        return "unknown";
    }
  }

  // Getters for different roles
  List<Person> getCoach() {
    return players.where((person) {
      return person.type == "assistant coach" || person.type == "coach";
    }).toList();
  }

  List<Person> getGoalKeepers() {
    return players.where((person) {
      return normalizePosition(person.position) == "goalkeeper";
    }).toList();
  }

  List<Person> getDefenders() {
    return players.where((person) {
      return normalizePosition(person.position) == "defender";
    }).toList();
  }

  List<Person> getMidfielders() {
    return players.where((person) {
      return normalizePosition(person.position) == "midfielder";
    }).toList();
  }

  List<Person> getAttackers() {
    return players.where((person) {
      return normalizePosition(person.position) == "attacker";
    }).toList();
  }

}

class TrophyNotifier extends StateNotifier<StateModel<List<TrophyModel>>>{
  Ref ref;
  TrophyNotifier(this.ref):super(StateModel.loading());

  Future<void> getTrophy(String teamId) async{
    RequestHandler requestHandler = RequestHandler();
    List<TrophyModel> trophyModel = [];
    Map<String, dynamic> body;

    body = {
      "team_id": teamId,
      "lang": "ar",

    };


      state = StateModel.loading();
      trophyModel = await requestHandler.postData(
        endPoint: "soccer/team/trophy",
        auth: true,
        requestBody: body,
        fromJson: (json) => TrophyModel.listFromJson(json),
      );
        state = StateModel.success(trophyModel);



  }

}


