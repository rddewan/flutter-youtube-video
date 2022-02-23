import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SingleVideoPlayer extends StatefulWidget {
  const SingleVideoPlayer({Key? key}) : super(key: key);

  @override
  State<SingleVideoPlayer> createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
  late YoutubePlayerController _controller;  
  late YoutubePlayerController _modelController; 
  bool _muted = true;
  bool _isPlayerReady = false;
  
  @override
  void initState() {    
    super.initState();
     _controller = YoutubePlayerController(
       initialVideoId: 'QKG4v0oKXRw',
       flags: const YoutubePlayerFlags(
         hideControls: false,         
         autoPlay: false,
         mute: true,
         forceHD: true
       )
     ); 
      _modelController = YoutubePlayerController(
       initialVideoId: 'uT_GcOGEFsk',
       flags: const YoutubePlayerFlags(
         hideControls: true,         
         autoPlay: true,
         mute: false,
         forceHD: true
       )
     );    

  } 

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () => SystemChrome.setPreferredOrientations(DeviceOrientation.values),
      player: _youtubePlayer(), 
      builder: (context,player) => Scaffold(
        appBar: AppBar(
          title: const Text('YouTube Video'),
          centerTitle: true,
        ),
        body: Column(
        children: [
          player,
          const SizedBox(height: 16.0),         
          OutlinedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.black,
                context: context, 
                isDismissible: false,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)                   
                  )
                ),
                builder: (context) => buildModalBottomSheet()
              );
            },           
            icon: const Icon(Icons.next_plan), 
            label: const Text('Open Dialog')
          )
      ],
        ),
    ),
    );
  }

  YoutubePlayer _youtubePlayer() {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
      topActions: [
        IconButton(
        icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
        color: Colors.white,           
        onPressed: () {
          if (_isPlayerReady) {
            if (_muted) {
              _controller.unMute();
            }
            else {
              _controller.mute();
            }
          }
          setState(() {
            _muted = !_muted;
          });
        },
      ),
      ],
      onReady: () {
        setState(() {
          _isPlayerReady = true;
        });
      },
    );
  }

  YoutubePlayer _modelYoutubePlayer() {
    return YoutubePlayer(
      controller: _modelController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
      onReady: () {
        setState(() {
          _isPlayerReady = true;
        });
      },
    );
  }

  Widget buildModalBottomSheet() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [                           
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _modelYoutubePlayer(),
          )   
        ],    
      ),
    );
  }
}