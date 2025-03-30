import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/common/helper/navigation/app_navigation.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:project/features/routine/presentation/pages/search_product_page.dart';
import 'package:project/features/routine/presentation/widgets/all_match.dart';
import 'package:project/features/routine/presentation/widgets/rontine_app_bar.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RoutineBloc>().add(LoadRoutineAndNoMatchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoutineBloc, RoutineState>(
      listener: (context, state) {
        if (state is RoutineDeleteSuccess) {
          context.read<RoutineBloc>().add(LoadRoutineAndNoMatchEvent());
        }
      },
      child: BlocBuilder<RoutineBloc, RoutineState>(
        builder: (context, state) {
          if (state is RoutineLoading) {
            return Scaffold(
              appBar: RoutineAppBar(
                isRoutineFull: false,
                isEmpty: false,
              ),
              body: const Center(
                child: CircularProgressIndicator(color: AppColors.black),
              ),
            );
          } else if (state is RoutineDataLoaded) {
            return Scaffold(
              appBar: RoutineAppBar(
                isRoutineFull: state.productsRoutine.length >= 10,
                isEmpty: state.productsRoutine.isEmpty,
              ),
              body: state.productsRoutine.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: GestureDetector(
                        onTap: () {
                          AppNavigator.push(context, SearchProductPage());
                        },
                        child: IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.darkGrey,
                                )),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "เพิ่มผลิตภัณฑ์ลงรูทีน",
                                        style: TextThemes.bodyBold,
                                      ),
                                      Text(
                                        softWrap: true,
                                        "เราจะแจ้งให้คุณทราบเมื่อมีส่วนผสมที่ไม่ควรใช้ร่วมกันในสกินแคร์รูทีนของคุณ",
                                        style: TextThemes.desc.copyWith(
                                            color: AppColors.darkGrey),
                                      )
                                    ],
                                  ),
                                ),
                                Icon(Icons.add_circle_sharp)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.productsRoutine.isNotEmpty)
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.productsRoutine.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: AppColors.grey),
                                    ),
                                    child: ListTile(
                                      leading: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: Image.network(errorBuilder:
                                                (context, error, stackTrace) {
                                          return Image.asset(
                                            "assets/test_img.png",
                                            fit: BoxFit.contain,
                                          );
                                        }, loadingBuilder: (context, child,
                                                loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: Text("Loading"),
                                            );
                                          }
                                        },
                                            fit: BoxFit.contain,
                                            state.productsRoutine[index].img),
                                      ),
                                      title: Text(
                                        state.productsRoutine[index].brand,
                                        style: TextThemes.desc.copyWith(
                                            color: AppColors.darkGrey),
                                      ),
                                      subtitle: Text(
                                        state.productsRoutine[index].product,
                                        style: TextThemes.bodyBold,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            const SizedBox(height: 16),
                            const Text("ส่วนผสมที่ไม่ควรใช้ร่วมกัน",
                                style: TextThemes.bodyBold),
                            const SizedBox(height: 16),
                            if (state.nomatRoutine.isNotEmpty)
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.nomatRoutine.length + 1,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final noMatch = state.nomatRoutine[index];
                                  if (index == state.nomatRoutine.length + 1) {
                                    return SizedBox(
                                      height: 52,
                                    );
                                  }
                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.routine_card_bg,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${noMatch.ingredient1} และ ${noMatch.ingredient2}",
                                          style: TextThemes.bodyBold,
                                        ),
                                        const SizedBox(height: 12),
                                        RichText(
                                          text: TextSpan(
                                            text: "${noMatch.product1} ",
                                            style: TextThemes.descBold,
                                            children: <TextSpan>[
                                              const TextSpan(
                                                text: "มีส่วนผสมของ ",
                                                style: TextThemes.desc,
                                              ),
                                              TextSpan(
                                                text: "${noMatch.ingredient1}",
                                                style: TextThemes.descBold
                                                    .copyWith(
                                                  color: AppColors
                                                      .routine_card_text,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: " ซึ่งไม่ควรใช้ร่วมกับ ",
                                                style: TextThemes.desc,
                                              ),
                                              TextSpan(
                                                text: "${noMatch.product2}",
                                                style: TextThemes.descBold,
                                              ),
                                              const TextSpan(
                                                text: " ซึ่งมีส่วนผสมของ ",
                                                style: TextThemes.desc,
                                              ),
                                              TextSpan(
                                                text: "${noMatch.ingredient2}",
                                                style: TextThemes.descBold
                                                    .copyWith(
                                                  color: AppColors
                                                      .routine_card_text,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            if (state.nomatRoutine.isEmpty) const AllMatch(),
                          ],
                        ),
                      ),
                    ),
            );
          } else if (state is RoutineLoadError) {
            return Scaffold(
              body: Center(child: Text("Error: ${state.message}")),
            );
          }
          return Container();
        },
      ),
    );
  }
}
