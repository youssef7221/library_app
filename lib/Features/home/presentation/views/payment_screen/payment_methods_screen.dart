import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Features/home/presentation/views/payment_screen/manager/payment_methods_cubit.dart';
import 'package:library_app/Features/home/presentation/views/payment_screen/widgets/book_details_payment_card.dart';
import 'package:library_app/Features/home/presentation/views/payment_screen/widgets/confirm_payment_button.dart';
import 'package:library_app/Features/home/presentation/views/payment_screen/widgets/payment_method_tile.dart';
import '../../../../../core/service_locator/service_locator.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/app_fonts.dart';
import '../../../manager/data/models/book_model/book_model.dart';

class PaymentMethodsScreen extends StatelessWidget {
  final BookModel selectedBook;

  const PaymentMethodsScreen({
    super.key,
    required this.selectedBook,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Payment Methods',
          style: AppFonts.boldFont.copyWith(fontSize: 20.sp),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<PaymentMethodsCubit>(),
        child: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Details Card
                  BookDetailsPaymentCard(
                    selectedBook: selectedBook,
                  ),
                  SizedBox(height: 20.h),
                  // Payment Methods Title
                  Text(
                    'Select Payment Method',
                    style: AppFonts.boldFont.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 15.h),
                  // Payment Methods List
                  Expanded(
                    child: ListView.separated(
                      itemCount: context
                          .read<PaymentMethodsCubit>()
                          .paymentMethods
                          .length,
                      separatorBuilder: (context, index) =>
                           SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final method = context
                            .read<PaymentMethodsCubit>()
                            .paymentMethods[index];
                        return PaymentMethodTile(
                          method: method,
                        );
                      },
                    ),
                  ),
                  ConfirmPaymentButton(bookModel: selectedBook,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
