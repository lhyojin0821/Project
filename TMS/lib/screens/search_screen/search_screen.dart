import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/search_model.dart';
import 'package:tms/providers/movie_provider/movie_detail_provider.dart';
import 'package:tms/providers/movie_provider/movie_video_provider.dart';
import 'package:tms/providers/search_provider.dart';
import 'package:tms/providers/tv_provider/tv_detail_provider.dart';
import 'package:tms/providers/tv_provider/tv_video_provider.dart';
import 'package:tms/screens/search_screen/search_movie_detail_screen.dart';
import 'package:tms/screens/search_screen/search_tv_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  TabController? _tabController;

  late SearchProvider _searchController;
  late String movieName;

  @override
  void initState() {
    super.initState();
    this._searchController = Provider.of<SearchProvider>(
      context,
      listen: false,
    );
    this.movieName = this._textEditingController.text;
    this._tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    this._textEditingController.dispose();
    this._tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.black,
          child: SafeArea(
              child: Container(
            child: Column(
              children: [
                TabBar(
                  indicatorColor: Colors.grey,
                  controller: this._tabController,
                  tabs: [
                    Tab(
                      text: 'MOVIE',
                    ),
                    Tab(
                      text: 'TV',
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      ),
      // bottom:

      body: TabBarView(
        controller: this._tabController,
        children: [
          Column(
            children: [
              search(),
              this.movieName.isNotEmpty ? searchMovieTile() : Container(),
            ],
          ),
          Column(
            children: [
              search(),
              this.movieName.isNotEmpty ? searchTvTile() : Container(),
            ],
          )
        ],
      ),
    );
  }

  Widget search() {
    return Container(
      padding: EdgeInsets.only(
        left: 5.0,
        top: 10.0,
        right: 5.0,
        bottom: 10.0,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: TextField(
              onSubmitted: (String name) {
                this.movieName = this._textEditingController.text;
                print(this.movieName);
              },
              cursorColor: Colors.grey,
              focusNode: this._focusNode,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              controller: this._textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20.0,
                ),
                suffixIcon: this._focusNode.hasFocus
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            this._textEditingController.clear();
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          size: 20.0,
                          color: Colors.grey,
                        ),
                      )
                    : Container(),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          this._focusNode.hasFocus
              ? Expanded(
                  child: TextButton(
                  child: Text(
                    'cancel',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      this._textEditingController.clear();
                      this._focusNode.unfocus();
                    });
                  },
                ))
              : Expanded(flex: 0, child: Container())
        ],
      ),
    );
  }

  Widget searchMovieTile() {
    return FutureBuilder(
      future: this._searchController.searchMovie(movieName: this.movieName),
      builder:
          (BuildContext context, AsyncSnapshot<List<SearchModel>> snapshot) {
        if (snapshot.hasData) {
          return Consumer<SearchProvider>(
            builder: (context, value, child) {
              return snapshot.data!.isEmpty
                  ? Container()
                  : SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height - 280.0,
                        child: GridView.count(
                          childAspectRatio: 2 / 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          crossAxisCount: 3,
                          children: List.generate(
                            snapshot.data!.length,
                            (index) => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                MovieDetailProvider()),
                                        ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                MovieVideoProvider()),
                                      ],
                                      child: SearchMovieDetailScreen(
                                          movieData: snapshot.data![index]),
                                    );
                                  }));
                                },
                                child: snapshot.data![index].posterPath.isEmpty
                                    ? Container(
                                        child: Center(
                                          child: Text(
                                            'Image preparation',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${snapshot.data![index].posterPath}',
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget searchTvTile() {
    return FutureBuilder(
      future: this._searchController.searchTv(movieName: this.movieName),
      builder:
          (BuildContext context, AsyncSnapshot<List<SearchModel>> snapshot) {
        if (snapshot.hasData) {
          return Consumer<SearchProvider>(
            builder: (context, value, child) {
              return snapshot.data!.isEmpty
                  ? Container()
                  : SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height - 280.0,
                        child: GridView.count(
                          scrollDirection: Axis.vertical,
                          childAspectRatio: 2 / 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          crossAxisCount: 3,
                          children: List.generate(
                            snapshot.data!.length,
                            (index) => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return MultiProvider(
                                      providers: [
                                        ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                TvDetailProvider()),
                                        ChangeNotifierProvider(
                                            create: (BuildContext context) =>
                                                TvVideoProvider()),
                                      ],
                                      child: SearchTvDetailScreen(
                                          tvData: snapshot.data![index]),
                                    );
                                  }));
                                },
                                child: snapshot.data![index].posterPath.isEmpty
                                    ? Container(
                                        child: Center(
                                          child: Text(
                                            'Image preparation',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original/${snapshot.data![index].posterPath}',
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
