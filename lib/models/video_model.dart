class VideoItemModel {
  final String description;
  final List<String> sources;
  final String subtitle;
  final String thumb;
  final String title;
  const VideoItemModel({
    required this.description,
    required this.sources,
    required this.subtitle,
    required this.thumb,
    required this.title,
  });
  factory VideoItemModel.fromJson(Map<String, dynamic> json) => VideoItemModel(
      description: json['description'],
      sources: json['sources'].cast<String>(),
      subtitle: json['subtitle'],
      thumb: json['thumb'],
      title: json['title']);
}

class VideoModel {
  final List<VideoItemModel> videos;
  const VideoModel({
    required this.videos,
  });
  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
      videos: List<VideoItemModel>.from((json['videos'] as Iterable)
          .map((e) => VideoItemModel.fromJson(e as Map<String, dynamic>))));
}
