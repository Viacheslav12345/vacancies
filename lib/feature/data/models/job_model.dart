import 'package:vacancies/feature/domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required id,
    required companyId,
    required title,
    required description,
    required city,
  }) : super(
          id: id ?? 0,
          companyId: companyId ?? 0,
          title: title ?? '',
          description: description ?? '',
          city: city ?? '',
        );

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      companyId: json['companyId'],
      title: json['title'],
      description: json['description'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'title': title,
      'description': description,
      'city': city,
    };
  }
}
