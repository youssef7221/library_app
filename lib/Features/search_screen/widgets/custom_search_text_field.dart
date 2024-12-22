import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../core/utils/app_color.dart';
import '../../home/presentation/manger/search_books_cubit/search_books_cubit.dart';

class CustomSearchTextField extends StatefulWidget {
  const CustomSearchTextField({super.key});

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  bool _isFinish = false;

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    if(_isFinish == false)
      {
        focusNode.requestFocus();
        _isFinish = true;
      }
    });
  TextEditingController searchController = context.read<SearchBooksCubit>().searchController;
    return TextField(
      controller: searchController,
      focusNode: focusNode,
      textInputAction: TextInputAction.search,
      onSubmitted: (value){
        if (searchController.text.isNotEmpty)
          {
            focusNode.unfocus();
            context.read<SearchBooksCubit>().fetchSearchBooks(book:searchController.text);
          }
      },
      cursorColor: AppColors.whiteColor,
      decoration: InputDecoration(
        fillColor: AppColors.blackColor,
        filled: true,
        hintStyle: TextStyle(color: AppColors.whiteColor),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        hintText: 'Search',
        suffixIcon: IconButton(
          onPressed: (){
            focusNode.unfocus();
            context.read<SearchBooksCubit>().fetchSearchBooks(book: searchController.text);
          },
          icon: const Opacity(
            opacity: .8,
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: 24,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }
}
