part of 'payment_methods_cubit.dart';

sealed class PaymentMethodsState {}

final class PaymentMethodsInitial extends PaymentMethodsState {}
final class PaymentMethodsChange extends PaymentMethodsState {}

