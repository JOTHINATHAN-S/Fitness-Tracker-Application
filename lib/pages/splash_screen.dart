import 'package:fitness_tracker_app/constants/theme.dart';
import 'package:fitness_tracker_app/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScr extends StatefulWidget {
  const SplashScr({super.key});

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {
  //VIDEO CONTROLLER
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.asset('assets/splash_screen_fitness_tracker.gif')
          ..initialize().then((_) {
            setState(() {});
          })
          ..setVolume(0.0);
    _playVideo();
  }

  void _playVideo() async {
    _controller.play();
    await Future.delayed(const Duration(seconds: 5));
    // Navigate to the next screen after the video is played
    Get.to(welcomepage()); // Uncomment and set the routeName accordingly
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fgreydark,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(), // Show a loader until the video is initialized
      ),
    );
  }
}
