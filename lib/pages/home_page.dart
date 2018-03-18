import 'package:flutter/material.dart';
import 'package:mockaweme/repo/repo.dart';
import 'package:mockaweme/pages/video_play_page.dart';
import 'package:mockaweme/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  GlobalKey<_VerticalVideoPageState> _verticalVideoPageStateKey =
      new GlobalKey();
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return new PageView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int position) {
        if (position == 0) {
          return new _VerticalVideoPage(
            key: _verticalVideoPageStateKey,
          );
        }
        if (position == 1) {
          return new ProfilePage();
        }
      },
      controller: _pageController,
      onPageChanged: (int position) {
        if (position == 1) {
          _verticalVideoPageStateKey.currentState.stop();
        }
      },
    );
  }
}

class _VerticalVideoPage extends StatefulWidget {


  _VerticalVideoPage({Key key}) : super(key: key);

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
    print('init vertical video page   ,current page : $_currentPage');
    _pageController = new PageController(initialPage: _currentPage);
    _repo.fetchVideoList().then((onValue) {
      setState(() {
        _videoList = onValue;
        _videoList.forEach((f) {
          videoGlobalKeys.add(new GlobalKey());
        });
      });
    });
  }

  stop() {
    for (int i = 0; i < videoGlobalKeys.length; i++) {
      VideoPlayViewState videoPalyViewState = videoGlobalKeys[i].currentState;
      if (videoPalyViewState != null) videoPalyViewState.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(' build vertical video page');
    return new Stack(
      children: <Widget>[
        new NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification) {
            if (scrollNotification is ScrollEndNotification) {
              if (_pageController.page.toInt() != _pageController.page) return;
              if (_currentPage == _pageController.page.toInt()) return;
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
