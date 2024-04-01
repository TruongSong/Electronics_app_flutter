import 'package:electronics_app/commom/widgets/loader.dart';
import 'package:electronics_app/features/account/widgets/single_product.dart';
import 'package:electronics_app/features/home/services/home_services.dart';
import 'package:electronics_app/features/product_details/screens/product_details_screen.dart';
import 'package:electronics_app/models/product.dart';
import 'package:flutter/material.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    final products = await homeServices.fetchAllProducts(context);
    setState(() {
      productList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return productList == null
        ? const Loader()
        : SizedBox(
            height: 400,
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final productData = productList![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ProductDetailScreen.routeName,
                          arguments: productData);
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 140,
                          child: SingleProduct(
                            image: productData.images[0],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  productData.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
  }
}
