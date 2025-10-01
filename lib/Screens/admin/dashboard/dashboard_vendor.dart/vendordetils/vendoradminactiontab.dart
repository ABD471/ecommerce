import 'package:ecommerce_flutter/controllers/admin/dashboard_vendors/vendoradminactiontab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ecommerce_flutter/models/dashboard_vendors_model.dart';

class AdminActionsTab extends StatefulWidget {
  final Vendor vendor;

  const AdminActionsTab({
    Key? key,
    required this.vendor,
  }) : super(key: key);

  @override
  State<AdminActionsTab> createState() => _AdminActionsTabState();
}

class _AdminActionsTabState extends State<AdminActionsTab> {
  late bool isActive;
  late VendoradminactiontabController controller;

  @override
  void initState() {
    super.initState();
    isActive = widget.vendor.isActive;
    controller = Get.put(VendoradminactiontabController(vendor: widget.vendor));
  }

  @override
  Widget build(BuildContext context) {
    double value = widget.vendor.trustLevel.toDouble();
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('⚙️ التحكم في حالة النشاط',
                  style: GoogleFonts.cairo(
                      fontSize: 20, fontWeight: FontWeight.bold))
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: -0.2),
          SizedBox(height: 12),
          SwitchListTile(
            title: Text(isActive ? 'المتجر نشط ✅' : 'المتجر موقوف ❌',
                style: GoogleFonts.cairo()),
            subtitle: Text('يمكنك تغيير حالة النشاط حسب السياسات',
                style: GoogleFonts.cairo(fontSize: 13)),
            value: isActive,
            onChanged: (value) {
              setState(() {
                isActive = value;
              });
              controller.onActiveChanged(value);
            },
          ),
          Divider(height: 32),
          Text('🛡️ مستوى الثقة',
                  style: GoogleFonts.cairo(
                      fontSize: 20, fontWeight: FontWeight.bold))
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: -0.2),
          SizedBox(height: 12),
          Text('القيمة الحالية: ${widget.vendor.trustLevel.toInt()}%',
              style: GoogleFonts.cairo(fontSize: 14)),
          Slider(
            value: value,
            min: 0,
            max: 10,
            divisions: 10,
            label: '${widget.vendor.trustLevel.toInt()}%',
            onChanged: (valuee) {
              setState(() {
                widget.vendor.trustLevel = valuee.toInt();
                controller.updateVendorTrust(widget.vendor.trustLevel);
              });
            },
          ),
          Divider(height: 32),
          Text('📝 تعديل بيانات المتجر',
                  style: GoogleFonts.cairo(
                      fontSize: 20, fontWeight: FontWeight.bold))
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: -0.2),
          SizedBox(height: 12),
          TextField(
            controller: controller.nameController,
            decoration: InputDecoration(
              labelText: 'اسم المتجر',
              border: OutlineInputBorder(),
            ),
            style: GoogleFonts.cairo(),
            onChanged: (value) => widget.vendor.storeName = value,
          ),
          SizedBox(height: 12),
          TextField(
            controller: controller.descController,
            decoration: InputDecoration(
              labelText: 'وصف المتجر',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
            style: GoogleFonts.cairo(),
            onChanged: (value) => widget.vendor.storeDescription = value,
          ),
          SizedBox(height: 12),
          TextField(
            controller: controller.logoController,
            decoration: InputDecoration(
              labelText: 'رابط الشعار',
              border: OutlineInputBorder(),
            ),
            style: GoogleFonts.cairo(),
            onChanged: (value) => widget.vendor.storeLogo = value,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              controller.saveChange();
            },
            icon: Icon(Icons.save),
            label: Text('حفظ التعديلات', style: GoogleFonts.cairo()),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
