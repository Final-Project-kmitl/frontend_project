import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:project/features/routine/presentation/pages/empty_all_page.dart';
import 'package:project/features/routine/presentation/widgets/all_match.dart';
import 'package:project/features/routine/presentation/widgets/rontine_app_bar.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  bool _isFirstLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RoutineBloc>().add(LoadRoutineEvent());
    context.read<RoutineBloc>().add(LoadNoMatchEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isFirstLoad) {
      context.read<RoutineBloc>().add(LoadRoutineEvent());
      context.read<RoutineBloc>().add(LoadNoMatchEvent());
    }
    _isFirstLoad = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineBloc, RoutineState>(builder: (context, state) {
      if (state is RoutineLoading) {
        return Scaffold(
          appBar: RoutineAppBar(
            isEmpty: false,
          ),
          body: const Center(
            child: CircularProgressIndicator(
              color: AppColors.black,
            ),
          ),
        );
      } else if (state is RoutineDataLoaded) {
        return Scaffold(
          appBar: RoutineAppBar(
            isEmpty: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.productsRoutine.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.productsRoutine.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.grey,
                                )),
                            child: ListTile(
                              leading: Image.network(
                                  state.productsRoutine[index].img),
                              title: Text(
                                "${state.productsRoutine[index].brand}",
                                style: TextThemes.desc
                                    .copyWith(color: AppColors.darkGrey),
                              ),
                              subtitle: Text(
                                "${state.productsRoutine[index].product}",
                                style: TextThemes.bodyBold,
                              ),
                            ));
                      },
                    ),
                  const Text(
                    "ส่วนผสมที่ไม่ควรใช้ร่วมกัน",
                    style: TextThemes.bodyBold,
                  ),
                  const SizedBox(height: 16),
                  if (state.nomatRoutine.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.nomatRoutine.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final noMatch = state.nomatRoutine[index];

                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: AppColors.routine_card_bg,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        style: TextThemes.descBold.copyWith(
                                            color:
                                                AppColors.routine_card_text)),
                                    const TextSpan(
                                      text: " ซึ่งไม่ควรใช้ร่วมกับ ",
                                      style: TextThemes.desc,
                                    ),
                                    TextSpan(
                                        text: "${noMatch.product2}",
                                        style: TextThemes.descBold),
                                    const TextSpan(
                                      text: " ซึ่งมีส่วนผสมของ ",
                                      style: TextThemes.desc,
                                    ),
                                    TextSpan(
                                        text: "${noMatch.ingredient2}",
                                        style: TextThemes.descBold.copyWith(
                                            color:
                                                AppColors.routine_card_text)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  if (state.nomatRoutine.isEmpty) const AllMatch()
                ],
              ),
            ),
          ),
        );
      } else if (state is RoutineLoadError) {
        return Center(
          child: Text("${state.message}"),
        );
      }
      print("!@#!@#!@# ${state}");
      return EmptyAllPage();
    });
  }
}
