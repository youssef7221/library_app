import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/Features/home/manager/data/models/book_model/book_model.dart';
import 'package:library_app/core/shared_cubits/user_cubit/user_cubit.dart';

import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../manager/payment_methods_cubit.dart';

class ConfirmPaymentButton extends StatelessWidget {
  const ConfirmPaymentButton({super.key, this.bookModel});

  final BookModel? bookModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PaymentMethodsCubit>();
    final userCubit = context.read<UserCubit>();
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (cubit.selectedPaymentMethod != null) {
            cubit.proceedWithPayment(context, bookModel?.volumeInfo.title);
            context.read<UserCubit>().addBookToUser(userCubit.userModel!.id, bookModel?.id);
          }
          return;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: cubit.selectedPaymentMethod != null
              ? AppColors.primaryColor
              : AppColors.grey,
          minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: Text(
          'Confirm Payment',
          style: AppFonts.boldFont.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
