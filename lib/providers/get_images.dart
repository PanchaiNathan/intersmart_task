import 'package:Interview/models/imagemodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Interview/providers/keys.dart';

class GetImages {
  Future<String> getKey() async {
    String apiKey = unsplashApiClientID;
    return apiKey;
  }

  Future<List<ImageModel>> getCollectionImages(
      String id, int page, int perPage) async {
    String apiKey = await getKey();
    final response = await http.get(Uri.parse(
        'https://api.unsplash.com/collections/$id/photos?client_id=$apiKey&page=$page&per_page=$perPage'));

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      List<ImageModel> images =
          result.map((e) => ImageModel.fromJson(e)).toList();
      return images;
    } else {
      throw "Can't get images";
    }
  }

  Future<List<ImageModel>> searchImage({required query}) async {
    String apiKey = await getKey();
    final response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos/random/?client_id=$apiKey&count=30&query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      List<ImageModel> images =
          result.map((e) => ImageModel.fromJson(e)).toList();
      return images;
    } else {
      throw "Can't get images";
    }
  }
}
