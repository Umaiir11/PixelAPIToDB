import 'dart:convert';

import '../CmModule/CmHttpCalls.dart';
import '../MVVM/Model/ApiModel/ModImage.dart';


class Sl_ImagesList {
  Future<List<Photo>> Fnc_Images() async {
    try {
      final lResponse = await cmHttpCalls().Fnc_HttpWeb('/v1/search?query=nature&per_page=200');
      if (lResponse.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(lResponse.body);
        return Fnc_JsonToModel(jsonResponse);
      } else {
        throw Exception('Failed to fetch images');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to fetch images');
    }
  }

  List<Photo> Fnc_JsonToModel(Map<String, dynamic> lJsonObject) {
    List<Photo> lListModImageList = [];

    List<dynamic> photos = lJsonObject['photos'];
    for (dynamic photoObject in photos) {
      Photo lModImage = Photo.fromJson(photoObject);
      lListModImageList.add(lModImage);
    }

    return lListModImageList;
  }
}
