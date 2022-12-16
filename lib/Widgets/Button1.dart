import 'package:flutter/material.dart';
// import 'package:zabardash/core/utils/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final String? labelText;
  final double? labelFontSize;
  final Color? labelColor;
  final double? trbr;
  final double? tlbr;
  final double? brbr;
  final double? blbr;
  final TextEditingController? controller;
  // final Function(String?)? onSaved; ////
  final bool? obscureText;
  final TextInputType? textInputType;
  final Color? fillColor;
  final Color? borderColor;
  final double? vcontentPadding;
  final double? hcontentPadding;
  final String? hintText;
  final TextStyle? hintStyle;
  final double? trfbr;
  final double? tlfbr;
  final double? brfbr;
  final double? blfbr;
  final Color? fborderColor;
  final int? maxLine;
  final int? minLine;
  final Widget? prefixIcon;

  TextFormFieldWidget({
    this.validator,
    this.textInputAction,
    this.textStyle,
    this.labelText,
    this.labelFontSize,
    this.labelColor,
    this.trbr,
    this.tlbr,
    this.brbr,
    this.blbr,
    this.controller,
    // this.onSaved,
    this.obscureText,
    this.textInputType,
    this.fillColor,
    this.borderColor,
    this.vcontentPadding,
    this.hcontentPadding,
    this.hintText,
    this.hintStyle,
    this.fborderColor,
    this.trfbr,
    this.tlfbr,
    this.brfbr,
    this.blfbr,
    this.maxLine,
    this.minLine,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator!,
      maxLines: maxLine != null ? maxLine : 1,
      minLines: minLine != null ? minLine : 1,
      obscureText: obscureText??false,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      style: textStyle,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: labelFontSize,
          color: labelColor,
        ),
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: hcontentPadding??0,vertical: vcontentPadding??0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(trbr??0),topLeft: Radius.circular(tlbr??0),bottomLeft: Radius.circular(blbr??0),bottomRight: Radius.circular(brbr??0)),
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(trfbr??0),topLeft: Radius.circular(tlfbr??0),bottomLeft: Radius.circular(blfbr??0),bottomRight: Radius.circular(brfbr??0)),
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
      ),
      controller: controller,
      // onSaved: onSaved,
    );
  }
}
