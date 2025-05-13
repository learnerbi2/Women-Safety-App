import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerWidget extends StatelessWidget {
  final String videoId;

  const YouTubePlayerWidget({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideThumbnail: false,
        showLiveFullscreenButton: true,
      ),
    );

    return YoutubePlayer(
      aspectRatio: 16/9,
      controller: _controller,
      progressColors: ProgressBarColors(
        backgroundColor: Colors.red,
        handleColor: Colors.amber,
        
        
      ),
      showVideoProgressIndicator: true,
    );
  }

}
