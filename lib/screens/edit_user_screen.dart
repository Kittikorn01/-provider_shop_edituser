import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_profile_provider.dart';

class EditUserScreen extends StatefulWidget {
  static const routeName = '/edit-user';

  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final currentName = context.read<UserProfileProvider>().username;
    _controller = TextEditingController(text: currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;

    final newName = _controller.text.trim();
    context.read<UserProfileProvider>().changeUsername(newName);

    ScaffoldMessenger.of(context);
    Navigator.of(context).pop(newName); // ส่งค่ากลับ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('แก้ไขชื่อผู้ใช้')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'ใส่ชื่อผู้ใช้ใหม่',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _save(),
                validator: (value) {
                  final v = (value ?? '').trim();
                  if (v.isEmpty) return 'กรุณากรอกชื่อผู้ใช้';
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('บันทึก'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
