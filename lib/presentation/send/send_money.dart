import 'package:blocknet/presentation/widgets/common_button.dart';
import 'package:blocknet/presentation/widgets/common_text_field.dart';
import  'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'confirm_send.dart';

class SendMoney extends StatefulWidget {
  final double currentBalance;
  const SendMoney({super.key,required this.currentBalance});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  double finalBalance = 0.0;

  @override
  void initState() {
    super.initState();
    finalBalance = widget.currentBalance;
    amountController.addListener(updateFinalBalance);
  }

  @override
  void dispose() {
    amountController.removeListener(updateFinalBalance);
    super.dispose();
  }

  void updateFinalBalance() {
    setState(() {
      final double amount = double.tryParse(amountController.text) ?? 0.0;
      finalBalance = widget.currentBalance - amount;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Send', style: GoogleFonts.jetBrainsMono(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('Receiver\'s wallet address', style: GoogleFonts.jetBrainsMono(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            CustomTextField(
              hintText: 'Enter Wallet Address',
              controller: addressController,
            ),
            SizedBox(height: 20.0),
            Text('Amount', style: GoogleFonts.jetBrainsMono(fontSize: 20.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            CustomTextField(
              hintText: 'Enter Amount',
              controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),]
            ),
            SizedBox(height: 50.0),
            Text("Current Balance: ", style: GoogleFonts.jetBrainsMono(fontSize: 25.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text("\$ ${widget.currentBalance}", style: GoogleFonts.jetBrainsMono(fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 30.0),
            Text("Final Balance: ", style: GoogleFonts.jetBrainsMono(fontSize: 25.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text("\$ ${finalBalance.toStringAsFixed(2)}",
              style: GoogleFonts.jetBrainsMono(fontSize: 30.0, fontWeight: FontWeight.bold)),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 60,
          child: CommonButton(
            buttonText: 'Send Amount',
            textColor: Colors.white,
            onClick: () {
              if (amountController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter an amount'))
                );
              } else if (addressController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a receiver\'s wallet address'))
                );
              } else if (finalBalance <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Insufficient balance'))
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SendConfirm(
                      receiverAddress: addressController.text,
                      amount: double.parse(amountController.text)
                    )
                  )
                );
              }
            },
            buttonColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
