import 'package:flutter/widgets.dart';
import 'package:provider_shop_edituser/models/item.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> _items = [
    Item(
      id: 'i1',
      name: 'ปากกาสีน้ำเงิน',
      description: 'หมึกเจล เขียนลื่น',
      price: 25.0,
    ),
    Item(
      id: 'i2',
      name: 'สมุดบันทึกปกแข็ง',
      description: 'ขนาด A5, 120 แกรม',
      price: 89.0,
    ),
    Item(
      id: 'i3',
      name: 'คลิปหนีบกระดาษ',
      description: 'กล่องละ 50 ชิ้น, สีเงิน',
      price: 30.0,
    ),
  ];

  List<Item> get items => _items;

  Item findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void updateItem(String id, Item newItemData) {
    final itemIndex = _items.indexWhere((item) => item.id == id);
    if (itemIndex >= 0) {
      _items[itemIndex] = newItemData;
      notifyListeners();
    }
  }
}
