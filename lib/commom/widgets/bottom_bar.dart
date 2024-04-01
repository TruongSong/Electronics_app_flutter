import 'package:electronics_app/constants/global_variables.dart';
import 'package:electronics_app/features/account/screens/account_screen.dart';
import 'package:electronics_app/features/cart/screens/cart_screen.dart';
import 'package:electronics_app/features/home/screens/home_screen.dart';
import 'package:electronics_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int selectedTab = 0;
  double bottomBarWidth = 30;
  double bottomBarBorderWigth = 5;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller?.addListener(() {
      selectedTab = controller?.index ?? 0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: const [
          // home screen
          HomeSrcreen(),
          //account view
          AccountScreen(),
          // cart screen
          CartScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: TabBar(
              controller: controller,
              indicatorColor: Colors.transparent,
              indicatorWeight: 1,
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                fontSize: 10,
              ),
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: const TextStyle(
                fontSize: 10,
              ),
              tabs: [
                Tab(
                  text: 'Home',
                  icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: selectedTab == 0
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWigth,
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.home_outlined,
                    ),
                  ),
                ),
                Tab(
                  text: 'Account',
                  icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: selectedTab == 1
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWigth,
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.person_outline_outlined,
                    ),
                  ),
                ),
                Tab(
                  text: 'Cart',
                  icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: selectedTab == 2
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWigth,
                        ),
                      ),
                    ),
                    child: badges.Badge(
                      elevation: 0,
                      badgeContent: Text(userCartLen.toString()),
                      badgeColor: Colors.white,
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
