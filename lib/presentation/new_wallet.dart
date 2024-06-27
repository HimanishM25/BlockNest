import 'package:blocknet/data/functions/transaction_handler.dart';
import 'package:blocknet/domain/transaction_navigation.dart';
import 'package:blocknet/presentation/homescreen.dart';
import 'package:blocknet/presentation/authentication/signup.dart';
import 'package:blocknet/presentation/navigation/navigation.dart';
import 'package:blocknet/presentation/widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class NewWallet extends StatefulWidget {
  const NewWallet({super.key});

  @override
  State<NewWallet> createState() => _NewWalletState();
}

class _NewWalletState extends State<NewWallet> {
  TextEditingController nameController = TextEditingController();
   final TextEditingController passcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2C2C2C),
      body:
       SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Create New Wallet', style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,)),
              SizedBox(height: 50.0),
              Text("Wallet Name", style: TextStyle(fontSize: 20.0, color: Colors.white)),
              SizedBox(height: 5.0),
              CustomTextField(
                  hintText: 'Eg. Himanish\'s Wallet',
                  controller: nameController),
              SizedBox(height: 30.0),
              const Text("Wallet Passcode", style: TextStyle(fontSize: 20.0, color: Colors.white)),
              SizedBox(height: 5.0),
              CustomTextField(
                hintText: 'Passcode',
                isPassword: true,
                controller: passcodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),]
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: TextButton(
              onPressed: (){
                if (nameController.text.isNotEmpty&& passcodeController.text.length >= 6) {
                  createWalletNavigate(nameController.text, passcodeController.text, context);
                } else if (passcodeController.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a passcode'),
                    ),
                  );
                }else if (passcodeController.text.length < 6){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Passcode must be at least 6 characters long'),
                    ),
                  );
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter wallet name'),
                    ),
                  );
                }
              },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  shape: WidgetStateProperty.all<CircleBorder>(
                    const CircleBorder(),
                  ),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.black, size: 30.0),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
