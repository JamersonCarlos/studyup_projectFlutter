// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Anotation {
  final String envio;
  final String title;
  final String description;
  final List<String> videos;
  final List<String> imagens;
  final List<String> audios;
  final List<String> links;
  Anotation({
    required this.envio,
    required this.title,
    required this.description,
    required this.videos,
    required this.imagens,
    required this.audios,
    required this.links,
  });

  Anotation copyWith(
      {String? envio,
      String? title,
      String? description,
      List<String>? videos,
      List<String>? imagens,
      List<String>? audios,
      List<String>? links}) {
    return Anotation(
      envio: envio ?? this.envio,
      title: title ?? this.title,
      description: description ?? this.description,
      videos: videos ?? this.videos,
      imagens: imagens ?? this.imagens,
      audios: audios ?? this.audios,
      links: links ?? this.links,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'envio': envio,
      'title': title,
      'description': description,
      'videos': videos,
      'imagens': imagens,
      'audios': audios,
      'links': links
    };
  }

  factory Anotation.fromMap(Map<String, dynamic> map) {
    return Anotation(
        envio: map['envio'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        videos: map['videos'] as List<String>,
        imagens: map['imagens'] as List<String>,
        audios: map['audios'] as List<String>,
        links: map['links'] as List<String>);
  }

  String toJson() => json.encode(toMap());

  factory Anotation.fromJson(String source) =>
      Anotation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Anotation(envio: $envio, description: $description, videos: $videos, imagens: $imagens, audios: $audios)';
  }

  @override
  bool operator ==(covariant Anotation other) {
    if (identical(this, other)) return true;

    return other.envio == envio &&
        other.description == description &&
        other.videos == videos &&
        other.imagens == imagens &&
        other.audios == audios;
  }

  @override
  int get hashCode {
    return envio.hashCode ^
        description.hashCode ^
        videos.hashCode ^
        imagens.hashCode ^
        audios.hashCode;
  }
}
