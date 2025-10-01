import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_vendor.dart/vendordetils/vendordetailspage.dart';

import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/models/dashboard_vendors_model.dart';
import 'package:get/get.dart';

class VendorCard extends StatefulWidget {
  final Vendor vendor;

  const VendorCard({Key? key, required this.vendor}) : super(key: key);

  @override
  State<VendorCard> createState() => _VendorCardState();
}

class _VendorCardState extends State<VendorCard> with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vendor = widget.vendor;
    final double ratingValue = double.tryParse(vendor.rating.toString()) ?? 0.0;

    return GestureDetector(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: AnimatedSize(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.primary, width: 1.5),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الجزء الأساسي
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(vendor.storeLogo),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vendor.storeName,
                            style: theme.textTheme.titleLarge),
                        Text(vendor.storeDescription,
                            style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),

              // التوسعة
              if (isExpanded) ...[
                SizedBox(height: 16),
                Divider(),
                _infoRow(theme, Icons.person, 'صاحب المتجر', vendor.username),
                _infoRow(theme, Icons.email, 'البريد الإلكتروني', vendor.email),
                _infoRow(theme, Icons.verified_user, 'الحالة', vendor.status),
                _infoRow(theme, Icons.shield, 'مستوى الثقة',
                    '${vendor.trustLevel}%'),
                _infoRow(theme, Icons.calendar_today, 'تاريخ الإنشاء',
                    vendor.createdAt.toLocal().toString().substring(0, 10)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    SizedBox(width: 4),
                    Text('${ratingValue.toStringAsFixed(1)} / 10'),
                    SizedBox(width: 12),
                    buildStarRating(ratingValue),
                  ],
                ),
                SizedBox(height: 8),
                _infoRow(theme, Icons.inventory_2, 'عدد المنتجات',
                    vendor.pruductCount.toString()),
                _infoRow(theme, Icons.shopping_cart, 'عدد الطلبات',
                    vendor.orderCount.toString()),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // إجراءات إضافية مثل تعديل أو عرض المنتجات
                      Get.to(VendorActionsScreen(
                        vendor: vendor,
                      ));
                    },
                    icon: Icon(Icons.settings),
                    label: Text('إجراءات'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: StadiumBorder(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(ThemeData theme, IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          SizedBox(width: 6),
          Text('$label: ', style: theme.textTheme.bodyMedium),
          Expanded(
            child: Text(value,
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }

  Widget buildStarRating(double ratingValue) {
    int fullStars = ratingValue ~/ 2;
    bool hasHalfStar = ratingValue % 2 >= 1;

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star, color: Colors.amber, size: 18);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half, color: Colors.amber, size: 18);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: 18);
        }
      }),
    );
  }
}
