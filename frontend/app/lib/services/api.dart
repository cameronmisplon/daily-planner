import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:universal_io/io.dart';

class Api {
  final String apiUrl;

  final apiHeaders = <String, String>{
    'Content-Type': 'application/json; charset=utf-8',
    'ngrok-skip-browser-warning': 'skipbrowserwarning'
  };

  Api(this.apiUrl);

  Future<dynamic> post(http.Client client, String url, dynamic body) async {
    try {
      var response;
      response = await client.post(Uri.parse(this.apiUrl + url),
          headers: apiHeaders, body: body);
      checkResponse(response);
      return response.body;
    } on SocketException {
      rethrow;
    }
  }

  Future<dynamic> get(http.Client client, String url,
      {bool enableCache = false}) async {
    try {
      var response;
      FileInfo? fileInfo;
      if (enableCache) {
        fileInfo = await DefaultCacheManager().getFileFromCache(url);
      }
      if (fileInfo == null || fileInfo.validTill.isBefore(Jiffy().dateTime)) {
        response =
        await client.get(Uri.parse(this.apiUrl + url), headers: apiHeaders);
        checkResponse(response);
        if (enableCache) {
          List<int> list = response.body.codeUnits;
          Uint8List fileBytes = Uint8List.fromList(list);
          await DefaultCacheManager()
              .putFile(url, fileBytes, maxAge: Duration(minutes: 5));
        }
        response = response.body;
      } else {
        response = fileInfo.file.readAsStringSync();
      }
      return response;
    } on SocketException {
      rethrow;
    }
  }

  Future<dynamic> delete(http.Client client, String url, dynamic body) async {
    var _request = new http.Request('delete', Uri.parse(this.apiUrl + url));
    _request.headers.addAll(apiHeaders);
    _request.body = body;

    try {
      final response = await client.send(_request);
      if (response.statusCode != 200) {
      }
      return response;
    } on SocketException {
      rethrow;
    }
  }

  void checkResponse(http.Response response) {
    if (response.statusCode == 500) {
    }
  }
}