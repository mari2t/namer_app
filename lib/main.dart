import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MyApp で定義したアプリの実行を Flutter に指示。
void main() {
  runApp(MyApp());
}

// ウィジェットは、すべての Flutter アプリを作成する際の元になる要素。
// このアプリ自体がウィジェット。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// MyAppState クラスでアプリの状態を定義
// ChangeNotifier 自身の変更に関する通知を行うことができる
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  // ↓ Add this.
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

//  build() 周囲の状況が変化するたびに自動的に呼び出される
// watch アプリの現在の状態に対する変更を追跡
// Column 任意の数の子を従え、それらを上から下へ一列に配置
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'), // ← Example change.
          Text(appState.current.asLowerCase),
          // ↓ Add this.
          ElevatedButton(
            onPressed: () {
              appState.getNext(); // ← This instead of print().
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
