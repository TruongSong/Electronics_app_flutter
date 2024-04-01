import 'package:electronics_app/commom/widgets/loader.dart';
import 'package:electronics_app/constants/global_variables.dart';
import 'package:electronics_app/features/account/services/account_services.dart';
import 'package:electronics_app/features/account/widgets/single_product.dart';
import 'package:electronics_app/features/order_details/screens/order_details.dart';
import 'package:electronics_app/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/order';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Your order',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
      ),
      body: orders == null
          ? const Loader()
          : Column(
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        'Your Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 170,
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 20,
                    right: 0,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailScreen.routeName,
                            arguments: orders![index],
                          );
                        },
                        child: SingleProduct(
                          image: orders![index].products[0].images[0],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
