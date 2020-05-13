import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyDBUCZyecdeZCdnzL2YI1r6oJICmYo0Edg";
const ID_CANAL = "UCMpWpGXG8tlWA6Xban2m6oA";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> pesquisar(String pesquisa) async {

    http.Response response = await http.get(
      URL_BASE + "search"
          "?part=snippet"
          "&type=video"
          "&maxResults=20"
          "&order=date"
          "&key=$CHAVE_YOUTUBE_API"
          "&channelId=$ID_CANAL"
          "&q=$pesquisa"
    );

    if (response.statusCode == 200){

      Map<String, dynamic> dadosJson = json.decode(response.body);

      //converter map para o tipo Video
      List<Video> videos = dadosJson["items"].map<Video>(
          (map){
            return Video.fromJson(map);
            //return Video.converterJson(map);
          }
      ).toList();

      return videos;

      /*
      for (var video in dadosJson["items"]){
        print("Resultado: " + video.toString());
      }*/

      //print("resultado: " + dadosJson["items"].toString());

    }else{

    }

  }

}