import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final String? selectedValue;
  final String Function(T) getLabel;
  final String Function(T) getValue;
  final ValueChanged<String?> onChanged;
  final String? labelText;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.getLabel,
    required this.getValue,
    required this.onChanged,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items:
          items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: getValue(item),
                  child: Text(getLabel(item)),
                ),
              )
              .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(labelText: labelText),
      style: Theme.of(context).textTheme.bodyMedium,
      validator: (val) => val == null ? 'required'.tr() : null,
    );
  }
}
