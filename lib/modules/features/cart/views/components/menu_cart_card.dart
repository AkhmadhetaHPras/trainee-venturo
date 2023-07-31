import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/global_controllers/cart_controller.dart';
import 'package:trainee/modules/global_models/menu_cart.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class MenuCartCard extends StatelessWidget {
  final MenuCart menu;
  final int index;

  const MenuCartCard({
    Key? key,
    required this.menu,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(MainRoute.cartEditMenu, arguments: {
          'index': index,
          'idMenu': menu.idMenu,
          'toppings': menu.topping,
          'level': menu.level,
          'catatan': menu.catatan ?? ""
        });
      },
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        padding: EdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            // menu image
            Container(
              height: 90.h,
              width: 90.w,
              margin: EdgeInsets.only(right: 12.r),
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey[100],
              ),
              child: CachedNetworkImage(
                imageUrl: menu.foto ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                useOldImageOnUrlChange: true,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // menu info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Rp. ${menu.harga}",
                    style: Get.textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.edit_note),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          menu.catatan ?? "Tambahkan Catatan",
                          style: GoogleTextStyle.fw500.copyWith(
                            fontSize: 12.sp,
                            color: menu.catatan == null
                                ? MainColor.grey
                                : MainColor.dark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Obx(
                    () => IconButton(
                      onPressed: CartController.to.cartItems[index].jumlah > 1
                          ? () {
                              CartController.to.updateCartItem(
                                index,
                                MenuCart(
                                  idMenu: menu.idMenu,
                                  harga: menu.harga,
                                  level: menu.level,
                                  topping: menu.topping,
                                  jumlah: menu.jumlah - 1,
                                  nama: menu.nama,
                                  catatan: menu.catatan,
                                  deskripsi: menu.deskripsi,
                                  foto: menu.foto,
                                  kategori: menu.kategori,
                                ),
                              );
                            }
                          : () {
                              CartController.to.removeFromCart(menu);
                              if (CartController.to.cartItems.isEmpty) {
                                Get.back();
                              }
                            },
                      icon: Icon(
                        CartController.to.cartItems[index].jumlah > 1
                            ? Icons.indeterminate_check_box_outlined
                            : Icons.delete,
                        color: CartController.to.cartItems[index].jumlah > 1
                            ? MainColor.primary
                            : MainColor.danger,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    CartController.to.cartItems[index].jumlah.toString(),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      CartController.to.updateCartItem(
                        index,
                        MenuCart(
                          idMenu: menu.idMenu,
                          harga: menu.harga,
                          level: menu.level,
                          topping: menu.topping,
                          jumlah: menu.jumlah + 1,
                          nama: menu.nama,
                          catatan: menu.catatan,
                          deskripsi: menu.deskripsi,
                          foto: menu.foto,
                          kategori: menu.kategori,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_box_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
