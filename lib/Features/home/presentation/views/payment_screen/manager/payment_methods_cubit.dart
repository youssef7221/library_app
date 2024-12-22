import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/router/app_router.dart';
import '../../../../../../core/utils/app_color.dart';
import '../../../../../../core/utils/app_fonts.dart';
import 'model/payment_method.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      name: 'Credit Card',
      icon: 'assets/credit_card.svg',
      subtitle: 'Visa, Mastercard, Meza',
    ),
    PaymentMethod(
      name: 'PayPal',
      icon: 'assets/paypal.svg',
      subtitle: 'Secure online payments',
    ),
    PaymentMethod(
      name: 'Fawry',
      icon: 'assets/Fawry.svg',
      subtitle: 'Quick and secure',
    ),
  ];

  PaymentMethod? selectedPaymentMethod;

  void changeMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
    emit(PaymentMethodsChange());
  }

  bool isMethodSelected(PaymentMethod method) {
    return selectedPaymentMethod == method;
  }

  void showPaymentConfirmationDialog(BuildContext context, String? bookName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Payment Confirmation',
          style: AppFonts.boldFont,
        ),
        content: Text(
          'Your payment for $bookName by ${selectedPaymentMethod?.name} has been processed successfully.',
          style: AppFonts.smallFont,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              context.pushReplacement(AppRouter.kHomeView); // Navigate to home
            },
            child: Text(
              'OK',
              style: AppFonts.boldFont.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void proceedWithPayment(BuildContext context, String? bookName) {
    switch (selectedPaymentMethod?.name) {
      case 'Credit Card':
        // Navigate to credit card input screen
        break;
      case 'PayPal':
        // Initiate PayPal payment
        break;
      case 'Apple Pay':
        // Initiate Apple Pay
        break;
    }
    showPaymentConfirmationDialog(context, bookName);
  }
}
