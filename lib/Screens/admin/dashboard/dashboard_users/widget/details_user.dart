import 'package:flutter/material.dart';

Widget buildCardField(BuildContext context,
    {required String label,
    required void Function(String)? onChanged,
    required IconData icon,
    required String initialValue}) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: (value) {
        onChanged?.call(value);
      },
    ),
  );
}

Widget buildRoleDropdown({
  required BuildContext context,
  required String selectedRole,
  required String label,
  required String itemvalue1,
  required String itemvalue2,
  required void Function(String) onChanged,
  required String itemvalue3,
}) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: DropdownButtonFormField<String>(
        initialValue: selectedRole,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.supervised_user_circle_outlined),
        ),
        icon: Icon(Icons.arrow_drop_down_circle),
        dropdownColor: Colors.white,
        style: Theme.of(context).textTheme.bodyMedium,
        items: [
          DropdownMenuItem(
            value: itemvalue1,
            child: Row(
              children: [
                Icon(Icons.person, color: Colors.green),
                SizedBox(width: 10),
                Text(itemvalue1, style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          DropdownMenuItem(
            value: itemvalue2,
            child: Row(
              children: [
                Icon(Icons.store, color: Colors.redAccent),
                SizedBox(width: 10),
                Text(itemvalue2, style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          DropdownMenuItem(
            value: itemvalue3,
            child: Row(
              children: [
                Icon(Icons.admin_panel_settings, color: Colors.orange),
                SizedBox(width: 10),
                Text(itemvalue3, style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    ),
  );
}
