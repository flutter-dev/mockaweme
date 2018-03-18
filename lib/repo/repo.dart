import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
class Repo {

  static final Repo _repo = new Repo._internal();
  static const String _url = "http://p2c5nlwg0.bkt.clouddn.com/videolistv3.json";
  Repo._internal();

  factory Repo(){
    return _repo;
  }

  Future<List<VideoEntity>> fetchVideoList() async{
    Response response = await get(_url);
    List videos = json.decode(response.body)['videos'];
    List<VideoEntity> videoList = videos.map((f){
      return new VideoEntity(f['video_url'], f['video_thumb']);
    }).toList();
    return videoList;
  }

}

class VideoEntity{
  String videoUrl;
  String videoThumb;

  VideoEntity(this.videoUrl,this.videoThumb);
}