import 'package:vacancies/feature/domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  const CompanyModel({
    required id,
    required name,
    required description,
    required industry,
  }) : super(
          id: id ?? 0,
          name: name ?? '',
          description: description ?? '',
          industry: industry ?? '',
        );

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      industry: json['industry'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'industry': industry,
    };
  }
}
