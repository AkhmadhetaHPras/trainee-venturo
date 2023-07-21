import 'package:trainee/modules/global_models/menu.dart';
import 'package:trainee/modules/global_models/order.dart';

class OrderData {
  Order order;
  List<Menu> menu;

  OrderData({
    required this.order,
    required this.menu,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      order: Order.fromJson(json['order']),
      menu: List<Menu>.from(json['menu'].map((item) => Menu.fromJson(item))),
    );
  }
}
