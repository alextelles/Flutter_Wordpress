import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class DetalheDoPost extends StatelessWidget {
  const DetalheDoPost({Key key}) : super(key: key);

  static const routeName = 'datalhe';

  @override
  Widget build(BuildContext context) {
    Map post = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(title: Text(post['title']['rendered'])),
      body: ListView(
        children: <Widget>[
          FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(post["_embedded"]["wp:featuredmedia"][0]
                        ["media_details"]["sizes"]["fotos"] //Tamanho da imagem
                    ["source_url"] //url da image
                ),
          ),
          Text(
            post['title']['rendered'],
            style: TextStyle(fontSize: 16),
          ),
          HtmlWidget(post['content']['rendered'])
        ],
      ),
    );
  }
}
