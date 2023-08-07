import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../shared/styles/elevated_button_style.dart';
import '../../../../../shared/styles/google_text_style.dart';

class SocialSignInButtonComponent extends StatelessWidget {
  final String buttonText; // variable teks "Social Media"
  final String iconAssetPath; // variable asset icon
  final Color backgroundColor; // variable warna latar belakang button
  final Color fontColor; // variable font color
  final void Function() onPressed; // variable fungsi callback

  const SocialSignInButtonComponent({
    Key? key,
    required this.buttonText,
    required this.iconAssetPath,
    required this.backgroundColor,
    required this.fontColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: EvelatedButtonStyle.mainRounded.copyWith(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            iconAssetPath,
            width: 24.0,
            height: 24.0,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Masuk menggunakan ',
                  style: GoogleTextStyle.fw400.copyWith(
                    fontSize: 14.sp,
                    color: fontColor,
                  ),
                ),
                TextSpan(
                  text: buttonText,
                  style: GoogleTextStyle.fw700.copyWith(
                    fontSize: 14.sp,
                    color: fontColor,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
