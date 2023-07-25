import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../configs/themes/main_color.dart';
import '../../../../../shared/customs/text_form_field_custom.dart';
import '../../../../../shared/styles/google_text_style.dart';
import '../../../cart/controllers/edit_menu_cart_controller.dart';
import '../../controllers/detail_menu_controller.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({
    super.key,
    this.edit,
  });

  final bool? edit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: () => showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.0),
            ),
          ),
          context: context,
          builder: (context) => Container(
            width: double.infinity,
            height: 150,
            padding: EdgeInsets.symmetric(
              horizontal: 25.w,
              vertical: 25.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.r),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(111, 24, 24, 24),
                  blurRadius: 15,
                  spreadRadius: -1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Buat Catatan",
                  style: GoogleTextStyle.fw700.copyWith(
                    fontSize: 18.sp,
                    color: MainColor.dark,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormFieldCustom(
                        controller: edit != null && edit == true
                            ? EditMenuCartController.to.catatanTextController
                            : DetailMenuController.to.catatanTextController,
                        keyboardType: TextInputType.text,
                        initialValue: edit != null && edit == true
                            ? EditMenuCartController.to.catatan.value
                            : DetailMenuController.to.catatan.value,
                        hint: "Catatan",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (edit != null && edit == true) {
                          EditMenuCartController.to.catatan.value =
                              EditMenuCartController
                                  .to.catatanTextController.text;
                        } else {
                          DetailMenuController.to.catatan.value =
                              DetailMenuController
                                  .to.catatanTextController.text;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(24, 24),
                        shape: const CircleBorder(),
                        backgroundColor: MainColor.primary,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.edit_note),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Catatan",
              style: GoogleTextStyle.fw600
                  .copyWith(fontSize: 16, color: MainColor.dark),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            SizedBox(
              width: 150,
              child: Obx(
                () => Text(
                  edit != null && edit == true
                      ? EditMenuCartController.to.catatan.value
                      : DetailMenuController.to.catatan.value,
                  style: GoogleTextStyle.fw400
                      .copyWith(fontSize: 18, color: MainColor.dark),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: MainColor.grey,
            ),
          ],
        ),
      ),
    );
  }
}
