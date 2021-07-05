import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tms/models/movie_models/movie_model.dart';
import 'package:tms/models/search_model.dart';
import 'package:tms/providers/search_provider.dart';
import 'package:tms/widgets/movie_main_widget/movie_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  late String _searchText;
  late SearchProvider _searchController;

  _SearchScreenState() {
    this._textEditingController.addListener(() {
      setState(() {
        this._searchText = this._textEditingController.text;
      });
    });
  }
  @override
  void initState() {
    this._searchController = Provider.of<SearchProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
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
                        cursorColor: Colors.grey,
                        focusNode: this._focusNode,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                        autofocus: true,
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
                                      this._searchText = '';
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
                    _focusNode.hasFocus
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
                                this._searchText = '';
                                this._focusNode.unfocus();
                              });
                            },
                          ))
                        : Expanded(flex: 0, child: Container())
                  ],
                ),
              ),
              _searchList(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchList(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: this._searchController.search(),
        builder:
            (BuildContext context, AsyncSnapshot<List<SearchModel>> snapshot) {
          if (snapshot.hasData) {
            return Consumer<SearchProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          snapshot.data!.length,
                          (index) => GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  child: Text(snapshot.data![i].name),
                                );
                              }
                              // _movieWidget.movieWidget(
                              // snapshot.data![index], context)
                              ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
