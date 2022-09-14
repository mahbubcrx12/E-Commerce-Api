import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
myStyle(double fs,Color ?clr,[FontWeight ?fw]){
  return GoogleFonts.roboto(
    fontSize: fs,
    color: clr,
    fontWeight: fw,
  );
}

String baseUrl="https://apihomechef.antopolis.xyz/";