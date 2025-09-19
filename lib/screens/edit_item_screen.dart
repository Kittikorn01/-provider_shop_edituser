// lib/screens/edit_item_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/item_provider.dart';

class EditItemScreen extends StatefulWidget {
  static const routeName = '/edit-item';
  const EditItemScreen({super.key});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _itemId;
  late Item _editedItem;
  bool _isInit = true;

  // ใช้ TextEditingController เพื่อควบคุมค่าใน TextFormField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _itemId = ModalRoute.of(context)!.settings.arguments as String;
      _editedItem = Provider.of<ItemProvider>(
        context,
        listen: false,
      ).findById(_itemId);

      // ตั้งค่าเริ่มต้นให้ controller
      _nameController.text = _editedItem.name;
      _descController.text = _editedItem.description;
      _priceController.text = _editedItem.price.toString();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // คืนทรัพยากร controller เมื่อวิดเจ็ตถูกทำลาย
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    // ใช้ context.read เพื่อเรียกเมธอดจาก Provider
    context.read<ItemProvider>().updateItem(_itemId, _editedItem);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขรายละเอียดสินค้า'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'ชื่อสินค้า'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) return 'กรุณาป้อนชื่อสินค้า';
                  return null;
                },
                onSaved: (value) {
                  _editedItem = Item(
                    id: _editedItem.id,
                    name: value!,
                    description: _editedItem.description,
                    price: _editedItem.price,
                  );
                },
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'รายละเอียด'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) return 'กรุณาป้อนรายละเอียด';
                  return null;
                },
                onSaved: (value) {
                  _editedItem = Item(
                    id: _editedItem.id,
                    name: _editedItem.name,
                    description: value!,
                    price: _editedItem.price,
                  );
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'ราคา'),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'กรุณาป้อนราคา';
                  if (double.tryParse(value) == null)
                    return 'กรุณาป้อนตัวเลขที่ถูกต้อง';
                  if (double.parse(value) <= 0) return 'ราคาต้องมากกว่า 0';
                  return null;
                },
                onSaved: (value) {
                  _editedItem = Item(
                    id: _editedItem.id,
                    name: _editedItem.name,
                    description: _editedItem.description,
                    price: double.parse(value!),
                  );
                },
                onFieldSubmitted: (_) => _saveForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
