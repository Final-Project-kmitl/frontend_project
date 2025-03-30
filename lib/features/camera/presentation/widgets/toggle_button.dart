import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback fn;
  const ToggleButton({super.key, required this.fn});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

final int padding = 20;
const double height = 56;
const double barcodeAlign = -1;
const double cameraAlign = 1;
const Color selectedColor = Colors.black;
const Color normalColor = Colors.black54;

class _ToggleButtonState extends State<ToggleButton> {
  late double xAlign;
  late Color cameraColor;
  late Color barCodeColor;
  late double toggleWidth;
  late double toggleHeight;

  @override
  void initState() {
    // TODO: implement initState
    xAlign = barcodeAlign;
    barCodeColor = selectedColor;
    cameraColor = normalColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final toggleWidth = MediaQuery.of(context).size.width - (2 * padding);
    return Container(
      width: toggleWidth,
      height: height,
      decoration: BoxDecoration(
        color: normalColor,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: Duration(milliseconds: 300),
            child: Container(
              width: toggleWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (xAlign == cameraAlign) {
                widget.fn();
                setState(() {
                  xAlign = barcodeAlign;
                  cameraColor = selectedColor;
                  barCodeColor = normalColor;
                });
              }
            },
            child: Align(
              alignment: Alignment(-1, 0),
              child: Container(
                width: toggleWidth * 0.5,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.barcode_reader,
                      color:
                          xAlign == barcodeAlign ? selectedColor : Colors.white,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    AnimatedDefaultTextStyle(
                      child: Text("แสกนบาร์โค้ด"),
                      style: TextStyle(
                          color: xAlign == barcodeAlign
                              ? selectedColor
                              : Colors.white),
                      duration: Duration(milliseconds: 300),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (xAlign == barcodeAlign) {
                widget.fn();
                setState(() {
                  xAlign = cameraAlign;
                  cameraColor = normalColor;
                  barCodeColor = selectedColor;
                });
              }
            },
            child: Align(
              alignment: const Alignment(1, 0),
              child: Container(
                width: toggleWidth * 0.5,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera,
                      color:
                          xAlign == cameraAlign ? selectedColor : Colors.white,
                    ),
                    const SizedBox(width: 4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: xAlign == cameraAlign
                            ? selectedColor
                            : Colors.white,
                        fontSize: 16,
                      ),
                      child: const Text("กล้อง"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
