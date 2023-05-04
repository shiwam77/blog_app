//@dart=2.9

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helpers/helper.dart';
import '../models/blog_model.dart';
import '../models/home.dart';

Future<Stream<Home>> getBlog() async {
  Uri uri = Helper.getUri('api/blog-list');

  Map<String, dynamic> _queryParams = {};
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(
      http.Request(
        'get',
        uri,
      ),
    );
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) => Home.fromJSON(data));
  } catch (e) {
    return Stream.value(new Home.fromJSON({}));
  }
}

Future<Stream<IgBlog>> getCategory() async {
  Uri uri = Helper.getUri('api/blog-category-list');
  Map<String, dynamic> _queryParams = {};
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data as Map<String, dynamic>))
        .expand((data) => (data as List))
        .map((data) => IgBlog.fromJson(json.decode(data)));
  } catch (e) {
    return Stream.value(new IgBlog());
  }
}
