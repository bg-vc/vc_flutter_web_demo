import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class ArticleJson {

  factory ArticleJson() {
    return _singleton;
  }

  ArticleJson._internal();

  static final ArticleJson _singleton = ArticleJson._internal();

  static dynamic articles;

  static bool _isLoading = false;

  static Future<dynamic> loadArticles() async{
    if(articles != null) return articles;
    if(!_isLoading){
      _isLoading = true;
      final Response response = await http.get(
        'https://oldchen-blog-1256696029.cos.ap-guangzhou.myqcloud.com/blog_config/config_all.json',
        headers: {'Access-Control-Allow-Origin':''},
      );
      _isLoading = false;
      return json.decode(utf8.decode(response.bodyBytes));
    }
//    String json = await rootBundle.loadString('assets/config/config_all.json');
//    articles = jsonDecode(json);
//    return articles;

  }
}