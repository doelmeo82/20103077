import 'package:flutter/material.dart';

import 'app_style.dart';

// ignore: camel_case_types, must_be_immutable
class CusTom_ButtonSubmit extends StatelessWidget {
  CusTom_ButtonSubmit({
    super.key,
    required this.textButton,
    this.isEnabled = true,
    this.size = 22.5,
  });
  final String textButton;
  // ignore: prefer_typing_uninitialized_variables
  var size;

  // ignore: prefer_typing_uninitialized_variables
  var isEnabled;
  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.white60], // Danh sách màu sử dụng trong gradient
                              begin: Alignment.centerLeft, // Điểm bắt đầu gradient (bên trái)
                              end: Alignment.centerRight, // Điểm kết thúc gradient (bên phải)
                            ), 
                  borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    textButton,
                    style: StyleGlobal.text_button
                ),
            );
  }
}

//color: isEnabled ? Colors.blue[300] : Colors.white,