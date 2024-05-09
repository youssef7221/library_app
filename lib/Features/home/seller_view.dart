import 'package:flutter/material.dart';
import 'package:library_app/Features/home/presentation/views/seller_widgets/sellerviewbody.dart';
import 'package:library_app/Features/home/presentation/views/widgets/custom_app_bar.dart';

class SellerView extends StatelessWidget {
  const SellerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SellerViewBody(),
    );
  }
}
