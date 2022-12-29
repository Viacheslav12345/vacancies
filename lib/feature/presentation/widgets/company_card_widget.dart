import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/pages/company_detail_screen.dart';

class CompanyCard extends StatelessWidget {
  final CompanyEntity company;

  const CompanyCard({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          BlocProvider.of<CompanyListCubit>(context).loadCompany();
        }),
        children: [
          SlidableAction(
            onPressed: (context) {
              BlocProvider.of<CompanyListCubit>(context).deleteCompany(company);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompanyDetailPage(company: company)));
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cellBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    company.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    company.description,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 15,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    company.industry,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 244, 171, 171),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
