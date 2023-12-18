import 'package:flutter/material.dart';
import 'package:movie_booking_app/core/constants/constants.dart';
import 'package:video_player/video_player.dart';

class MovieTrailerScreen extends StatefulWidget {
  final String videoUrl;
  const MovieTrailerScreen({super.key, required this.videoUrl});

  @override
  State<MovieTrailerScreen> createState() => _MovieTrailerScreenState();
}

class _MovieTrailerScreenState extends State<MovieTrailerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Column(
          children: [
            Row(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 32, left: 10),
                    child: GestureDetector(onTap: () {
                      Navigator.pop(context);
                    },child: Image.asset(Constants.backPath))),
                Container(
                    margin: const EdgeInsets.only(top: 32,left: 100),
                       alignment: Alignment.topRight,
                  child: Text(
                    'Trailer',
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = Constants.linearGradient),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 200),
              child: Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.colorTitle,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
