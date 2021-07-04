import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  String? _searchText;

  _SearchScreenState() {
    this._textEditingController.addListener(() {
      setState(() {
        this._searchText = this._textEditingController.text;
      });
    });
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
            ],
          ),
        ),
      ),
    );
  }
}
