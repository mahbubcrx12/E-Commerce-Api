import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.icon,
    this.keytype,
    this.lebelText,
    this.maxNumber,
    this.controller,
    this.function,
    this.data,
    this.hintText,
    this.initialText,
    this.suffixIcon,
    this.formatter,
    this.prefixIcon
    //this.obscuretext,
  });
  final TextEditingController? controller;
  final dynamic? data;
  final IconData? icon;
  final dynamic? suffixIcon;
  final String? initialText;
  final dynamic? function;
  final String? hintText;
  final int? maxNumber;
  final String? lebelText;
  final dynamic? formatter;
  final dynamic? keytype;
  final dynamic prefixIcon;
  //final bool obscuretext;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*.70,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        //showCursor: true,
        minLines: 1,
        maxLines: maxNumber ?? 1,
        initialValue: initialText,
        keyboardType: keytype,
        controller: controller,
        inputFormatters: formatter,
        //obscureText: obscuretext,
        validator: function,
        //onSaved: (String value) => data[keyy] = value,
        onChanged: (initialText) => {},
        autofocus: false,
        style: TextStyle(fontSize: 14.0, color: Colors.white70),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              gapPadding: 5.0,
              borderSide: BorderSide(color: Colors.teal, width: 3)),
          labelText: lebelText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelStyle: TextStyle(color: Colors.white60, fontSize: 16),
          hintText: hintText,
        ),
      ),
    );
  }
}
