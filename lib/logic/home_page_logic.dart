import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vc_flutter_web_demo/json/article_item_bean.dart';

class HomePageLogic {
  Future<String> _getConfigFile(String fileName) async {
    String file = "assets/config/$fileName";
    String json = await rootBundle.loadString(file);
    return json;
  }

  Future<List<ArticleItemBean>> getArticleData(String fileName) async {
    String configJson = await _getConfigFile(fileName);
    List<ArticleItemBean> data = ArticleItemBean.fromMapList(jsonDecode(configJson));
    return data;
  }
}
