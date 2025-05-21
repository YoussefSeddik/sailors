import 'package:flutter/material.dart';

class CustomToggle extends StatelessWidget {
  final int selectedIndex;
  final List<String> labels;
  final ValueChanged<int> onChanged;

  const CustomToggle({
    super.key,
    required this.selectedIndex,
    required this.labels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(
      context,
    ).colorScheme.onSurface.withOpacity(0.3);

    final selectedColor = Theme.of(context).colorScheme.primary;
    final unselectedColor = Colors.transparent;

    final selectedTextColor = Theme.of(context).colorScheme.onPrimary;
    final unselectedTextColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      children: List.generate(labels.length, (index) {
        final isSelected = selectedIndex == index;

        return Row(
          children: [
            GestureDetector(
              onTap: () => onChanged(index),
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : unselectedColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? selectedTextColor : unselectedTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
        );
      }),
    );
  }
}
