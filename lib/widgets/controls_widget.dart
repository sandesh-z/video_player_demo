import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:video_player_demo/widgets/transparent_container.dart';

class ControlsRow extends StatefulWidget {
  final int index, videosLength;
  final VideoPlayerController? controller;
  final void Function()? onPreviousPressed, onPlayPausePressed, onNextPressed;

  const ControlsRow(
      {super.key,
      required this.index,
      required this.controller,
      this.onPreviousPressed,
      this.onPlayPausePressed,
      this.onNextPressed,
      required this.videosLength});

  @override
  State<ControlsRow> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ControlsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: widget.onPreviousPressed,
          child: TransparentContainer(
            child: Icon(
              Icons.skip_previous,
              color: (widget.index == 0) ? Colors.grey : Colors.white,
              size: 28,
            ),
          ),
        ),
        InkWell(
          onTap: widget.onPlayPausePressed,
          child: TransparentContainer(
            child: Icon(
              widget.controller?.value.isPlaying == true
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
              size: 48,
            ),
          ),
        ),
        InkWell(
          onTap: widget.onNextPressed,
          child: TransparentContainer(
            child: Icon(
              Icons.skip_next,
              color: (widget.videosLength - 1 == widget.index)
                  ? Colors.grey
                  : Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
