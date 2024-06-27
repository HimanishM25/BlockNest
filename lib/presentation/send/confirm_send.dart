import 'package:blocknet/domain/transaction_navigation.dart';
import 'package:blocknet/presentation/send/send_successful.dart';
import 'package:blocknet/presentation/widgets/common_button.dart';
import 'package:blocknet/presentation/widgets/common_text_field.dart';
import  'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class SendConfirm extends StatefulWidget {
  final double amount;
  final String receiverAddress;
  const SendConfirm({super.key, required this.receiverAddress, required this.amount});

  @override
  State<SendConfirm> createState() => _SendConfirmState();
}

class _SendConfirmState extends State<SendConfirm> {
  String pin = "";
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.0),
              Text("Sending: ", style: GoogleFonts.jetBrainsMono(fontSize: 25.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
              SizedBox(height: 10.0),
              Text("\$ ${widget.amount}", style: GoogleFonts.jetBrainsMono(fontSize: 30.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(height: 30.0),
              PinInputTextField(
                pinLength: 6,
                decoration: BoxLooseDecoration(
                  strokeColorBuilder: PinListenColorBuilder(Colors.green, Colors.black),
                  radius: Radius.circular(5),
                ),
                onChanged: (value) {
                  setState(() {
                    pin = value;
                  });
                },
                autoFocus: true,
              ),
            ],
          ),
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
              if (pin.length == 6) {
                sendFundsNavigate(widget.amount, widget.receiverAddress, pin, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter your pin'))
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
