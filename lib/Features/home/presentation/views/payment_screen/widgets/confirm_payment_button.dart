import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../manager/payment_methods_cubit.dart';

class ConfirmPaymentButton extends StatelessWidget {
  const ConfirmPaymentButton({super.key, this.bookName});
 final String? bookName;
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaymentMethodsCubit>();
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (cubit.selectedPaymentMethod != null) {
            cubit.proceedWithPayment(context,bookName);
          }
          return;
        },  style: ElevatedButton.styleFrom(
          backgroundColor:cubit.selectedPaymentMethod != null ?AppColors.primaryColor : AppColors.grey,
          minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          'Confirm Payment',
          style: AppFonts.boldFont.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
