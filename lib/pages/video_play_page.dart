import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:mockaweme/repo/repo.dart';

class VideoPlayView extends StatefulWidget {
  final VideoEntity _videoEntity;

  VideoPlayView(this._videoEntity, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new VideoPlayViewState();
  }
}

class VideoPlayViewState extends State<VideoPlayView> {
  VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = new VideoPlayerController(widget._videoEntity.videoUrl)
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..setLooping(true)
      ..initialize();
  }

  play() {
    if (!_controller.value.isPlaying) {
      _controller.play();
    }
  }

  pause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_isPlaying) {
      child = new VideoPlayer(_controller);
    } else {
      child = new Image.network(
        widget._videoEntity.videoThumb,
        fit: BoxFit.cover,
      );
    }
    return new Stack(
      children: <Widget>[child],
    );
  }
}
