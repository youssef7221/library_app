
import 'package:flutter/material.dart';
import 'package:library_app/constants.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickeR extends StatefulWidget{
  @override
  int index = 0;
  ImagePickeR();
  State<ImagePickeR> createState() => _ImagePickeRState();
}

class _ImagePickeRState extends State<ImagePickeR> {
  XFile? imageFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      width: 300,
      height: 67,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: Colors.grey,
              width: .5
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              _imagePick();
            },
            child: Container(
                width: 100,
                height: 35,
                decoration:  BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(5),right: Radius.circular(5))
                ),
                alignment: Alignment.center,
                child: Text("ADD Book Poster",)
            ),
          ),
          const  SizedBox(width: 10,),

          imageFile==null?const Text('null'):Text(truncateText(imageFile!.name, 15),
          ),

          Icon(Icons.image,size: 35,)
        ],
      ),
    );
  }


  String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    } else {
      return text;
    }
  }

  Future _imagePick() async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = img;
    });

  }

}