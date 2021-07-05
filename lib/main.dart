import 'package:movieku/common/navigation.dart';
import 'package:movieku/common/styles.dart';
import 'package:movieku/data/api/api_service.dart';
import 'package:movieku/data/db/database_helper.dart';
import 'package:movieku/provider/database_provider.dart';
import 'package:movieku/provider/detailmovie_provider.dart';
import 'package:movieku/provider/movienow_provider.dart';
import 'package:movieku/provider/moviepopular_provider.dart';
import 'package:movieku/provider/movietop_provider.dart';
import 'package:movieku/provider/movieupcoming_provider.dart';
import 'package:movieku/provider/movievideo_provider.dart';
import 'package:movieku/ui/home_page.dart';
import 'package:movieku/ui/movie_detail_page.dart';
import 'package:movieku/ui/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),),
          ChangeNotifierProvider<MoviePopularProvider>(
            create: (_) => MoviePopularProvider(apiService: ApiService()),),
          ChangeNotifierProvider<MovieNowProvider>(
            create: (_) => MovieNowProvider(apiService: ApiService()),),
          ChangeNotifierProvider<MovieUpcomingProvider>(
            create: (_) => MovieUpcomingProvider(apiService: ApiService()),),
          ChangeNotifierProvider<MovieTopProvider>(
            create: (_) => MovieTopProvider(apiService: ApiService()),),
          ChangeNotifierProvider<DetailMovieProvider>(
            create: (_) => DetailMovieProvider(apiService: ApiService()),),
          ChangeNotifierProvider<MovieVideoProvider>(
            create: (_) => MovieVideoProvider(apiService: ApiService()),),
        ],
        child: MaterialApp(
          title: 'MovieKu',
          theme: ThemeData(
            primaryColor: primaryColor,
            accentColor: secondaryColor,
            scaffoldBackgroundColor: Colors.white,
            textTheme: myTextTheme,
            appBarTheme: AppBarTheme(
              textTheme: myTextTheme.apply(bodyColor: Colors.black),
              elevation: 0,
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: primaryColor,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
          ),
          navigatorKey: navigatorKey,
          initialRoute: Splashscreen.routeName,
          routes: {
            Splashscreen.routeName: (context) => Splashscreen(),
            HomePage.routeName: (context) => HomePage(),
            // ExamplePage.routeName: (context) => ExamplePage(),
            MovieDetailPage.routeName: (context) => MovieDetailPage(
              id: ModalRoute.of(context).settings.arguments,
            ),
          },
        ),
      );

  }
}


