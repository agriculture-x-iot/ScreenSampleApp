import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,  //デバッグリボン非表示
    title: 'Navigation with Routes',
    routes: <String, WidgetBuilder>{
      '/': (_) => new Splash(),
      '/login': (_) => new Login(),
      '/home': (_) => new Home(),
      '/next': (_) => new Next(),
    },
  ));
}

// ---------
// スプラッシュ
// ---------
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    new Future.delayed(const Duration(seconds: 3))
        .then((value) => handleTimeout());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        // TODO: スプラッシュアニメーション
        child: const CircularProgressIndicator(),
      ),
    );
  }

  void handleTimeout() {
    // ログイン画面へ
    Navigator.of(context).pushReplacementNamed("/login");
  }
}

// ---------
// ログイン画面
// ---------
class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("AGRIMASTERにログイン"),
      ),
      body: new Center(
        child: new Form(
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'ユーザID',
                  ),
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  maxLength: 8,
                  decoration: new InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'パスワード',
                  ),
                ),
                const SizedBox(height: 24.0),
                new Center(
                  child: new RaisedButton(
                    child: const Text('ログイン'),
                    onPressed: () {
                      // TODO: ログイン処理
                      // ホーム画面へ
                      Navigator.of(context).pushReplacementNamed("/home");
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
                Center(
                  child: new RaisedButton(
                  child: const Text("新規登録"),
                  onPressed: () {
                    // 登録画面へ
                    Navigator.of(context).pushNamed("/home");
                  },
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------
// ホーム画面
// ---------
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("ホーム"),
      ),
      body: new Center(
        child: new RaisedButton(
          child: const Text("次の画面"),
          onPressed: () {
            // その他の画面へ
            Navigator.of(context).pushNamed("/next");
          },
        ),
      ),
    );
  }
}

// ---------
// その他画面
// ---------
class Next extends StatefulWidget {
  @override
  _NextState createState() => new _NextState();
}

class _NextState extends State<Next> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("ちんこ"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            const SizedBox(height: 24.0),
            new RaisedButton(
              child: const Text("次の画面"),
              onPressed: () {
                // その他の画面へ
                Navigator.of(context).pushNamed("/next");
              },
            ),
            const SizedBox(height: 24.0),
            new RaisedButton(
              child: const Text("ホーム"),
              onPressed: () {
                // ホーム画面へ戻る　
                Navigator.popUntil(context, ModalRoute.withName("/home"));
              },
            ),
            const SizedBox(height: 24.0),
            new RaisedButton(
              child: const Text("ログアウト"),
              onPressed: () {
                // 確認ダイアログ表示
                showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      content: const Text('ログアウトしてもよろしいですか？'),
                      actions: <Widget>[
                        new FlatButton(
                          child: const Text('いいえ'),
                          onPressed: () {
                            // 引数をfalseでダイアログ閉じる
                            Navigator.of(context).pop(false);
                          },
                        ),
                        new FlatButton(
                          child: const Text('はい'),
                          onPressed: () {
                            // 引数をtrueでダイアログ閉じる
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                ).then<void>((aBool) {
                  // ダイアログがYESで閉じられたら...
                  if (aBool) {
                    // 画面をすべて除いてスプラッシュを表示
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Splash()),
                        (_) => false);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}