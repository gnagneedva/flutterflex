import 'package:flutter/material.dart';
import 'package:flutterflix/repositories/data_repository.dart';
import 'package:flutterflix/ui/screens/home_screen.dart';
import 'package:flutterflix/utils/constant.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    final dataProvider= Provider.of<DataRepository>(context, listen: false);
    await dataProvider.initData(); // Appel de la méthode initData() du DataRepository
    //initialisation des données
    // Une fois les données initialisées, naviguer vers l'écran d'accueil
    Navigator.pushReplacement(//Pour remplacer l'écran de chargement par l'écran d'accueil
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/NETFLIX.png', width: 200, height: 200),
            LoadingAnimationWidget.stretchedDots(
              color: kPrimaryColor,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
