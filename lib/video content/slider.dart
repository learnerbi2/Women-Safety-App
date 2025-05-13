import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:womensafteyhackfair/constants.dart';
import 'package:womensafteyhackfair/video%20content/videocrousal.dart';

class slider extends StatefulWidget {
  const slider({super.key});

  @override
  State<slider> createState() => _sliderState();
}

class _sliderState extends State<slider> {
 @override
Widget build(BuildContext context) {
  return CarouselSlider(
    
    items: videoIds.map((videoId) {
      return Builder(
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: YouTubePlayerWidget(videoId: videoId));
        },
      );
    }).toList(),
    options: CarouselOptions(
      height: 200.0,
      autoPlay: false,
      enlargeCenterPage: true,
    ),
  );
}
}