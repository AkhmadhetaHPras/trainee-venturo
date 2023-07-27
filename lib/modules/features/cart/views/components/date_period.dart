import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class DatePeriod extends StatelessWidget {
  final int periodeMulai;
  final int periodeSelesai;

  const DatePeriod({
    super.key,
    required this.periodeMulai,
    required this.periodeSelesai,
  });

  String _formatTimestampToDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    String tanggalMulai = _formatTimestampToDate(periodeMulai);
    String tanggalSelesai = _formatTimestampToDate(periodeSelesai);

    return Text(
      '$tanggalMulai - $tanggalSelesai',
      style: GoogleTextStyle.fw400.copyWith(
        fontSize: 16.sp,
      ),
    );
  }
}
