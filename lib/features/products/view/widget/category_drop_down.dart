import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final List<String> categories = [
    'Sports',
    'Electronics',
    'Collections',
    'Book',
    'Game',
    'Bikes',
  ];



  CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.onChanged,required this.validator,
  });
  final String? selectedCategory;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      decoration: const InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(),
      ),
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
