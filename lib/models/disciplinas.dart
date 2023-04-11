// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_application_1/models/anotations.dart';
import 'package:intl/intl.dart';

class Disciplinas {
  final String title;
  final DateTime initial; //data de inicio
  final int horas_dedicadas_por_semana;
  final String label; //  uma cor de referencia
  late List<String> events; //eventos importantes associados a diciplina/meta
  late List<Anotation>
      anotation; // anotaçoes que ele pode fazer ao fim de cada encontro
  late List<String> hoarios_gerados_pela_ia;

  Disciplinas({
    required this.title,
    required this.initial,
    required this.horas_dedicadas_por_semana,
    required this.label,
    required this.anotation,
  });

  Disciplinas copyWith({
    String? title,
    DateTime? initial,
    int? horas_dedicadas_por_semana,
    String? label,
    List<Anotation>? anotation,
  }) {
    return Disciplinas(
      title: title ?? this.title,
      initial: initial ?? this.initial,
      horas_dedicadas_por_semana:
          horas_dedicadas_por_semana ?? this.horas_dedicadas_por_semana,
      label: label ?? this.label,
      anotation: anotation ?? this.anotation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'initial': DateFormat("dd-MMMM-yyyy").format(initial),
      'horas_dedicadas_por_semana': horas_dedicadas_por_semana,
      'label': label,
      'anotation': anotation,
    };
  }

  factory Disciplinas.fromMap(Map<String, dynamic> map) {
    return Disciplinas(
      title: map['title'] as String,
      initial: map['initial'] as DateTime,
      horas_dedicadas_por_semana: map['horas_dedicadas_por_semana'] as int,
      label: map['label'] as String,
      anotation: map['anotation'] as List<Anotation>,
    );
  }

  String toJson() => json.encode(toMap());

  factory Disciplinas.fromJson(String source) =>
      Disciplinas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Disciplinas(title: $title, initial: $initial, horas_dedicadas_por_semana: $horas_dedicadas_por_semana, label: $label, anotation: $anotation)';
  }

  @override
  bool operator ==(covariant Disciplinas other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.initial == initial &&
        other.horas_dedicadas_por_semana == horas_dedicadas_por_semana &&
        other.label == label &&
        other.anotation == anotation;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        initial.hashCode ^
        horas_dedicadas_por_semana.hashCode ^
        label.hashCode ^
        anotation.hashCode;
  }
}
