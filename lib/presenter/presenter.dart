import 'dart:convert';

import 'package:walplash/model/imagemodel.dart';
import 'package:http/http.dart' as http;

class Presenter {
  List<ImageModel>? imageModel;
  Future<List<ImageModel>?> fetchUser() async {
    Uri uri = Uri.parse(
        "https://api.unsplash.com/photos/?client_id=3MdHdkeKdwAyjtLlkXRXeSlFLaMWJsRIY0ArOvr-EwY&per_page=30&orientation=portrait");
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      print('Failed');
      return null;
    } else {
      List<dynamic> data = jsonDecode(response.body);
      // data.forEach((element) {
      //   print(element);
      // });
      return imageModel = data
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<List<ImageModel>?> categoryImage(String category) async {
    Uri uri = Uri.parse(
        'https://api.unsplash.com/search/photos?query=${category.toString()}%20and%20culture%20&client_id=3MdHdkeKdwAyjtLlkXRXeSlFLaMWJsRIY0ArOvr-EwY&per_page=30&orientation=portrait');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      return null;
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> results =
          data['results']; // Ambil bagian 'results' dari map
      print(results);
      List<ImageModel> imageList = results
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return imageList;
    }
  }

  Future<List<ImageModel>?> searchImage(String category) async {
    Uri uri = Uri.parse(
        'https://api.unsplash.com/search/photos?query=${category.toString()}%20and%20culture%20&client_id=3MdHdkeKdwAyjtLlkXRXeSlFLaMWJsRIY0ArOvr-EwY&per_page=30&orientation=portrait');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      return null;
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> results =
          data['results']; // Ambil bagian 'results' dari map
      print('result search : ${results}');
      List<ImageModel> imageList = results
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return imageList;
    }
  }
}
