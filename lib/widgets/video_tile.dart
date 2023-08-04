import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final bool isSelected;
  final String imagePath, title, subtitle;
  const VideoTile(
      {super.key,
      required this.isSelected,
      required this.imagePath,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      color: isSelected
          ? Colors.white.withOpacity(.1)
          : Colors.black.withOpacity(.7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 120,
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(12)),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white.withOpacity(.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
