import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider(){
    return Container(
      width: 300.0,
      child: Slider.adaptive(
        activeColor: Colors.blue.shade800,
        inactiveColor: Colors.grey.shade400,
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value){
          seekToSec(value.toInt());
        }),
    );
  }
  void seekToSec(int sec){
    Duration newPos = Duration(seconds: sec);
    _controller.seekTo(newPos);
  }

  @override
  void initState() {
    // アプリを起動時に一度だけ実行
    super.initState();

    Future(() async {
      var url = Uri.parse('http://www.nhk.or.jp/rj/podcast/rss/english.xml');
      // print(await http.read(url));
      var response = await http.read(url);
      var document = XmlDocument.parse(response);
      final enclosures = document.findAllElements('enclosure');
      // print(enclosures);
      enclosures.first.getAttribute("url");
      print(enclosures.first.getAttribute("url"));
      _controller = VideoPlayerController.network(
          (enclosures.first.getAttribute("url")).toString());
      _controller.initialize().then((_) {
        setState(() {});
      });
    });
    // _controller.=(d){
    //   setState(() {
    //     musicLength = d;
    //   });
    // };
    // _controller. =(p){
    //   setState(() {
    //     position = p;
    //   });
    // };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green.shade800,
                    Colors.green.shade200,
                  ]),
            ),
            child: Padding(
                padding: EdgeInsets.only(
                  top: 48.0,
                ),
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "NHK WORLD RADIO JAPAN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text(
                          "This is the latest news in English from NHK WORLD RADIO JAPAN.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Center(
                        child:Container(
                          width: 280.0,
                          height: 280.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            image: DecorationImage(
                              image: AssetImage("assets/image.jpg"),
                            )),
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Center(
                        child: Text(
                          "English News",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Container(
                            //   width: 500.0,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Text(
                            //         "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                            //       ),
                            //       slider(),
                            //       Text(
                            //         "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}"
                            //       )
                            //     ],
                            //   ),
                            // ),
                            VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                            ),
                            _ProgressText(controller: _controller),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  iconSize: 62.0,
                                  color: Colors.blue,
                                  onPressed: () {
                                    if (!playing) {
                                      _controller.play();
                                      setState(() {
                                        playBtn = Icons.pause;
                                        playing = true;
                                      });
                                    } else {
                                      _controller.pause();
                                      setState(() {
                                        playBtn = Icons.play_arrow;
                                        playing = false;
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    playBtn,
                                  ),
                                ),
                                IconButton(
                                  iconSize: 62.0,
                                  color: Colors.red,
                                  onPressed: () {
                                    _controller
                                        .seekTo(Duration.zero)
                                        .then((_) => _controller.pause());
                                  },
                                  icon: Icon(Icons.refresh),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                    ]
                  )
                )
              )
            )
          );
  }
}

class _ProgressText extends StatefulWidget {
  final VideoPlayerController controller;

  const _ProgressText({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  __ProgressTextState createState() => __ProgressTextState();
}

class __ProgressTextState extends State<_ProgressText> {
  late VoidCallback _listener;

  __ProgressTextState() {
    _listener = () {
      setState(() {});
    };
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_listener);
  }

  @override
  void deactivate() {
    widget.controller.removeListener(_listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final String position = widget.controller.value.position.toString();
    final String duration = widget.controller.value.duration.toString();
    return Text('$position / $duration');
  }
}
