import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemVoucher extends StatelessWidget {
  const ItemVoucher({super.key, required this.name, required this.info});

  final String name;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  name,
                ),
              ),
            ),
            Checkbox(value: false, onChanged: (value) {})
          ],
        ),
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            image: DecorationImage(
              image: CachedNetworkImageProvider(info),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
