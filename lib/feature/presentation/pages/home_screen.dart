import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/presentation/bloc/company_list_cubit/company_list_cubit.dart';
import 'package:vacancies/feature/presentation/bloc/job_list_cubit/job_list_cubit.dart';
import 'package:vacancies/feature/presentation/widgets/add_company_form.dart';
import 'package:vacancies/feature/presentation/widgets/add_job_form.dart';
import 'package:vacancies/feature/presentation/widgets/companies_list.dart';
import 'package:vacancies/feature/presentation/widgets/jobs_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: tabController,
            onTap: (value) {
              tabController.index = value;
              setState(() {});
            },
            indicatorColor: AppColors.buttonColor,
            labelColor: AppColors.buttonColor,
            tabs: const [
              Tab(icon: Icon(Icons.work)),
              Tab(icon: Icon(Icons.business_outlined))
            ],
          ),
          title: (tabController.index == 0)
              ? const Text('Вакансії')
              : const Text('Компанії'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                (tabController.index == 0)
                    ? BlocProvider.of<JobListCubit>(context).loadJob()
                    : BlocProvider.of<CompanyListCubit>(context).loadCompany();
              },
              focusColor: AppColors.buttonColor,
              icon: const Icon(Icons.refresh),
            ),
          ],
          // leading: IconButton(
          //   onPressed: () {},
          //   focusColor: AppColors.buttonColor,
          //   icon: const Icon(Icons.star),
          // ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            JobsList(),
            CompaniesList(),
          ],
        ),
        floatingActionButton: (tabController.index == 1)
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddCompanyForm()));
                },
                backgroundColor: AppColors.buttonColor,
                tooltip: 'Add',
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
