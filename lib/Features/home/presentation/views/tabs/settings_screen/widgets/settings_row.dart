import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_color.dart';
import '../../../../../../../core/utils/app_fonts.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: AppColors.grey, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Text(
            label,
            style: AppFonts.boldFont.copyWith(fontSize: 14),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}
