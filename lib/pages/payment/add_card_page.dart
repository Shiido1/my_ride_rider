// import 'package:flutter/material.dart';
// import 'package:my_ride/utils/router.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import '../../components/loading_button.dart';
// import '../../components/my_app_bar.dart';
// import '../../constants/colors.dart';
// import '../../controllers/payment_controller.dart';
// import '../../models/global_model.dart';
// import '../../partials/mixins/validations.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';

// import '../../widget/textSection.dart';
// import '../../widget/text_widget.dart';

// class AddCard extends StatefulWidget {
//   const AddCard({Key? key}) : super(key: key);

//   @override
//   _AddCardState createState() => _AddCardState();
// }

// class _AddCardState extends StateMVC<AddCard> with ValidationMixin {
//   _AddCardState() : super(PaymentController()) {
//     con = controller as PaymentController;
//   }
//   late PaymentController con;

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   navigate() async {
//     setState(() {
//       isRegistration = false;
//     });
//     await con.getUserData();
//     Routers.replaceAllWithName(context, '/home');
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Scaffold(
//         key: _scaffoldKey,
//         appBar: MyAppBar.defaultAppBar(context),
//         body: SafeArea(
//             child: Padding(
//                 padding: EdgeInsets.all(4.w),
//                 child: SingleChildScrollView(
//                     child: Form(
//                         key: con.model.cardFormKey,
//                         child: SingleChildScrollView(
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 TextView(
//                                   text: 'Add Card',
//                                   fontSize: 19.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 SizedBox(
//                                   height: 9.h,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     TextView(
//                                       text: 'ACCEPTED CARDS',
//                                       color: AppColors.primary,
//                                       fontSize: 18.sp,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                     InkWell(
//                                       onTap: () => navigate(),
//                                       child: TextView(
//                                           text: 'Skip',
//                                           fontSize: 17.sp,
//                                           fontWeight: FontWeight.w600,
//                                           color: AppColors.primary),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                         child: Container(
//                                       width: 60.w,
//                                       height: 5.h,
//                                       decoration: BoxDecoration(
//                                           image: const DecorationImage(
//                                               fit: BoxFit.scaleDown,
//                                               image: AssetImage(
//                                                   'assets/images/Mastercard.png')),
//                                           border: Border.all(
//                                               color: AppColors.black),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(4.w))),
//                                     )),
//                                     SizedBox(
//                                       width: 2.w,
//                                     ),
//                                     Expanded(
//                                         child: Container(
//                                       width: 60.w,
//                                       height: 5.h,
//                                       decoration: BoxDecoration(
//                                           image: const DecorationImage(
//                                               fit: BoxFit.contain,
//                                               image: AssetImage(
//                                                 'assets/images/visa.png',
//                                               )),
//                                           border: Border.all(
//                                               color: AppColors.black),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(4.w))),
//                                     )),
//                                     SizedBox(
//                                       width: 2.w,
//                                     ),
//                                     Expanded(
//                                         child: Container(
//                                       width: 60.w,
//                                       height: 5.h,
//                                       decoration: BoxDecoration(
//                                           image: const DecorationImage(
//                                             fit: BoxFit.contain,
//                                             image: AssetImage(
//                                               'assets/images/verve.jpeg',
//                                             ),
//                                           ),
//                                           border: Border.all(
//                                               color: AppColors.black),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(4.w))),
//                                     )),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 2.h,
//                                 ),
//                                 const Divider(
//                                   thickness: 2,
//                                   color: AppColors.bgGrey1,
//                                 ),
//                                 SizedBox(
//                                   height: 4.h,
//                                 ),
//                                 TextView(
//                                     text: "Card Holder's Name:",
//                                     fontSize: 17.sp,
//                                     color: AppColors.primary),
//                                 SizedBox(
//                                   height: 0.5.h,
//                                 ),
//                                 TextSection(
//                                   obscure: false,
//                                   labelText: '',
//                                   textType: TextInputType.text,
//                                   controller: con.model.cardHolderController,
//                                 ),
//                                 SizedBox(
//                                   height: 4.h,
//                                 ),
//                                 TextView(
//                                     text: "Card No:",
//                                     fontSize: 17.sp,
//                                     color: AppColors.primary),
//                                 SizedBox(height: 0.5.h),
//                                 TextSection(
//                                   obscure: false,
//                                   labelText: '',
//                                   textType: TextInputType.number,
//                                   controller: con.model.cardNoController,
//                                 ),
//                                 SizedBox(
//                                   height: 4.h,
//                                 ),
//                                 Row(
//                                   children: [
//                                     TextView(
//                                         text: 'Expiring Date:',
//                                         fontSize: 17.sp,
//                                         color: AppColors.primary),
//                                     SizedBox(
//                                       width: 50.w,
//                                     ),
//                                     TextView(
//                                         text: 'Cvv:',
//                                         fontSize: 17.sp,
//                                         color: AppColors.primary),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: .5.h,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 1,
//                                       child: TextSection(
//                                         obscure: false,
//                                         labelText: 'mm',
//                                         textType: TextInputType.number,
//                                         controller: con.model.monthController,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 4.w,
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: TextSection(
//                                         obscure: false,
//                                         labelText: 'yyyy',
//                                         textType: TextInputType.number,
//                                         controller: con.model.yearController,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 4.w,
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: TextSection(
//                                         obscure: true,
//                                         labelText: '',
//                                         textType: TextInputType.number,
//                                         controller: con.model.cvvController,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 7.h,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: const [
//                                     Icon(
//                                       Icons.lock,
//                                       color: AppColors.primary,
//                                     ),
//                                   ],
//                                 ),
//                                 Center(
//                                   child: TextView(
//                                     text:
//                                         'We would never share your card\n information with anyone',
//                                     textAlign: TextAlign.center,
//                                     color: AppColors.primary,
//                                     fontSize: 15.5.sp,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 4.h,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       top: 4.w, right: 8.w, left: 8.w),
//                                   child: LoadingButton(
//                                       isLoading: con.model.isCardLoading,
//                                       label: "Continue",
//                                       onPressed: con.addCard
//                                       //
//                                       ),
//                                 ),
//                               ]),
//                         ))))));
//   }
// }
