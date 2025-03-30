import 'package:flutter/material.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';

class FindPage extends StatefulWidget {
  final Function(List<int>) onSelect;
  const FindPage({
    super.key,
    required this.onSelect,
  });

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  List<Map<String, dynamic>> _q3test = [
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
  List<int> _selectedIds = []; // เก็บ id ที่เลือก

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "คุณมองหาผลิตภัณฑ์ที่ช่วยเรื่องอะไร?",
              style: TextThemes.headline1,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "เลือกได้มากกว่า 1 ข้อ",
              style: TextThemes.body.copyWith(color: AppColors.darkGrey),
            ),
            SizedBox(
              height: 32,
            ),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: _q3test.map((e) {
                return ChoiceChip(
                  showCheckmark: false,
                  label: Text(
                    e["label"],
                    style: TextThemes.bodyBold,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  side: e["selected"]
                      ? BorderSide(color: e["color"])
                      : BorderSide(color: Color(0xffD0D0D0)),
                  selected: e["selected"],
                  onSelected: (value) {
                    setState(() {
                      e["selected"] = value;
                      if (value) {
                        _selectedIds.add(e['id']);
                      } else {
                        _selectedIds.remove(e['id']);
                      }
                    });
                    widget.onSelect(_selectedIds);
                  },
                  selectedColor: e["color"],
                  backgroundColor: Colors.white,
                );
              }).toList(), // Convert the map result to a list
            )
          ],
        ),
      ),
    );
  }
}
