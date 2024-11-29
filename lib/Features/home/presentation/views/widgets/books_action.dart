// import 'package:go_router/go_router.dart';
// import 'package:library_app/Features/home/data/models/book_model/book_model.dart';
// import 'package:library_app/core/utils/function/launch_url.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../../../core/widgets/custom_button.dart';
//
// class BooksAction extends StatelessWidget {
//   const BooksAction({super.key, required this.bookModel, required this.isRent});
//
//   final bool isRent;
//   final BookModel bookModel;
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController daysEditingController = TextEditingController();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Row(
//         children: [
//           Expanded(
//               child: CustomButton(
//             text: isRent ? "20 LE" : "350 LE",
//             backgroundColor: Colors.white,
//             textColor: Colors.black,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(16),
//               bottomLeft: Radius.circular(16),
//             ),
//           )),
//           Expanded(
//               child: CustomButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   if (isRent) {
//                     return AlertDialog(
//                         title: Text("How many Days"),
//                         content: TextFormField(
//                           controller:daysEditingController,
//                           keyboardType: TextInputType.number,
//                           decoration: const InputDecoration(
//                             labelText: 'Days',
//                             hintText: 'Enter your Days to rent',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             String enteredDays = daysEditingController.text;
//                             int enteredDaysInt = int.parse(enteredDays);
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title: Text("Total = ${enteredDaysInt * 20}"),
//                                   actions: [
//                                     TextButton(onPressed: () {
//                                       showDialog(context: context, builder: (context) {
//                                         return  AlertDialog(
//                                           title:Text("Request Sent To User Successfully"),
//                                           icon:Icon(Icons.emoji_emotions),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: (){
//                                                 GoRouter.of(context).pop();
//                                                 GoRouter.of(context).pop();
//                                                 GoRouter.of(context).pop();
//                                               },
//                                               child: Text("Ok"),
//                                             )
//                                           ],
//                                         );
//                                     },);
//                                     }, child: Text("Done"))
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                           child: Text('OK'),
//                         ),
//                       ],
//                     );
//                   }
//                   return const AlertDialog(
//                     title: Text("Request Sent To User Successfully"),
//                     icon: Icon(Icons.emoji_emotions),
//                   );
//                 },
//               );
//             },
//             fontSize:16,
//             text: isRent ? "Rent" : "Buy",
//             backgroundColor: const Color(0xffEF8262),
//             textColor: Colors.white,
//             borderRadius: const BorderRadius.only(
//               topRight: Radius.circular(16),
//               bottomRight: Radius.circular(16),
//             ),
//           )),
//         ],
//       ),
//     );
//   }
//
//   String getText(BookModel bookModel) {
//     if(bookModel.volumeInfo.previewLink == null) {
//       return 'Not Avaliable';
//     } else {
//       return 'Preview';
//     }
//   }
// }
