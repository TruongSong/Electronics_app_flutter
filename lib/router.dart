import 'package:electronics_app/commom/widgets/bottom_bar.dart';
import 'package:electronics_app/features/account/screens/edit_account_screen.dart';
import 'package:electronics_app/features/account/screens/information_account_screen.dart';
import 'package:electronics_app/features/account/screens/order_screen.dart';
import 'package:electronics_app/features/address/screens/address_screen.dart';
import 'package:electronics_app/features/admin/screens/add_product_screen.dart';
import 'package:electronics_app/features/admin/screens/admin_screen.dart';
import 'package:electronics_app/features/auth/screens/auth_screen.dart';
import 'package:electronics_app/features/home/screens/category_deals_screen.dart';
import 'package:electronics_app/features/home/screens/home_screen.dart';
import 'package:electronics_app/features/order_details/screens/order_details.dart';
import 'package:electronics_app/features/product_details/screens/product_details_screen.dart';
import 'package:electronics_app/features/search/screens/search_screen.dart';
import 'package:electronics_app/models/order.dart';
import 'package:electronics_app/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeSrcreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeSrcreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    case OrderScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderScreen(),
      );
    case InfomationAccountScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const InfomationAccountScreen(),
      );
    case EditAccountScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditAccountScreen(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exits !'),
          ),
        ),
      );
  }
}
