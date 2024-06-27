import 'package:blocknet/domain/transaction_navigation.dart';
import 'package:blocknet/presentation/request/request_successful.dart';
import 'package:blocknet/presentation/widgets/common_button.dart';
import 'package:blocknet/presentation/widgets/common_text_field.dart';
import  'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestMoney extends StatefulWidget {
  const RequestMoney({super.key});

  @override
  State<RequestMoney> createState() => _RequestMoneyState();
}

class _RequestMoneyState extends State<RequestMoney> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Request', style: GoogleFonts.jetBrainsMono(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sender\'s wallet address', style: GoogleFonts.jetBrainsMono(fontSize: 20.0, fontWeight: FontWeight.bold)),
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 60,
          child: CommonButton(
            buttonText: 'Request Amount',
            textColor: Colors.white,
            onClick: () {
              requestFundsNavigate(double.parse(amountController.text), addressController.text, context);
            },
            buttonColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
