// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Anotation {
  late final DateTime envio;
  late final String description;
  late final List<String> videos;
  late final List<String> imagens;
  late final List<String> audios;
  Anotation({
    required this.envio,
    required this.description,
    required this.videos,
    required this.imagens,
    required this.audios,
  });

  Anotation copyWith({
     DateTime? envio,
     String? description,
     List<String>? videos,
     List<String>? imagens,
     List<String>? audios,
  }) {
    return Anotation(
      envio: envio ?? this.envio,
      description: description ?? this.description,
      videos: videos ?? this.videos,
      imagens: imagens ?? this.imagens,
      audios: audios ?? this.audios,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'envio': envio,
      'description': description,
      'videos': videos,
      'imagens': imagens,
      'audios': audios,
    };
  }

  factory Anotation.fromMap(Map<String, dynamic> map) {
    return Anotation(
      envio: map['envio'] as DateTime,
      description:map['description'] as String,
      videos:  map['videos'] as List<String>,
      imagens: map['imagens'] as List<String>,
      audios: map['audios'] as List<String>,
    );
  }

  String toJson() => json.encode(toMap());

  factory Anotation.fromJson(String source) => Anotation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Anotation(envio: $envio, description: $description, videos: $videos, imagens: $imagens, audios: $audios)';
  }

  @override
  bool operator ==(covariant Anotation other) {
    if (identical(this, other)) return true;
  
    return 
      other.envio == envio &&
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
