import 'package:flutter/material.dart';

class DropDownList extends StatelessWidget {


  DropDownList({
    super.key,
    required this.selectedCategory,
    required this.onChanged,required this.validator, required this.dropDownList, required this.text,
  });
  final List<String> dropDownList;
  final String text;

  final String? selectedCategory;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      decoration: InputDecoration(
        labelText: text,
        border: const OutlineInputBorder(),
      ),
      items: dropDownList.map((String category) {
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
