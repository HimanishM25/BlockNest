import 'package:blocknet/presentation/widgets/common_button.dart';
import 'package:blocknet/presentation/widgets/common_text_field.dart';
import  'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../navigation/navigation.dart';

class SendSuccess extends StatefulWidget {
  final double amount;
  const SendSuccess({super.key, required this.amount});

  @override
  State<SendSuccess> createState() => _SendSuccessState();
}

class _SendSuccessState extends State<SendSuccess> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.0),
              Text("Sent Successfully! ", style: GoogleFonts.jetBrainsMono(fontSize: 25.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
              SizedBox(height: 10.0),
              Text("\$ ${widget.amount}", style: GoogleFonts.jetBrainsMono(fontSize: 30.0, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ]))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 60,
          child: CommonButton(
            buttonText: 'Return Home',
            textColor: Colors.white,
            onClick: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Navigation()),
                    (Route<dynamic> route) => false,
              );
            },
            buttonColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
