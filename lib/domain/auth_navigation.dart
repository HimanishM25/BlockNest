import 'package:flutter/material.dart';
import '../data/functions/auth_handler.dart';
import '../presentation/navigation/navigation.dart';
import '../presentation/new_wallet.dart';

void checkLoginAndNavigate(BuildContext context, String username, String password) async {
  int loginSuccessful = await loginUser(username, password);

  if (loginSuccessful==1) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigation()));
  } else if (loginSuccessful==2) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewWallet()));
  } else{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Something went wrong'),
      ),
    );
  }
}