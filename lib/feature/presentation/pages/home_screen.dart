// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:vacancies/common/horizontal_gradient_style.dart';

import 'package:vacancies/common/app_colors.dart';
import 'package:vacancies/feature/presentation/pages/companies_list.dart';
import 'package:vacancies/feature/presentation/pages/jobs_list.dart';
import 'package:vacancies/feature/presentation/widgets/floating_action_buttons.dart';

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
          toolbarHeight: 40,
          flexibleSpace: const HorizontalGradientStyle(),
          bottom: TabBar(
            controller: tabController,
            onTap: (value) {
              setState(() {
                tabController.index = value;
              });
            },
            indicatorColor: (tabController.index == 0)
                ? AppColors.companyColor
                : AppColors.jobColor,
            labelColor: AppColors.jobColor,
            tabs: const [
              Tab(
                  icon: Icon(
                Icons.business_outlined,
                color: AppColors.companyColor,
              )),
              Tab(
                  icon: Icon(
                Icons.work,
                color: AppColors.jobColor,
              )),
            ],
          ),
          title: (tabController.index == 0)
              ? const Text(
                  'Компанії',
                  style: TextStyle(color: AppColors.companyColor),
                )
              : const Text(
                  'Вакансії',
                  style: TextStyle(color: AppColors.jobColor),
                ),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       (tabController.index == 0)
          //           ? BlocProvider.of<JobListCubit>(context)
          //           : BlocProvider.of<CompanyListCubit>(context);
          //     },
          //     focusColor: AppColors.buttonColor,
          //     icon: const Icon(Icons.refresh),
          //   ),
          // ],
          // leading: IconButton(
          //   onPressed: () {},
          //   focusColor: AppColors.buttonColor,
          //   icon: const Icon(Icons.star),
          // ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            CompaniesList(),
            JobsList(null),
          ],
        ),
        floatingActionButton: FloatingActionButtons(tabController.index),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
