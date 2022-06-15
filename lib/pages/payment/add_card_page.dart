import 'package:flutter/material.dart';

import '../../components/my_app_bar.dart';
import '../../constants/colors.dart';
import '../../models/card_models.dart';
import '../../utils/router.dart';
import '../../widget/textSection.dart';

class AddCard extends StatelessWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar.defaultAppBar(context),
        body: SafeArea(
            child: Padding(padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        Text('Add Card', style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text('ACCEPTED CARDS', style: TextStyle(color: AppColors.primary),),
                            InkWell(
                              onTap: (){Routers.pushNamed(context, '/reg_success');},
                              child:  Text('Skip',style: TextStyle(color: AppColors.primary)),
                            ),

                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(child:Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(fit: BoxFit.fitHeight, image: AssetImage('assets/images/Mastercard.png')),
                                  border: Border.all(width: 1, color: Colors.black26),
                                  borderRadius: BorderRadius.all(Radius.circular(12))),
                            )),
                            SizedBox(width: 5,),
                            Expanded(child:Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(fit: BoxFit.fitHeight, image: AssetImage('assets/images/visa.png',)),
                                  border: Border.all(width: 1, color: Colors.black26),
                                  borderRadius: BorderRadius.all(Radius.circular(12))),
                            )),
                            SizedBox(width: 5,),
                            Expanded(child: Container(

                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth, image: AssetImage(
                                      'assets/images/verve.png'),

                                  ),
                                  border: Border.all(width: 1, color: Colors.black26),
                                  borderRadius: BorderRadius.all(Radius.circular(12))),
                            )),


                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(thickness: 2,),
                        SizedBox(height: 10,),
                        Text("Card Holder's Name:",style: TextStyle(color: AppColors.primary) ),
                        SizedBox(height: 10,),
                        TextSection(obscure: false,

                          labelText: '', textType: TextInputType.text, controller: Card_Model.card_HolderController,),
                        SizedBox(height: 20,),
                        Text("Card No:",

                            style: TextStyle(color: AppColors.primary) ),
                        SizedBox(height: 10,),
                        TextSection(obscure: false,

                          labelText: '', textType: TextInputType.text, controller: Card_Model.cardNoController,),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Text('Card No:',style: TextStyle(color: AppColors.primary)),
                            SizedBox(width: 130,),
                            Text('Cvv:',style: TextStyle(color: AppColors.primary)),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(child: TextSection(obscure: false, labelText: '', textType: TextInputType.text, controller: Card_Model.exDateController,),),

                            SizedBox(width: 10,),
                            Expanded(child: TextSection(obscure: false, labelText: '', textType: TextInputType.text, controller: Card_Model.cvvController,), )
                          ],
                        ),
                        SizedBox(height: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock, color: AppColors.primary,),
                          ],
                        ),
                        Center(child:  Text('We would never share your card\n information with anyone', textAlign: TextAlign.center, style: TextStyle( color: AppColors.primary),),),
                        SizedBox(height: 20,),
                        Center(child: SizedBox(
                          width: 240,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              Routers.pushNamed(context, '/reg_success');
                            },
                            child: const Text("Add card"),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
                              backgroundColor: MaterialStateProperty.all(AppColors.primary),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                            ),
                          ),),)

                      ]
                  ),
                )

            )
        ));
  }
}