import 'dart:convert';

import 'package:walplash/model/imagemodel.dart';
import 'package:http/http.dart' as http;

class Presenter {
  List<ImageModel>? imageModel;
  Future<List<ImageModel>?> fetchUser() async {
    Uri uri = Uri.parse(
        "https://api.unsplash.com/photos/?client_id=3MdHdkeKdwAyjtLlkXRXeSlFLaMWJsRIY0ArOvr-EwY&per_page=80");
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
}
