import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_vendor.dart/widget/cardvendor.dart';
import 'package:ecommerce_flutter/controllers/admin/dashboard_vendors/vendors_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorsController controller = Get.put(VendorsController());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // AppBar الأول: التصفية وتحديد متعدد
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: theme.appBarTheme.backgroundColor,
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => DropdownButtonFormField<String>(
                        initialValue: controller.selectedStatus.value == 'all'
                            ? 'الكل'
                            : controller.selectedStatus.value,
                        items: ['الكل', 'approved', 'pending', 'rejected']
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status,
                                      style: TextStyle(color: theme.cardColor)),
                                ))
                            .toList(),
                        onChanged: (value) {
                          final status = value == 'الكل' ? 'all' : value!;
                          controller.applyFilter(
                              status, controller.selectedDate.value);
                        },
                        decoration: InputDecoration(
                          labelText: 'تصفية حسب الحالة',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: theme.appBarTheme.backgroundColor
                              ?.withOpacity(0.2),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        dropdownColor: theme.appBarTheme.backgroundColor,
                      )),
                ),
                SizedBox(width: 12),
                Icon(Icons.filter_list, color: Colors.white),
              ],
            ),
          ),

          // AppBar الثاني: البحث
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: theme.cardColor,
            child: TextField(
              onChanged: (value) {
                controller.searchQuery = value;
                controller.resetAndReload();
              },
              decoration: InputDecoration(
                hintText: 'ابحث عن متجر...',
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),

          // قائمة البطاقات
          Expanded(
            child: Obx(() {
              final vendors = controller.filteredVendors;
              if (vendors.isEmpty) {
                return Center(child: Text('لا توجد بيانات حالياً'));
              }

              return ListView.builder(
                itemCount: vendors.length,
                itemBuilder: (context, index) {
                  final vendor = vendors[index];
                  return VendorCard(vendor: vendor);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
