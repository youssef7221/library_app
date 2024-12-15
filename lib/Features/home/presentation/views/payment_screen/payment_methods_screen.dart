import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          style: AppFonts.boldFont.copyWith(fontSize: 20),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<PaymentMethodsCubit>(),
        child: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Details Card
                  BookDetailsPaymentCard(
                    selectedBook: selectedBook,
                  ),
                  const SizedBox(height: 20),
                  // Payment Methods Title
                  Text(
                    'Select Payment Method',
                    style: AppFonts.boldFont.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  // Payment Methods List
                  Expanded(
                    child: ListView.separated(
                      itemCount: context
                          .read<PaymentMethodsCubit>()
                          .paymentMethods
                          .length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
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
                  ConfirmPaymentButton(bookName: selectedBook.volumeInfo.title,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
