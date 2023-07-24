import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:walplash/model/imagemodel.dart';
import 'package:http/http.dart' as http;
import 'package:walplash/services/notif_service.dart';

class Presenter {
  List<ImageModel>? imageModel;
  Future<List<ImageModel>?> fetchUser() async {
    Uri uri = Uri.parse(
        "https://api.unsplash.com/photos/?client_id=qd9wbvhCrChT1o51WzyMGvYkPb0lorhJP3EAEOs_Y6M&per_page=30&orientation=portrait");
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
        'https://api.unsplash.com/search/photos?query=${category.toString()}%20and%20culture%20&client_id=qd9wbvhCrChT1o51WzyMGvYkPb0lorhJP3EAEOs_Y6M&per_page=30&orientation=portrait&order_by=popular');
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
        'https://api.unsplash.com/search/photos?query=${category.toString()}%20and%20culture%20&client_id=qd9wbvhCrChT1o51WzyMGvYkPb0lorhJP3EAEOs_Y6M&per_page=30&orientation=portrait');
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

  Future<void> saveImage(String url, BuildContext context) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final response = await http.get(Uri.parse(url));
      final dir = await path_provider.getTemporaryDirectory();

      var filename = '${dir.path}/image.png';

      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final filepath = await FlutterFileDialog.saveFile(params: params);

      if (filepath != null) {
        message = 'Succes Download Image';
        // Add message notification
        NotificationService().showNotification(
            title: 'Download Image', body: 'Succes Download Image');
      }
    } catch (e) {
      message = '${e.toString()}';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
