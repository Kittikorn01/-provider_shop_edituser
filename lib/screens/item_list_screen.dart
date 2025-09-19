import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shop_edituser/providers/item_provider.dart';
import 'package:provider_shop_edituser/providers/user_profile_provider.dart';
import 'package:provider_shop_edituser/screens/edit_item_screen.dart';
import 'package:provider_shop_edituser/screens/edit_user_screen.dart';

class ItemListScreen extends StatelessWidget {
  static const routeName = '/';
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserProfileProvider>(
          builder: (context, userProfileProvider, child) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  EditUserScreen.routeName,
                  arguments: userProfileProvider.username, // จะส่งไปด้วยก็ได้
                );
              },
              child: Text(
                'รายการสินค้า (ผู้ใช้: ${userProfileProvider.username})',
                style: const TextStyle(fontSize: 18),
              ),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 105, 120, 128),
      ),

      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, chid) {
          return ListView.builder(
            itemCount: itemProvider.items.length,
            itemBuilder: (context, ind) {
              final item = itemProvider.items[ind];
              return ListTile(
                title: Text('${item.name}'),
                subtitle: Text('${item.description}'),
                trailing: Text('${item.price} บาท'),
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(EditItemScreen.routeName, arguments: item.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
