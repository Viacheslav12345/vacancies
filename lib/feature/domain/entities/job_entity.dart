import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  int? id;
  final int companyId;
  final String title;
  final String description;
  final String city;

  JobEntity({
    required this.id,
    required this.companyId,
    required this.title,
    required this.description,
    required this.city,
  });

  @override
  List<Object?> get props => [id, companyId, title, description, city];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'title': title,
      'description': description,
      'city': city,
    };
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'companyId': companyId,
  //   };
  // }
}
