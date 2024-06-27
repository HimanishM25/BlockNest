import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onClick;
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  CommonButton({
    required this.onClick,
    required this.buttonText,
    required this.textColor,
    required this.buttonColor,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
        foregroundColor: textColor, backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null)
            Icon(leadingIcon, color: textColor),
          Text(buttonText,style:GoogleFonts.jetBrainsMono(fontSize: 20.0,fontWeight: FontWeight.bold,color: textColor)),
          if (trailingIcon != null)
            Icon(trailingIcon, color: textColor),
        ],
      ),
    );
  }
}