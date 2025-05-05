import 'package:flutter/material.dart';
import 'package:flutterflix/utils/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String? movieId;
  const VideoPlayer({super.key, required this.movieId});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movieId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: true,
        hideThumbnail: true,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null
        ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
        : YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: kPrimaryColor,
          progressColors: ProgressBarColors(
            playedColor: kPrimaryColor,
            handleColor: kPrimaryColor, // Couleur de la barre de progression
          ),
          onReady: () {
            // Callback lorsque le lecteur est prêt
            _controller!.addListener(() {
              if (_controller!.value.hasError) {
                print(
                  'Erreur de lecture vidéo : ${_controller!.value.errorCode}',
                );
              }
            });
          },
          onEnded: (YoutubeMetaData meta) {
            // Callback lorsque la vidéo se termine
            // _controller!.seekTo(const Duration(seconds: 0));//Redémarre la vidéo
            _controller!.play(); // Joue la vidéo à nouveau
            _controller!.pause(); // Met la vidéo en pause
          },
        );
  }
}
