import 'package:flutter/material.dart';
import 'package:mockaweme/repo/repo.dart';
import 'package:mockaweme/pages/video_play_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new PageView(
      children: <Widget>[new _VerticalVideoPage()],
    );
  }
}

class _VerticalVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _VerticalVideoPageState();
  }
}

class _VerticalVideoPageState extends State<_VerticalVideoPage> {
  Repo _repo = new Repo();
  List<VideoEntity> _videoList = [];
  List<GlobalKey<VideoPlayViewState>> videoGlobalKeys = [];
  PageController _pageController;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();

    _pageController = new PageController();
    _repo.fetchVideoList().then((onValue) {
      print("================${onValue.length}");
      setState(() {
        _videoList = onValue;
        _videoList.forEach((f) {
          videoGlobalKeys.add(new GlobalKey());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification){
            if(scrollNotification is ScrollEndNotification){
              if(_pageController.page.toInt() != _pageController.page) return;
              if(_currentPage == _pageController.page.toInt()) return;
              for (int i = 0; i < videoGlobalKeys.length; i++) {
                VideoPlayViewState videoPalyViewState =
                    videoGlobalKeys[i].currentState;
                if (videoPalyViewState != null) videoPalyViewState.pause();
              }
              videoGlobalKeys[_pageController.page.toInt()].currentState.play();
              _currentPage = _pageController.page.toInt();
            }
          },
          child: new PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return new VideoPlayView(
                _videoList[index],
                key: videoGlobalKeys[index],
              );
            },
            itemCount: _videoList.length,
          ),
        ),
      ],
    );
  }
}
