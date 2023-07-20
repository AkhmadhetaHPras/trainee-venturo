import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class OptionChip extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function()? onTap;

  const OptionChip({
    Key? key,
    this.isSelected = false,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        decoration: BoxDecoration(
          border: Border.all(
            color: MainColor.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30.r),
          color: isSelected ? MainColor.primary : MainColor.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleTextStyle.fw400.copyWith(
                    color: isSelected ? MainColor.white : MainColor.dark,
                    fontSize: 12.sp,
                  ),
                ),
                isSelected
                    ? const Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: MainColor.white,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
