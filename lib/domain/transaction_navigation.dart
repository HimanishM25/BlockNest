import 'package:blocknet/presentation/request/request_successful.dart';

import '../data/functions/transaction_handler.dart';
import 'package:flutter/material.dart';

import '../presentation/navigation/navigation.dart';
import '../presentation/send/send_successful.dart';
void sendFundsNavigate(double amount, String receiverAddress,String pin,BuildContext context,) async {
  bool result = await sendFunds(amount, receiverAddress, pin);
  if (result) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SendSuccess(amount: amount,)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Something went wrong'))
    );
  }
}

void requestFundsNavigate(double amount, String sendersAddress,BuildContext context,) async {
  bool result = await requestFunds(amount, sendersAddress);
  if (result) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RequestSuccess(amount: amount,)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Something went wrong'))
    );
  }
}

void createWalletNavigate(String walletName, String pin, BuildContext context,) async {
  bool result = await createWallet(walletName, pin);
  if (result) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation()));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Something went wrong'))
    );
  }
}

