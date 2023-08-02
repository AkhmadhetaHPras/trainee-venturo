import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

import '../../../../../configs/themes/main_color.dart';

class QuantityCounter extends StatelessWidget {
  final int quantity;
  final void Function()? onIncrement;
  final void Function()? onDecrement;

  const QuantityCounter({
    Key? key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: onDecrement != null,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: quantity > 1 ? onDecrement : () {},
              icon: Icon(
                Icons.indeterminate_check_box_outlined,
                color: quantity > 1 ? MainColor.primary : MainColor.grey,
              ),
            ),
          ),
        ),
        Text(
          quantity.toString(),
          style: GoogleTextStyle.fw500.copyWith(fontSize: 18.sp),
        ),
        Visibility(
          visible: onIncrement != null,
          maintainState: true,
          maintainAnimation: true,
          maintainSize: true,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: onIncrement,
              icon: const Icon(
                Icons.add_box_outlined,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
