import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/Features/home/presentation/views/seller_widgets/imagepicker.dart';
import 'package:library_app/Features/home/presentation/views/widgets/custom_app_bar.dart';

import '../../../../../constants.dart';

class SellerViewBody extends StatefulWidget {
  const SellerViewBody({super.key});

  @override
  State<SellerViewBody> createState() => _SellerViewBodyState();
}

class _SellerViewBodyState extends State<SellerViewBody> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController priceTextEditingController = TextEditingController();
  TextEditingController authorTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return  SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(),
          Form(
            key: formKey,
            child: Padding(padding: EdgeInsets.only(top: 20)
            ,child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: nameTextEditingController,
                      validator: (value) {
                        if(value == null || value.isEmpty)
                        {
                          return "Please Fill This Field";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text("ADD Book Name"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: priceTextEditingController,
                      validator: (value) {
                        if(value == null || value.isEmpty)
                          {
                           return "Please Fill This Field";
                          }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("ADD Book price"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: authorTextEditingController,
                      validator: (value) {
                        if(value == null || value.isEmpty)
                        {
                          return "Please Fill This Field";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text("ADD Book Author"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  
                  ImagePickeR(),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          if(formKey.currentState!.validate()){
                          showDialog(context: context, builder: (context){
                           return const AlertDialog(
                              title: Text("Book Added Successfully"),
                            );
                          },);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 120,
                          height: 50,
                          child: const Center(
                              child: Text(
                                "Add Book",
                                style: TextStyle(color: kPrimaryColor),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 120,
                          height: 50,
                          child: const Center(
                              child: Text(
                                "View Requestes",
                                style: TextStyle(color: kPrimaryColor),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),),
          )
        ],
      ),
    );
  }
}
