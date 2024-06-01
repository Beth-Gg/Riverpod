import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocery_shopping_list/models/lists_model.dart';
import '../../../models/shops_model.dart';
import '../../../providers/shops_providers.dart';

class EditListDialog extends StatefulWidget {
  final GroceryList? shop;
  final Function(String, String) onEdit;

  EditListDialog({this.shop, required this.onEdit});

  @override
  _EditListDialogState createState() => _EditListDialogState();
}

class _EditListDialogState extends State<EditListDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _itemsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.shop?.date ?? '');
    _itemsController = TextEditingController(text: widget.shop?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text(
        widget.shop == null ? 'Add List' : 'Edit List',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Shopping list title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _itemsController,
                decoration: InputDecoration(
                  labelText: 'Items',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter items';
                  }
                  return null;
                },
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
          style: TextButton.styleFrom(
            iconColor: Colors.grey,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onEdit(
                _nameController.text,
                _itemsController.text,
              );
              Navigator.of(context).pop();
            }
          },
          child: Text(widget.shop == null ? 'Add' : 'Save'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
