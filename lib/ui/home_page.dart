import 'package:movieku/common/data_mapper.dart';
import 'package:movieku/provider/movienow_provider.dart';
import 'package:movieku/provider/moviepopular_provider.dart';
import 'package:movieku/provider/movietop_provider.dart';
import 'package:movieku/provider/movieupcoming_provider.dart';
import 'package:movieku/provider/tidakdigunakan/search_restaurant_provider.dart' as search;
import 'package:movieku/ui/tidakdigunakan/search.dart';
import 'package:movieku/utils/result_state.dart';
import 'package:movieku/widgets/app_drawer.dart';
import 'package:movieku/widgets/card_nowplaying.dart';
import 'package:movieku/widgets/tidakdigunakan/alert_connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Provider.of<search.SearchRestaurantProvider>(context, listen: false).empty();
                  Navigator.pushNamed(context, Search.routeName);
                },
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),

      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child:
        Column(
          children: <Widget>[
            _tittleListView("Now Playing"),

            Container(
              height: 270,
              child: Consumer<MovieNowProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(child:CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(3.0),
                        itemCount: state.result.results.length,
                        itemBuilder: (context, index) {
                          return CardArticle(
                            article: DataMapper().movieNowToPopuler(state.result.results[index]),
                          );
                        },
                      ),
                    );
                  } else if (state.state == ResultState.NoData) {
                    return _buildContainerNoData(state.message);
                  } else if (state.state == ResultState.Error) {
                    return _buildCenter(state.message);
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ),

            _tittleListView("Top Rated"),

            Container(
              height: 270,
              child: Consumer<MovieTopProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(
                        child:CircularProgressIndicator()
                    );
                  } else if (state.state == ResultState.HasData) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(3.0),
                        itemCount: state.result.results.length,
                        itemBuilder: (context, index) {
                          return CardArticle(
                            article: DataMapper().movieTopToPopuler(state.result.results[index]),
                          );
                        },
                      ),
                    );
                  } else if (state.state == ResultState.NoData) {
                    return _buildContainerNoData(state.message);
                  } else if (state.state == ResultState.Error) {
                    return _buildCenter(state.message);
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ),

            _tittleListView("Popular"),

            Container(
              height: 270,
              child: Consumer<MoviePopularProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(child:CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(3.0),
                        itemCount: state.result.results.length,
                        itemBuilder: (context, index) {
                          return CardArticle(
                            article:  state.result.results[index],
                          );
                        },
                      ),
                    );
                  } else if (state.state == ResultState.NoData) {
                    return _buildContainerNoData(state.message);
                  } else if (state.state == ResultState.Error) {
                    return _buildCenter(state.message);
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ),

            _tittleListView("Upcoming"),

            Container(
              height: 270,
              child: Consumer<MovieUpcomingProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return Center(child:CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    return Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(3.0),
                        itemCount: state.result.results.length,
                        itemBuilder: (context, index) {
                          return CardArticle(
                            article: DataMapper().movieUpcomingToPopuler(state.result.results[index]),
                          );
                        },
                      ),
                    );
                  } else if (state.state == ResultState.NoData) {
                    return _buildContainerNoData(state.message);
                  } else if (state.state == ResultState.Error) {
                    return _buildCenter(state.message);
                  } else {
                    return Center(child: Text(''));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildContainerNoData(String message) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),));
  }

  Center _buildCenter(String message) {
    return Center(
      child:
      Column(
        children: <Widget>[
          AlertConnection(),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(message,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),))
          ,],),);
  }

  Row _tittleListView(String tittle) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left:20, top:10, bottom: 10),
          child: Text( tittle,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(right:20, top:10, bottom: 10),
            child:
            Text("MORE",
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}