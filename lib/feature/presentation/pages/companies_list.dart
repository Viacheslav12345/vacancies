import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';
import 'package:vacancies/feature/domain/entities/company_entity.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_state.dart';
import 'package:vacancies/feature/presentation/widgets/company_card_widget.dart';

class CompaniesList extends StatelessWidget {
  const CompaniesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyListCubit, CompanyState>(
        builder: (context, state) {
      List<CompanyEntity> companies = [];

      if (state is CompanyLoading) {
        return _loadingindicator();
      } else if (state is CompanyLoaded) {
        companies = state.companyList;
      } else if (state is CompanyError) {
        return HorizontalGradientStyle(
            widget: Center(
                child: Text(
          'Не можливо відобразити список:\n ${state.message}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 237, 129, 129),
          ),
        )));
      }
      return ListView.separated(
        itemBuilder: ((context, index) {
          return CompanyCard(company: companies[index]);
        }),
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: companies.length,
      );
    });
  }

  Widget _loadingindicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
