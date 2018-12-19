import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = new WordPair.random();
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        body: new Center(
          //child: new Text('Hello World'),
          // child: new Text(wordPair.asPascalCase),
          child: new RandomWords(),
        ),
      ),
      theme: new ThemeData(
        primaryColor: Colors.indigo,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggrstions = new List<WordPair>();

  final Set<WordPair> _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // final WordPair wordPair = new WordPair.random();
    // return new Text(wordPair.asLowerCase);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  //生成导航条
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            }
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
    
  }

  Widget _buildRow(WordPair pair) {
    final alreadtSaved = _saved.contains(pair);
    return new ListTile (
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont
      ),
      trailing: new Icon(
        alreadtSaved ? Icons.favorite : Icons.favorite_border,
        color: alreadtSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
                  if(alreadtSaved) {
                    _saved.remove(pair);
                  } else {
                    _saved.add(pair);
                  }
                });
      },
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),

      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;

        //如果封底了，那么就在生成10个WordPair
        if(index >= _suggrstions.length) {
          _suggrstions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggrstions[index]);
      }
    );
  }


}