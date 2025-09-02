
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epl/presentation/league/screens/groupStandings.dart';
import 'package:epl/shared/Views/custom/custom_imageView.dart';
import 'package:epl/shared/Views/custom/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../Data/StateModel.dart';
import '../../../domain/models/Favorite.dart';
import '../../../shared/Utils/Constants.dart';
import '../../favourite/provider/favouriteViewModel.dart';
import '../provider/LeagueViewModel.dart';
import '../../../domain/Models/Standing.dart';
import 'LeagueStanding.dart';
import 'trophies.dart';
import 'playersStats.dart';
import 'leagueNews.dart';
import 'matchsForLeague.dart';
import 'teamsStats.dart';
import 'transferCenter.dart';

class LeagueHome extends ConsumerStatefulWidget {
  dynamic leagueId;
  String? leagueName;
  String? logo;
  LeagueHome({this.leagueId, this.leagueName, this.logo});
  @override
  _LeagueHomeState createState() => _LeagueHomeState();
}

class _LeagueHomeState extends ConsumerState<LeagueHome> with TickerProviderStateMixin {
  ScrollController _controller = ScrollController();

  TextStyle tapbar =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 14, color: Colors.white);
  TextStyle head =
      TextStyle(fontFamily: 'Vazirmatn', fontSize: 16, color: Colors.white);

  bool chContaier = false;

  TabController? tabController;
  ScrollController? scrollController;
  int _selectedIndex = 0;
  int page = 1;
  String? seasonId;

  AnimationController? animationController;
  Animation<double>? _animation;
  bool isLoading = true;
  List<Widget> tabsName = [];
  List<Widget> tabsView = [];



  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchAllData();
      setUpTabsAndViews();

      print("LeagueId${widget.leagueId}");

      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          page++;
        }
      });
    });

    animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _animation = CurvedAnimation(parent: animationController!, curve: Curves.easeIn);

    animationController!.forward();
    super.initState();
  }


  Future<void> fetchAllData() async {
    try {
      final seasonId = await ref.read(leagueSeasonsProvider.notifier).getLeagueSeasons(widget.leagueId!);
      print("SeasonId ${seasonId}");
      await Future.wait([
        ref.read(leagueSeasonsProvider.notifier).getLeagueSeasons(widget.leagueId!),
        ref.read(leagueStandingProvider.notifier).getTable(seasonId!,"total"),
        ref.read(leagueMatchesProvider.notifier).getMatches(seasonId),
        ref.read(leagueNewsProvider.notifier).getNews(widget.leagueName!),
        ref.read(leaguePlayerStatsProvider.notifier).getPlayerStats(seasonId),
        ref.read(leagueTeamStatsProvider.notifier).getTeamStats(seasonId),
        ref.read(leagueTrophyProvider.notifier).getTrophy(widget.leagueId!),
      ]);
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void setUpTabsAndViews() {
    setState(() {
      tabsName = getTabs()['tabsName']!;
      tabsView = getTabs()['tabsView']!;

      tabController = TabController(length: tabsName.length, vsync: this);
    });
  }

  Map<String,List<Widget>> getTabs() {
    final leagueSeasonsState = ref.watch(leagueSeasonsProvider);
    final leagueStandingState = ref.watch(leagueStandingProvider);
    final leagueMatchesState = ref.watch(leagueMatchesProvider);
    final leagueNewsState = ref.watch(leagueNewsProvider);
    final leaguePlayerStState = ref.watch(leaguePlayerStatsProvider);
    final leagueTeamStState = ref.watch(leagueTeamStatsProvider);
    final leagueTrophyState = ref.watch(leagueTrophyProvider);



    final tabsName = <Widget>[];
    final tabsView = <Widget>[];

    Map<String,List<Widget>> tabs= {
      'tabsName':tabsName,
      'tabsView': tabsView
    };

    try {
      if (leagueStandingState.data != null) {
        if (leagueStandingState.data!.format == "default") {
          tabsName.add(PositionN());
          tabsView.add(position());
        } else if (leagueStandingState.data!.format == "groups") {
          tabsName.add(PositionN());
          tabsView.add(positionGTable());
        }
      }
      if (leagueMatchesState.data != null ) {
       // print("HELLLO${leagueMatchesState.data}");
        tabsName.add(matchesN());
        tabsView.add(matches());
      }
      if (leagueNewsState.data != null) {
        tabsName.add(NewsN());
        tabsView.add(News());
      }
      if (leaguePlayerStState.data != null) {
        tabsName.add(playersStatsN());
        tabsView.add(playerStats());
      }

      if (leagueTeamStState.data != null) {
        tabsName.add(teamsStatsN());
        tabsView.add(teamStats());
      }

      if (leagueTrophyState.data != null) {
        tabsName.add(cupsN());
        tabsView.add(cups());
      }
    }catch(e){
      print(e);
    }
    return tabs;
  }
  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var standings = ref.watch(leagueSeasonsProvider);

    List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            actions: <Widget>[
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  var fav = ref.watch(favoriteProvider);
                  final isFav = fav.data?.any((fav) => fav.id == widget.leagueId) ?? false;
                  return Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          ),
                          onPressed: null),
                      IconButton(
                          icon: Icon(isFav ? Icons.star : Icons.star_border_outlined, color: Colors.white),
                          onPressed: (){
                            FavoriteModel fav = FavoriteModel(id: widget.leagueId!, name: widget.leagueName!, type: 'competition');
                            ref.read(favoriteProvider.notifier).toggleFavorite(fav);
                          }),
                    ],
                  );
                },

              )
            ],
            expandedHeight: 130.0,
            pinned: true,
            floating: true,
            snap: true,
            flexibleSpace:
                 FlexibleSpaceBar(
                        background: Container(
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 25, top: 60),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        height: 60,
                                        width: 55,
                                        child: CustomImage(imgUrl: "${Constants.leagueImage}${widget.leagueId}.png",)
                                    )]
                                )
                              ),
                              // Positioned(
                              //     top: 105,
                              //     right: 100,
                              //     child: Row(
                              //       children: <Widget>[
                              //         Text(
                              //          "belong",
                              //           style: TextStyle(
                              //               fontFamily: 'Vazirmatn',
                              //               color: Colors.white),
                              //         )
                              //       ],
                              //     ))
                            ],
                          ),
                        ),
                        centerTitle: false,
                        titlePadding: EdgeInsets.only(top: 1.0, bottom: 20.0, left: 4, right: 100),
                        title: FittedBox(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.leagueName!,
                                        style: head,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )

          ),
        ),
        Directionality(
            textDirection: TextDirection.rtl,
            child: SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                    maxHeight: 55,
                    minHeight: 45,
                    child:Container(
                        height: 55,
                        color: Theme.of(context).primaryColor,
                        child: !isLoading? DefaultTabController(
                            length: isLoading?tabsName.length:0,
                            child: TabBar(
                              tabs: tabsName,
                              controller: tabController,
                              indicatorColor: Colors.white,
                              labelColor: Colors.white,
                              isScrollable: true,
                              onTap: (index) {
                                _selectedIndex = index;
                                tabController!.animateTo(_selectedIndex);
                              },
                            )):SizedBox()),
                )
            )
        ),
      ];
    }

    return new Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            controller: _controller,
            physics: ClampingScrollPhysics(),
            headerSliverBuilder: _sliverBuilder,
            body: DefaultTabController(
              length: !isLoading?tabsView.length:0,
              child: TabBarView(
                controller: tabController,
                children: !isLoading? tabsView: [Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CustomLoader(),
                    ),
                  ],
                )],
              ),
            ),
    )
          ),

    )
    );
  }

  Widget PositionN() {
    return Tab(
      child: Text(
        "المراكز".tr,
        style: tapbar,
      ),
    );
  }

  Widget matchesN() {
    return Tab(
      child: Text(
        "المباريات".tr,
        style: tapbar,
      ),
    );
  }

  Widget NewsN() {
    return Tab(
      child: Text(
        "الأخبار".tr,
        style: tapbar,
      ),
    );
  }

  Widget playersStatsN() {
    return Tab(
      child: Text(
        "احصائيات اللاعبين".tr,
        style: tapbar,
      ),
    );
  }

  Widget teamsStatsN() {
    return Tab(
      child: Text(
        "احصائيات الفرق".tr,
        style: tapbar,
      ),
    );
  }

  Widget transferN() {
    return Tab(
      child: Text(
        "الأنتقالات".tr,
        style: tapbar,
      ),
    );
  }

  Widget cupsN() {
    return Tab(
      child: Text(
        " المواسم".tr,
        style: tapbar,
      ),
    );
  }


  Widget position() {
    return ListView(children: <Widget>[
      LeagueStanding()
    ]);
  }

  Widget positionGTable() {
    return ListView(children: <Widget>[
      MatchGPosition(

      )
    ]);
  }

  Widget matches() {
    return ListView(children: <Widget>[matchesForLeague()]);
  }

  Widget News() {
    return ListView(children: <Widget>[leagueNews()]);
  }

  Widget playerStats() {
    return ListView(children: <Widget>[
      playersStats(

      )
    ]);
  }

  Widget teamStats() {
    return ListView(children: <Widget>[TeamState()]);
  }

  Widget transfers() {
    return ListView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: <Widget>[TransferCenter()],
    );
  }

  Widget cups() {
    return ListView(children: <Widget>[
      Trophies()
    ]);
  }


}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
