import '../../domain/entities/engineer.dart';

class EngineerModel extends Engineer {
  const EngineerModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
  });

  factory EngineerModel.fromJson(Map<String, dynamic> json) {
    return EngineerModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}