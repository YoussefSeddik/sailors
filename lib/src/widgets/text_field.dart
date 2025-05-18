import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget buildTextField({
  required String hintKey,
  required TextEditingController controller,
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    decoration: InputDecoration(hintText: hintKey.tr()),
  );
}
