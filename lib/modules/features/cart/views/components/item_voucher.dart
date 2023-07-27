import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/global_controllers/cart_controller.dart';
import 'package:trainee/modules/global_models/voucher.dart';

class ItemVoucher extends StatelessWidget {
  const ItemVoucher({
    super.key,
    required this.voucher,
    required this.onChanged,
  });

  final VoucherData voucher;
  final Function(int, bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(MainRoute.detailVoucher, arguments: {'data': voucher});
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    voucher.nama ?? "",
                  ),
                ),
              ),
              Checkbox(
                  value: voucher.checked,
                  onChanged: (value) {
                    int index = CartController.to.vouchers.indexOf(
                        CartController.to.vouchers.firstWhere(
                            (voucherI) => voucherI.nama == voucher.nama));
                    onChanged(index, value ?? false);
                  })
            ],
          ),
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              image: DecorationImage(
                image: CachedNetworkImageProvider(voucher.infoVoucher ??
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
