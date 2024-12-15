import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_app/Features/home/presentation/views/payment_screen/manager/payment_methods_cubit.dart';
import 'package:library_app/Features/home/presentation/views/payment_screen/payment_methods_screen.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../manager/model/payment_method.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({super.key, required this.method});
  final PaymentMethod method;
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaymentMethodsCubit>();
    final isSelected = cubit.isMethodSelected(method);
    return GestureDetector(
      onTap:(){
        cubit.changeMethod(method);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Payment Method Icon
            SvgPicture.asset(
              method.icon,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 15),
            // Payment Method Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name,
                    style: AppFonts.boldFont.copyWith(
                      fontSize: 16,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.blackColor,
                    ),
                  ),
                  Text(
                    method.subtitle,
                    style: AppFonts.smallFont.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Selection Indicator
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
