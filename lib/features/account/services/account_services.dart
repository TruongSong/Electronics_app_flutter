import 'dart:convert';

import 'package:electronics_app/constants/error_handling.dart';
import 'package:electronics_app/constants/global_variables.dart';
import 'package:electronics_app/constants/utils.dart';
import 'package:electronics_app/features/auth/screens/auth_screen.dart';
import 'package:electronics_app/models/order.dart';
import 'package:electronics_app/models/user.dart';
import 'package:electronics_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/orders/me'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, e.toString());
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, e.toString());
    }
  }
  //api edit user

  void editAccount({
    required BuildContext context,
    required String name,
    required String email,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/edit-user'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'address': address,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            name: jsonDecode(res.body)['name'],
            email: jsonDecode(res.body)['email'],
            address: jsonDecode(res.body)['address'],
          );
          userProvider.setUserFromModel(user);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, e.toString());
    }
  }

  // delete account
  void deleteAccount(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/delete-user'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
// ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // Xóa thông tin người dùng khỏi SharedPreferences hoặc bất kỳ cơ chế lưu trữ nào khác
          // Đồng thời xóa thông tin người dùng từ provider
          userProvider.clearUser();
          // Chuyển hướng đến màn hình đăng nhập
          Navigator.pushNamedAndRemoveUntil(
            context,
            AuthScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, e.toString());
    }
  }
}
