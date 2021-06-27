import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyMatched extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        'No users found',
        style: GoogleFonts.nanumGothic(
            fontSize: 18, wordSpacing: 1.2, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )),
    );
  }
}
