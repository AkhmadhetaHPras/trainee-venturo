import 'package:flutter/material.dart';

import '../../../../../configs/themes/main_color.dart';

class QuantityCounter extends StatelessWidget {
  final int quantity;
  final void Function() onIncrement;
  final void Function() onDecrement;

  const QuantityCounter({
    Key? key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: quantity > 1 ? onDecrement : () {},
            icon: Icon(
              Icons.indeterminate_check_box_outlined,
              color: quantity > 1 ? MainColor.primary : MainColor.grey,
            ),
          ),
        ),
        Text(
          quantity.toString(),
        ),
        Material(
          color: Colors.transparent,
          child: IconButton(
            onPressed: onIncrement,
            icon: const Icon(
              Icons.add_box_outlined,
            ),
          ),
        ),
      ],
    );
  }
}