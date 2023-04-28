// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class grafic {
  final String name;
  final int value;


  grafic(
    this.name,
    this.value,
  );


  grafic copyWith({
    String? name,
    int? value,
  }) {
    return grafic(
      name ?? this.name,
      value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory grafic.fromMap(Map<String, dynamic> map) {
    return grafic(
      map['name'] as String,
      map['value'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory grafic.fromJson(String source) => grafic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'grafic(name: $name, value: $value)';

  @override
  bool operator ==(covariant grafic other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
