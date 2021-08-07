# podcast2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


<!-- インスタンスを作成しています。

FlutterSound flutterSound= new FlutterSound();
リスナーでレコーダーを起動します。

String path= await flutterSound.startRecorder(null);
print('startRecorder: $path');
_recorderSubscription= flutterSound.onRecorderStateChanged.listen((e) {
  DateTime date= new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
  String txt= DateFormat('mm:ss:SS', 'en_US').format(date);
});
レコーダーを停止する

String result= await flutterSound.stopRecorder();
print('stopRecorder: $result');
if (_recorderSubscription != null) {
    _recorderSubscription.cancel();
    _recorderSubscription= null;
}
プレーヤーを開始します

String path= await flutterSound.startPlayer(null);
print('startPlayer: $path');
_playerSubscription= flutterSound.onPlayerStateChanged.listen((e) {
    if (e != null) {
        DateTime date= new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        String txt= DateFormat('mm:ss:SS', 'en_US').format(date);
        this.setState(() {
            this._isPlaying= true;
            this._playerTxt= txt.substring(0, 8);
        });
    }
}); -->

