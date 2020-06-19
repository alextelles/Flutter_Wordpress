import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:testewp/screens/posts.dart';

import 'apis/wordpress.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vitor Corrêa',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (BuildContext context) => HomePage(),
        DetalheDoPost.routeName: (BuildContext context) => DetalheDoPost()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vitor Corrêa'),
      ),
      body: FutureBuilder(
        future: teste(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var posts = snapshot.data;
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  Map post = snapshot.data[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(DetalheDoPost.routeName, arguments: post),
                    child: Column(
                      children: <Widget>[
                        FadeInImage(
                          placeholder: AssetImage('assets/loading.gif'),
                          image: NetworkImage(post["_embedded"]
                                              ["wp:featuredmedia"][0]
                                          ["media_details"]["sizes"]
                                      ["fotos"] //Tamanho da imagem
                                  ["source_url"] //url da image
                              ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Text(
                                post['title']['rendered'],
                                style: TextStyle(fontSize: 18),
                              ),
                              HtmlWidget(post['content']['rendered'])
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
