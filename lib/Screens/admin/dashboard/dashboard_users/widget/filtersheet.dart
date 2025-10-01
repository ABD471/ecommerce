import 'package:flutter/material.dart';

void showFilterSheet(
    {required BuildContext context,
    required Function(String, String, String) onApplyFilter,
    required String status,
    required String data,
    required String role}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      String selectedStatus = status;
      String selectedDate = data;
      String selectedRole = role;

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('فلترة حسب الحالة',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8,
                  children:
                      ['all', 'active', 'request', 'unactive'].map((status) {
                    return ChoiceChip(
                      label: Text(status),
                      selected: selectedStatus == status,
                      onSelected: (_) =>
                          setState(() => selectedStatus = status),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text('فلترة حسب التاريخ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8,
                  children: ['الأحدث', 'الأقدم'].map((date) {
                    return ChoiceChip(
                      label: Text(date),
                      selected: selectedDate == date,
                      onSelected: (_) => setState(() => selectedDate = date),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text('فلترة حسب الدور',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8,
                  children: ['all', 'admin', 'user', 'vendor'].map((role) {
                    return ChoiceChip(
                      label: Text(role),
                      selected: selectedRole == role,
                      onSelected: (_) => setState(() => selectedRole = role),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C3E50),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  icon: const Icon(Icons.check),
                  label: const Text('تطبيق الفلاتر'),
                  onPressed: () {
                    onApplyFilter(selectedStatus, selectedDate, selectedRole);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
