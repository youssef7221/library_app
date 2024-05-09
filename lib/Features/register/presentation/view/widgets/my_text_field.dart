import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
   MyTextForm({required this.textEditingController
  ,required this.label ,this.onValidate});
  TextEditingController textEditingController = TextEditingController();
  String label;
   String? Function(String?)? onValidate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        onChanged:(value) {
          print(value);
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25)
            ),
            label: Text(label)
        ), validator: onValidate
    );
  }
}
