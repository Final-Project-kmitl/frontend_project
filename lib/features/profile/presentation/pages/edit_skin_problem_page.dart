import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/profile/domain/entities/user_entity.dart';
import 'package:project/features/profile/presentation/bloc/profile_bloc.dart';

class EditSkinProblemPage extends StatefulWidget {
  final List<SkinProblemEntity> skinProblem;
  const EditSkinProblemPage({
    super.key,
    required this.skinProblem,
  });

  @override
  State<EditSkinProblemPage> createState() => _EditSkinProblemPageState();
}

class _EditSkinProblemPageState extends State<EditSkinProblemPage> {
  late List<int> _skinProblem = [];
  late List<Map<String, dynamic>> _q3test = [
    {
      "id": 1,
      "label": "เป็นสิว",
      "selected": false,
      "color": Color(0xffE9F2FB)
    },
    {
      "id": 2,
      "label": "มีริ้วรอย",
      "selected": false,
      "color": Color(0xffFDF3E9)
    },
    {
      "id": 3,
      "label": "มีจุดด่างดำ",
      "selected": false,
      "color": Color(0xffEFE8FA)
    },
    {
      "id": 4,
      "label": "รูขุมขนกว้าง",
      "selected": false,
      "color": Color(0xffFBE5D7)
    },
    {
      "id": 5,
      "label": "หน้ามัน",
      "selected": false,
      "color": Color(0xffE9F2FB)
    },
    {
      "id": 6,
      "label": "สีผิวไม่สม่ำเสมอ",
      "selected": false,
      "color": Color(0xffFDF3E9)
    },
    {
      "id": 7,
      "label": "ผิวขาดความชุ่มชื้น/แสบแดง",
      "selected": false,
      "color": Color(0xffEFE8FA)
    },
    {
      "id": 8,
      "label": "ผิวไม่เรียบเนียน",
      "selected": false,
      "color": Color(0xffFBE5D7)
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _skinProblem = widget.skinProblem.map((e) => e.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    _q3test.map((e) {
      print(e['label']);
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'ปัญหาผิว',
          style: TextThemes.headline2,
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            context.read<ProfileBloc>().add(ProfileLoadEvent());
            Navigator.pop(context); // กลับไปหน้าก่อนหน้า
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Wrap(
            runSpacing: 8,
            spacing: 8,
            children: _q3test.map((e) {
              return ChoiceChip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                label: Text(
                  e['label'],
                  style: TextThemes.bodyBold,
                ),
                side: _skinProblem.contains(e['id'])
                    ? BorderSide(color: e["color"])
                    : BorderSide(color: Color(0xffD0D0D0)),
                selected: _skinProblem.contains(e['id']),
                onSelected: (value) {
                  setState(() {
                    e['selected'] = value;
                    if (value) {
                      _skinProblem.add(e['id']);
                    } else {
                      _skinProblem.remove(e['id']);
                    }
                  });
                },
                showCheckmark: false,
                selectedColor: e['color'],
                backgroundColor: Colors.white,
              );
            }).toList(),
          ),
          Spacer(),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is UpdateSkinProblemLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false, // ❌ ป้องกันการกดออก
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.white,
                      content: Row(
                        children: [
                          CircularProgressIndicator(
                            color: AppColors.black,
                          ),
                          SizedBox(width: 16),
                          Text("กำลังอัปเดตข้อมูล..."),
                        ],
                      ),
                    );
                  },
                );
              }
              if (state is UpdateSkinProblemSuccess) {
                context.read<ProfileBloc>().add(ProfileLoadEvent());
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: GestureDetector(
              onTap: _skinProblem.isEmpty
                  ? null
                  : () async {
                      final List<int> onDelete = widget.skinProblem
                          .where((skin) => !_skinProblem.contains(skin.id))
                          .map((e) => e.id) // ✅ แปลงเป็น List<int>
                          .toList();

                      final List<int> onAdd = _skinProblem
                          .where((id) =>
                              !widget.skinProblem.any((skin) => skin.id == id))
                          .toList();

                      context.read<ProfileBloc>().add(
                          UpdateSkinProblemSectionEvent(
                              onAdd: onAdd, onDelete: onDelete));
                    },
              child: Container(
                margin: EdgeInsets.only(bottom: 52, left: 20, right: 20),
                decoration: BoxDecoration(
                    color:
                        _skinProblem.isEmpty ? AppColors.grey : AppColors.black,
                    borderRadius: BorderRadius.circular(16)),
                height: 52,
                width: double.infinity,
                child: Center(
                    child: Text(
                  "บันทึก",
                  style: TextThemes.bodyBold.copyWith(color: AppColors.white),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
