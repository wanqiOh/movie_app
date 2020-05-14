import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Movie.dart';
import 'OmdbRepository.dart';
import 'SearchViewModel.dart';
import 'SearchViewState.dart';

const OmdbRepository repo = OmdbRepository();

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
  }
class _HomeScreenState extends State<HomeScreen> {
  bool _isVisible = false;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String _message = 'Log in/out by pressing the buttons below.';
  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
    Navigator.of(context).pushNamed('/LoginPage');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  final viewModel = SearchViewModel(repo);

  Movie _currentMovie;
  var _editTextController = TextEditingController();

  void _searchMovie(String name) {
    viewModel.search(name);
  }

  void _changeCurrentMovie(Movie movie) {
    setState(() {
      _currentMovie = movie;
    });
  }

  Widget _currentMovieBackground() {
    if (_currentMovie != null) {
      return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Expanded(
            child: Container(
                constraints: BoxConstraints.expand(),
                color: Colors.black,
                child: new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImage(_currentMovie.poster),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.black45.withAlpha(100)),
                    ),
                  ),
                ))),
      ]);
    } else {
      return Container(
        color: Colors.white,
      );
    }
  }

  Widget _currentMovieHeader() {
    if (_currentMovie != null) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _currentMovie.title.replaceAll(" ", "\n").toUpperCase(),
              style: TextStyle(
                  shadows: [
                    Shadow(
                        offset: Offset(2.0, 2),
                        blurRadius: 2.0,
                        color: Colors.black87)
                  ],
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                decoration: TextDecoration.none,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              height: 5,
              width: 30,
              color: Colors.red[200],
            ),
            Text(_currentMovie.type + " (" + _currentMovie.year + ")",
                style: TextStyle(
                    shadows: [
                      Shadow(
                          offset: Offset(2.0, 2),
                          blurRadius: 2.0,
                          color: Colors.black87)
                    ],
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.none
                ))
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildInputText() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          elevation: 20.0,
          shadowColor: Colors.black,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.search,color: Colors.white,),
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                    _searchMovie(_editTextController.text);
                  },
                ),
                Visibility(
                  visible: _isVisible,
                  child: Flexible(
                    child: TextField(
                      decoration:
                      InputDecoration.collapsed(hintText: "Search movie",hintStyle: TextStyle(color: Colors.grey.shade500)),
                      onSubmitted: (text) {
                        _searchMovie(_editTextController.text);
                      },
                      controller: _editTextController,
                    ),
                  ),
                ),
                IconButton(
                  icon: Image.asset('images/logout.png', color: Colors.white, scale: 10.0,),
                  onPressed: () {
                    _logOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(SearchViewState viewmodel) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, position) {
            var movie = viewmodel.movies[position];
            return Padding(
              padding:
              const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20),
              child: GestureDetector(
                onTap: () {
                  _changeCurrentMovie(movie);
                },
                child: AspectRatio(
                  aspectRatio: 10 / 16,
                  child: Card(
                    elevation: 10.0,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Image.network(
                      movie.poster,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: viewmodel.movies.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchViewState>(
        stream: viewModel.viewState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var viewmodel = snapshot.data;
            if (_currentMovie == null) {
              _currentMovie =
              viewmodel.movies.length > 0 ? viewmodel.movies[0] : null;
            }
            return Stack(
              children: [
                _currentMovieBackground(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputText(),
                    _currentMovieHeader(),
                  ],
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: _buildListView(viewmodel),
                ),
              ],
            );
          }
        });
  }
}
