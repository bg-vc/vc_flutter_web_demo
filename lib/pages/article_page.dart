import 'dart:ui';


import 'dart:html' as html;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';
import 'package:vc_flutter_web_demo/config/platform.dart';
import 'package:vc_flutter_web_demo/widgets/common_layout.dart';
import '../json/article_item_bean.dart';
import '../json/article_json_bean.dart';
import '../logic/article_page_logic.dart';


class ArticlePage extends StatefulWidget {
  final ArticleItemBean bean;

  const ArticlePage({Key key, @required this.bean}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final logic = ArticlePageLogic();
  String data = '';

  @override
  void initState() {
    ArticleJson.loadArticles().then((value) {
      final String content = value[widget.bean.articleName];
      List<String> splits = content.split('---');
      if (splits.length >= 3) {
        data = splits[2];
      } else {
        data = content;
      }
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final width = size.width;
    final height = size.height;
    final isNotMobile = !PlatformDetector().isMobile();

    return CommonLayout(
      pageType: PageType.article,
        child: Container(
            alignment: Alignment.center,
            margin: isNotMobile
                ? const EdgeInsets.all(0)
                : const EdgeInsets.all(20),
            child: data.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overScroll) {
                      overScroll.disallowGlow();
                      return true;
                    },
                    child: Container(
                      margin: EdgeInsets.only(top:isNotMobile ? 20 : 10),
                      child: SingleChildScrollView(
                        child: Container(
                          width: isNotMobile ? width / 2 : width,
                          margin: EdgeInsets.only(top:isNotMobile ? 20 : 10, bottom: isNotMobile ? 100 : 20),
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(widget.bean.articleName,
                                        style: const TextStyle(
                                          fontFamily: 'huawen_kt',
                                          fontSize: 40,
                                        )),
                                    alignment: Alignment.center,
                                  ),
                                  MarkdownBody(
                                    fitContent: false,
                                    data: data,
                                    selectable: false,
                                    onTapLink: (link) {
                                      html.window.open(link, link);
                                    },
                                    styleSheetTheme:
                                        MarkdownStyleSheetBaseTheme.cupertino,
                                    imageBuilder: (Uri url) {
                                      return Container(
                                        margin: const EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: height / 3 * 2,
                                              maxWidth: width / 3 * 2),
                                          child: GestureDetector(
                                            onTap: () {
                                              html.window.open('$url', "image");
                                            },
                                            child: Card(
                                              child: Image.network(
                                                "$url",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    styleSheet: MarkdownStyleSheet(
                                        codeblockPadding:
                                            const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                        p: TextStyle(
                                          color:
                                              Theme.of(context).textTheme.subtitle2.color,
                                          fontFamily: "",
                                        ),
                                        h1: TextStyle(fontSize: 25, color: Theme.of(context).textTheme.bodyText1.color),
                                        h2: TextStyle(fontSize: 21, color: Theme.of(context).textTheme.bodyText1.color),
                                        h3: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyText1.color),
                                        h4: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyText1.color),

                                        blockSpacing: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
      );
  }
}
