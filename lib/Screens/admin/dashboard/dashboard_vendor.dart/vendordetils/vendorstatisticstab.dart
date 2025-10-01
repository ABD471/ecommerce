import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_flutter/models/dashboard_vendors_model.dart';

class VendorStatisticsTab extends StatelessWidget {
  final Vendor vendor;

  VendorStatisticsTab({Key? key, required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double ratingValue = double.tryParse(vendor.rating.toString()) ?? 0.0;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('📊 إحصائيات المتجر',
              style:
                  GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          _statCard(theme, 'عدد المنتجات', vendor.pruductCount.toString(),
              Icons.inventory_2),
          _statCard(theme, 'عدد الطلبات', vendor.orderCount.toString(),
              Icons.shopping_cart),
          _statCard(
              theme, 'مستوى الثقة', '${vendor.trustLevel}%', Icons.shield),
          _statCard(theme, 'التقييم العام',
              '${ratingValue.toStringAsFixed(1)} / 10', Icons.star),
          SizedBox(height: 24),
          Text('🧮 حالة المنتجات في المتجر',
              style:
                  GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.w600)),
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://th.bing.com/th/id/R.2294b8e24170fe8d4637e6a96627c869?rik=2xtG72pGV0DD9Q&pid=ImgRaw&r=0', // ضع الصورة التي أنشأناها هنا
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(ThemeData theme, String label, String value, IconData icon) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title:
            Text(label, style: GoogleFonts.cairo(fontWeight: FontWeight.w600)),
        trailing: Text(value, style: GoogleFonts.cairo(fontSize: 16)),
      ),
    );
  }
}
