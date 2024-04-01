import 'package:electronics_app/commom/widgets/loader.dart';
import 'package:electronics_app/features/admin/services/admin_services.dart';
import 'package:electronics_app/features/admin/widgets/category_products_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  // List<ItemEarning>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    // earnings = earningData['items'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  totalSales == null
        ? const Loader()
        : Column(
            children: [
              const SizedBox(height: 10,),
              Text(
                'Total: \$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BarChartItems(),
            ],
          );
  }
}
