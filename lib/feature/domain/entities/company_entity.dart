import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String industry;

  const CompanyEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.industry,
  });

  @override
  List<Object?> get props => [id, name, description, industry];

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'description': description,
      'industry': industry,
    };
  }
}
