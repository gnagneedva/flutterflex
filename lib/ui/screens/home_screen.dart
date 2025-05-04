import 'package:flutter/material.dart';
import 'package:flutterflix/repositories/data_repository.dart';
import 'package:flutterflix/ui/widgets/movie_card.dart';
import 'package:flutterflix/ui/widgets/movie_category.dart';
import 'package:provider/provider.dart';
import '../../utils/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackColor,
      appBar: AppBar(
        backgroundColor: kBackColor,
        leading: Image.asset('assets/images/N.png'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: kCardColor,
              ),
              height: 500,
              child: MovieCard(
                movie: dataProvider.popularMoviesList.first,
              ), // Affiche le premier film de la liste des films populaires
            ),

            MovieCategory(
              label: 'Tendances actuelles',
              imageHeight: 160,
              imageWidth: 106,
              movieList: dataProvider.popularMoviesList,
              callback: dataProvider.getPopularMovies,
            ),
            MovieCategory(
              label: 'Films actuellement au cinéma',
              movieList: dataProvider.nowPlayingList,
              imageHeight: 304,
              imageWidth: 205,
              callback: dataProvider.getNowPlaying,
            ),

            // MovieCategory(
            //   label: 'Ils arrivent bientôt',
            //   movieList: dataProvider.popularMoviesList,
            //   imageHeight: 160,
            //   imageWidth: 106,
            // ),
          ],
        ),
      ),
    );
  }
}
