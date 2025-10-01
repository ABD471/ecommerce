import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:ecommerce_flutter/controllers/admin/dashboard_users/users_controller.dart';
import 'package:ecommerce_flutter/models/dashboard_users_model.dart';
import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_users/widget/carduser.dart';
import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_users/widget/filtersheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UsersController controller = Get.put(UsersController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.loadUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        controller.loadUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Obx(() => Text(
              controller.isMultiSelectMode.value
                  ? 'تحديد (${controller.selectedEmails.length})'
                  : 'لوحة المدير',
              style: textTheme.headlineMedium,
            )),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              showFilterSheet(
                onApplyFilter: controller.applyFilter,
                data: controller.selectedDate.value,
                role: controller.selectedRole.value,
                status: controller.selectedStatus.value,
                context: context,
              );
            },
          ),
          IconButton(
            icon: Obx(() => Icon(
                  controller.isMultiSelectMode.value
                      ? Icons.close
                      : Icons.select_all,
                  color: Colors.white,
                  size: 30,
                )),
            onPressed: () {
              controller.isMultiSelectMode.value =
                  !controller.isMultiSelectMode.value;
              controller.selectedEmails.clear();
            },
          ),
        ],
        bottom: AppBar(
          flexibleSpace: AnimatedSearchBar(
            label: "search email or username",
            onChanged: (value) {
              controller.searchQuery = value;
              controller.resetAndReload();
            },
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isloading.value && controller.filteredUsers.isEmpty) {
          return Center(
            child: Lottie.asset('assets/lottie/Loading.json',
                height: 30.h, width: 20.w),
          );
        }

        return RefreshIndicator(
          color: colorScheme.primary,
          backgroundColor: theme.scaffoldBackgroundColor,
          onRefresh: () async {
            controller.resetAndReload();
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  itemCount: controller.filteredUsers.length +
                      (controller.hasMore.value ? 1 : 1),
                  itemBuilder: (context, index) {
                    if (index < controller.filteredUsers.length) {
                      final User user = controller.filteredUsers[index];
                      final isSelected =
                          controller.selectedEmails.contains(user.email);
                      return AnimatedUserCard(
                        onDismissedStarttoend: (useremail) {
                          controller.onDismissedStarttoend(useremail);
                        },
                        onDismissedendtostart: (useremail) {
                          controller.onDismissedendtostart(useremail);
                        },
                        user: user,
                        index: index,
                        isSelected: isSelected,
                        isMultiSelectMode: controller.isMultiSelectMode.value,
                        onTap: () => controller.toggleSelection(user.email),
                      );
                    } else {
                      if (controller.hasMore.value) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              'لا يوجد المزيد من المستخدمين',
                              style: textTheme.bodyMedium,
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              if (controller.isMultiSelectMode.value)
                Container(
                  padding: const EdgeInsets.only(bottom: 60),
                  color: theme.cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                            ),
                            icon: const Icon(Icons.select_all),
                            label: const Text('تحديد الكل'),
                            onPressed: () {
                              controller.selectedEmails.assignAll(
                                controller.filteredUsers.map((u) => u.email),
                              );
                            },
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colorScheme.onSurface,
                              side:
                                  BorderSide(color: colorScheme.surfaceVariant),
                            ),
                            icon: const Icon(Icons.clear),
                            label: const Text('إلغاء التحديد'),
                            onPressed: () {
                              controller.selectedEmails.clear();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (controller.selectedEmails.isNotEmpty)
                        Row(
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade700,
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.check),
                              label: const Text('موافقة جماعية'),
                              onPressed: () =>
                                  controller.applyBulkAction('active'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade700,
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.close),
                              label: const Text('رفض جماعي'),
                              onPressed: () =>
                                  controller.applyBulkAction('unactive'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
