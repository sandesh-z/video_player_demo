import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_demo/models/video_model.dart';
import 'package:video_player_demo/widgets/bottom_controls.dart';
import 'package:video_player_demo/widgets/controls_widget.dart';
import 'package:video_player_demo/widgets/video_tile.dart';

VideoPlayerController? _controller;
int i = 0;
List<GlobalKey<State<StatefulWidget>>> list = [];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoModel videoModel = const VideoModel(videos: []);

  bool isVisible = true;
  bool hasMuted = false;
  bool isFullScreen = false;
  final dataKey1 = GlobalKey(),
      dataKey2 = GlobalKey(),
      dataKey3 = GlobalKey(),
      dataKey4 = GlobalKey(),
      dataKey5 = GlobalKey(),
      dataKey6 = GlobalKey(),
      dataKey7 = GlobalKey(),
      dataKey8 = GlobalKey(),
      dataKey9 = GlobalKey(),
      dataKey10 = GlobalKey(),
      dataKey11 = GlobalKey(),
      dataKey12 = GlobalKey(),
      dataKey13 = GlobalKey();

  void _initController(String link) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(link))
      ..initialize().then((_) {
        setState(() {});
        _controller?.play();
      });
  }

  Future<void> _startVideoPlayer(String link) async {
    if (_controller == null) {
      _initController(link);
    } else {
      final oldController = _controller;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController?.dispose();
        _initController(link);
      });
      setState(() {
        _controller = null;
        hideControls();
      });
    }
  }

  void hideControls() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isVisible = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      videoModel = VideoModel.fromJson(jsonDecode(await getJson()));
      _startVideoPlayer(videoModel.videos.first.sources.first);
    });
    list = [
      dataKey1,
      dataKey2,
      dataKey3,
      dataKey4,
      dataKey5,
      dataKey6,
      dataKey7,
      dataKey8,
      dataKey9,
      dataKey10,
      dataKey11,
      dataKey12,
      dataKey13
    ];
    hideControls();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.pause();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.1),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.8),
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                isVisible = true;
                if (_controller?.value.isPlaying ?? false) {
                  _controller?.pause();
                }
              });
            },
            child: SizedBox(
                height: 200,
                width: double.infinity,
                child: _controller?.value.isInitialized ?? false
                    ? Stack(
                        children: [
                          VideoPlayer(_controller!),
                          Center(
                            child: Visibility(
                              visible: isVisible,
                              child: ControlsRow(
                                controller: _controller,
                                index: i,
                                videosLength: videoModel.videos.length,
                                onPreviousPressed: () {
                                  if (i == 0) {
                                    null;
                                    return;
                                  }
                                  _controller?.pause();
                                  setState(() {
                                    i = i - 1;
                                    hasMuted = false;
                                  });
                                  _startVideoPlayer(
                                      videoModel.videos[i].sources.first);
                                  scrollToSelectedWidget();
                                },
                                onPlayPausePressed: () {
                                  setState(() {
                                    if (_controller?.value.isPlaying ?? false) {
                                      _controller?.pause();
                                    } else {
                                      hideControls();
                                      _controller?.play();
                                    }
                                  });
                                },
                                onNextPressed: () {
                                  if (videoModel.videos.length - 1 == i) {
                                    null;
                                    return;
                                  }
                                  _controller?.pause();
                                  setState(() {
                                    i = i + 1;
                                    hasMuted = false;
                                  });
                                  _startVideoPlayer(
                                      videoModel.videos[i].sources.first);
                                  scrollToSelectedWidget();
                                },
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: BottomVideoControls(
                                hasMuted: hasMuted,
                                controller: _controller!,
                                onVolumeBtnTap: () {
                                  setState(() {
                                    hasMuted
                                        ? _controller?.setVolume(1.0)
                                        : _controller?.setVolume(0.0);
                                    hasMuted = !hasMuted;
                                  });
                                },
                              ))
                        ],
                      )
                    : Container(
                        color: Colors.black,
                        child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child:
                                CircularProgressIndicator(color: Colors.red)),
                      )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: videoModel.videos.length,
              itemBuilder: (context, index) {
                return InkWell(
                    key: list[index],
                    onTap: () {
                      setState(() {
                        i = index;
                      });
                      _controller?.pause();
                      _startVideoPlayer(videoModel.videos[index].sources.first);
                      scrollToSelectedWidget();
                    },
                    child: VideoTile(
                        isSelected: i == index ? true : false,
                        imagePath: videoModel.videos[index].thumb,
                        title: videoModel.videos[index].title,
                        subtitle: videoModel.videos[index].subtitle));
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<String> getJson() {
  return rootBundle.loadString('assets/video_list.json');
}

String getVideoPosition() {
  var duration = Duration(
      milliseconds: _controller?.value.position.inMilliseconds.round() ?? 0);
  return [duration.inMinutes, duration.inSeconds]
      .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
      .join(':');
}

void scrollToSelectedWidget() {
  if (list[i].currentContext != null) {
    Scrollable.ensureVisible(list[i].currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.5);
  }
}
