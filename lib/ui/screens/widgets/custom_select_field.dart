import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';

class SelectItem {
  final int id;
  final String descricao;

  SelectItem({required this.id, required this.descricao});
}

class CustomSelectField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final List<SelectItem> items;
  final int? selectedId;
  final ValueChanged<int?> onChanged;

  const CustomSelectField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.selectedId,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: selectedId,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      dropdownColor: AppColors.inputBackground,
      icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
      style: const TextStyle(color: AppColors.textLight),
      items:
          items.map((SelectItem item) {
            return DropdownMenuItem<int>(value: item.id, child: Text(item.descricao));
          }).toList(),
      onChanged: onChanged,
    );
  }
}
