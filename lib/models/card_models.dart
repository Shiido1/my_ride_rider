import 'package:flutter/material.dart';

import 'global_model.dart';

class CardModel{

  final TextEditingController cardHolderController = TextEditingController(text: cardHolder);
  final TextEditingController cardNoController = TextEditingController(text: cardno);
  final TextEditingController cvvController = TextEditingController(text: cvv);
  final TextEditingController monthController = TextEditingController(text: month);
  final TextEditingController yearController = TextEditingController(text: year);
  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();

  bool isLoading = false;
}