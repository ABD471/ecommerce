import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_vendor.dart/vendordetils/vendoradminactiontab.dart';
import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_vendor.dart/vendordetils/vendorproductstab.dart';
import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_vendor.dart/vendordetils/vendorstatisticstab.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/models/dashboard_vendors_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class VendorActionsScreen extends StatefulWidget {
  final Vendor vendor;

  const VendorActionsScreen({Key? key, required this.vendor}) : super(key: key);

  @override
  State<VendorActionsScreen> createState() => _VendorActionsScreenState();
}

class _VendorActionsScreenState extends State<VendorActionsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final vendor = widget.vendor;

    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة ${vendor.storeName}'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          VendorProductsTab(
            vendor: vendor,
          ),
          VendorStatisticsTab(
            vendor: vendor,
          ),
          AdminActionsTab(
            vendor: vendor,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'المنتجات'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'الإحصائيات'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'إجراءات'),
        ],
      ),
    );
  }
}
