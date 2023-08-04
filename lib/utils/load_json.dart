import 'package:flutter/services.dart';

Future<String> getJson() {
  return rootBundle.loadString('video.json');
}
