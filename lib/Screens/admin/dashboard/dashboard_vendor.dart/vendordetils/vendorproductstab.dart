import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_flutter/models/dashboard_vendors_model.dart';

class VendorProductsTab extends StatelessWidget {
  final Vendor vendor;

  const VendorProductsTab({Key? key, required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // بيانات تجريبية للمنتجات
    final dummyProducts = [
      {
        'name': 'ساعة ذكية',
        'image':
            'https://mostaql.hsoubcdn.com/uploads/portfolios/613359/61a1e38296580/product008.jpg',
        'price': '299',
        'status': 'نشط',
      },
      {
        'name': 'سماعة بلوتوث',
        'image':
            'https://mostaql.hsoubcdn.com/uploads/portfolios/613359/61a1e382eb6ce/product0031.jpg',
        'price': '149',
        'status': 'بانتظار الموافقة',
      },
      {
        'name': 'حقيبة ظهر',
        'image': 'https://i.suar.me/JM2q4/l',
        'price': '89',
        'status': 'مرفوض',
      },
    ];

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🛍️ منتجات المتجر',
              style:
                  GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: dummyProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 40,
              ),
              itemBuilder: (context, index) {
                final product = dummyProducts[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          product['image']!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product['name']!,
                                style: GoogleFonts.cairo(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            SizedBox(height: 2),
                            Text('السعر: ${product['price']} ر.س',
                                style: GoogleFonts.cairo(fontSize: 14)),
                            SizedBox(height: 2),
                            Chip(
                              label: Text(product['status']!,
                                  style:
                                      GoogleFonts.cairo(color: Colors.white)),
                              backgroundColor: _statusColor(product['status']!),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit,
                                      color: theme.colorScheme.primary),
                                  onPressed: () {
                                    // تعديل المنتج
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // حذف المنتج
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'نشط':
        return Colors.green;
      case 'بانتظار الموافقة':
        return Colors.orange;
      case 'مرفوض':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
