import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/shared/styles/google_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.initialValue,
    this.label,
    required this.hint,
    this.isPassword = false,
    this.isRequired = false,
    this.requiredText = "Input type cannot be empty",
    this.maxLength,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? initialValue;
  final String? label;
  final String hint;
  final bool isPassword;
  final bool isRequired;
  final String requiredText;
  final int? maxLength;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    var text2 = Text(
      label ?? "",
      style: GoogleTextStyle.fw400.copyWith(
        fontSize: 14.sp,
        color: MainColor.black,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        label != null ? text2 : SizedBox(),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: isPassword,
          maxLength: maxLength,
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleTextStyle.fw400.copyWith(
              fontSize: 14.sp,
              color: MainColor.grey,
            ),
            counterText: "",
            contentPadding: EdgeInsets.symmetric(vertical: 10.h),
            suffixIcon: suffixIcon,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: MainColor.grey,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: MainColor.grey,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: MainColor.primary,
              ),
            ),
          ),
          onChanged: (text) {
            controller.text = text;
          },
          validator: (String? value) {
            if (isRequired == true) {
              String trim = value!.trim();
              if (trim.isEmpty) {
                return requiredText;
              }
            }

            return null;
          },
          style: GoogleTextStyle.fw400.copyWith(
            fontSize: 14.sp,
            color: MainColor.black,
          ),
        )
      ],
    );
  }
}
