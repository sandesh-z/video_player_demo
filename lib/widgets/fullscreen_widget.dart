import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'basic_overlay_widget.dart';

class VideoPlayerFullscreenWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoPlayerFullscreenWidget({
    required this.controller,
  });

  @override
  State<VideoPlayerFullscreenWidget> createState() =>
      _VideoPlayerFullscreenWidgetState();
}

class _VideoPlayerFullscreenWidgetState
    extends State<VideoPlayerFullscreenWidget> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) =>
      widget.controller != null && widget.controller.value.isInitialized
          ? Container(alignment: Alignment.topCenter, child: buildVideo())
          : const Center(child: CircularProgressIndicator());

  Widget buildVideo() => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          buildVideoPlayer(),
          BasicOverlayWidget(controller: widget.controller),
        ],
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: VideoPlayer(widget.controller),
        ),
      );

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = widget.controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
