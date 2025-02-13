import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:project/features/routine/presentation/widgets/delete_routine_app_bar.dart';
import 'package:project/service_locator.dart';

class RoutineDeletePage extends StatefulWidget {
  const RoutineDeletePage({
    super.key,
  });

  @override
  State<RoutineDeletePage> createState() => _RoutineDeletePageState();
}

class _RoutineDeletePageState extends State<RoutineDeletePage> {
  Set<int> selectedIds = {}; // ใช้ String เพราะ id ใน mockData เป็น String

  @override
  void initState() {
    super.initState();
    context.read<RoutineBloc>().add(LoadRoutineEvent());
  }

  void _confirmDelete() {
    if (selectedIds.isEmpty) return; // ถ้าไม่มีอะไรถูกเลือก ไม่ต้องแสดง Popup

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(
            "ลบรายการ?",
            style: TextThemes.bodyBold,
          ),
          content: Text(
            "คุณยืนยันที่จะลบรายการที่คุณเลือกหรือไม่",
            style: TextThemes.desc,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // ปิด Popup
              child: Text(
                "ยกเลิก",
                style: TextThemes.descBold,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.bg_score_card_red),
              ),
              onPressed: () async {
                //delete with backend
                await sl<RoutineBloc>()
                  ..add(LoadRoutineEvent())
                  ..add(LoadNoMatchEvent());
                Navigator.pop(context); // ปิด Popup
                Navigator.pop(context); // กลับไปหน้าก่อนหน้า
              },
              child: Text(
                "ลบ",
                style: TextThemes.descBold.copyWith(color: AppColors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeleteRoutineAppBar(
        fn: _confirmDelete,
        selectNotEmpty: selectedIds.isNotEmpty,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<RoutineBloc, RoutineState>(
          builder: (context, state) {
            if (state is RoutineLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.black,
                ),
              );
            }
            if (state is RoutineDataLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedIds.length ==
                            state.productsRoutine.length) {
                          selectedIds.clear();
                        } else {
                          selectedIds =
                              state.productsRoutine.map((e) => e.id).toSet();
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Checkbox(
                            checkColor: AppColors.white,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return selectedIds.length ==
                                      state.productsRoutine.length
                                  ? Colors.black
                                  : Colors.white;
                            }),
                            value: selectedIds.length ==
                                    state.productsRoutine.length
                                ? true
                                : false,
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  selectedIds = state.productsRoutine
                                      .map((e) => e.id)
                                      .toSet();
                                } else {
                                  selectedIds.clear();
                                }
                              });
                            }),
                        Text(
                          "เลือกทั้งหมด ${state.productsRoutine.length} รายการ",
                          style: TextThemes.body,
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.productsRoutine.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                    itemBuilder: (context, index) {
                      final product = state.productsRoutine[index];
                      final bool isSelected = selectedIds.contains(product.id);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedIds.remove(product.id);
                            } else {
                              selectedIds.add(product.id);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  isSelected ? AppColors.black : AppColors.grey,
                            ),
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isSelected,
                                checkColor: AppColors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return Colors
                                          .black; // สีพื้นหลังเป็นดำเมื่อถูกเลือก
                                    }
                                    return Colors
                                        .white; // สีพื้นหลังเป็นขาวเมื่อไม่ถูกเลือก
                                  },
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedIds.add(product.id);
                                    } else {
                                      selectedIds.remove(product.id);
                                    }
                                  });
                                },
                              ),
                              Image.network(
                                product.img,
                                width: 60,
                                fit: BoxFit.contain,
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    product.brand,
                                    style: TextThemes.desc
                                        .copyWith(color: AppColors.darkGrey),
                                  ),
                                  subtitle: Text(
                                    product.product,
                                    style: TextThemes.bodyBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return Center(
              child: Text("ไม่สามารถโหลดข้อมูลได้ กลับมาอีกครั้งในภายหลัง"),
            );
          },
        ),
      ),
    );
  }
}
