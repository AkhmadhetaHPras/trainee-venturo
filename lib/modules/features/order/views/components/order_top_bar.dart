import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class OrderTopBar extends StatelessWidget implements PreferredSizeWidget {
  const OrderTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10,
            spreadRadius: -1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TabBar(
        tabs: const [
          Tab(text: 'Sedang Berjalan'),
          Tab(text: 'Riwayat'),
        ],
        indicatorColor: MainColor.primary,
        indicatorWeight: 3.h,
        labelColor: MainColor.primary,
        unselectedLabelColor: MainColor.dark,
        labelStyle: GoogleTextStyle.fw600.copyWith(
          fontSize: 20.sp,
        ),
        indicatorPadding: EdgeInsets.symmetric(horizontal: 70.w),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
