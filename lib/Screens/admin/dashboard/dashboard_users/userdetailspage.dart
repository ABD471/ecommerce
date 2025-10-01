import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_users/widget/details_user.dart';
import 'package:ecommerce_flutter/controllers/admin/dashboard_users/userdetails_controller.dart';
import 'package:ecommerce_flutter/models/dashboard_users_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    UserDetailsController controller = Get.put(UserDetailsController());
    var emailold = user.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        actions: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(user.name![0], style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCardField(context,
                    icon: Icons.person,
                    initialValue: user.name,
                    label: "UserName", onChanged: (value) {
                  user.name = value;
                }),
                const SizedBox(height: 25),
                buildCardField(context, icon: Icons.email, onChanged: (value) {
                  user.email = value;
                }, initialValue: user.email, label: "Email"),
                const SizedBox(height: 25),
                buildRoleDropdown(
                    onChanged: (value) {
                      user.status = value;
                    },
                    context: context,
                    selectedRole: user.status.toString().trim().toLowerCase(),
                    label: "Status",
                    itemvalue1: "request",
                    itemvalue2: "unactive",
                    itemvalue3: "active"),
                buildRoleDropdown(
                    context: context,
                    onChanged: (value) {
                      user.role = value;
                    },
                    selectedRole: user.role,
                    label: "Role",
                    itemvalue1: "user",
                    itemvalue2: "vendor",
                    itemvalue3: "admin"),
                const SizedBox(height: 25),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    controller.updateUser(user, emailold);
                  },
                  child: const Text('حفظ التعديلات'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
