import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final int id;
  final int companyId;
  final String title;
  final String description;
  final String city;

  const JobEntity({
    required this.id,
    required this.companyId,
    required this.title,
    required this.description,
    required this.city,
  });

  @override
  List<Object?> get props => [id, companyId, title, description, city];
}
