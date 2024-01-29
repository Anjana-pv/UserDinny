import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFontText extends StatelessWidget {
  final customeText;
  final size;
 final FontWeight? type;
   GoogleFontText({
    super.key,
  required this.customeText, 
   required  this.size,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
    customeText,
    style: GoogleFonts.lemon(
      textStyle:  TextStyle(
        fontSize: size,
        fontWeight: type,
      ),
    ),
    );
  }
}
