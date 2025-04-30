import 'package:flutter/material.dart';
import 'package:flutterflix/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/movie.dart';
import '../../utils/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie>? movies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovies();
  }

  void getMovies(){
    APIService().getPopularMovies(pageNumber: 1).then((movieList){
      //value contient le résultat de la fonction getPopilarMoviesde APIService
      //qui retourne la liste de films populaires
      setState(() {
        movies = movieList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                color: kPrimaryColor,
              ),
              height: 500,
              child: movies == null ? const Center(): ClipRRect(
                borderRadius: BorderRadius.circular(10), // même que le Container
                child: Image.network(
                  movies![0].posterURL(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 34,),
            Text(
              "Tendances actuelles",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize:18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4,),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (BuildContext context, index){
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orange,
                    ),
                    margin: EdgeInsets.only(right: 7),
                    width: 106,
                    child: Center(
                      child: Text(index.toString()),
                    ),
                  );
                }
              ),
            ),
            SizedBox(height: 34,),
            Text(
              "Films actuellement au cinéma",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize:18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4,),
            SizedBox(
              height: 304,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, index){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.yellow,
                      ),
                      margin: EdgeInsets.only(right: 7),
                      width: 205,
                      child: Center(
                        child: Text(index.toString()),
                      ),
                    );
                  }
              ),
            ),
            SizedBox(height: 34,),
            Text(
              "Ils arrivent bientôt",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize:18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4,),
            SizedBox(
              height: 160,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, index){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.green,
                      ),
                      margin: EdgeInsets.only(right: 7),
                      width: 106,
                      child: Center(
                        child: Text(index.toString()),
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
