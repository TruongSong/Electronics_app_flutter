import 'dart:convert';

import 'package:electronics_app/commom/widgets/bottom_bar.dart';
import 'package:electronics_app/constants/error_handling.dart';
import 'package:electronics_app/constants/global_variables.dart';
import 'package:electronics_app/constants/utils.dart';
import 'package:electronics_app/features/admin/screens/admin_screen.dart';
import 'package:electronics_app/models/user.dart';
import 'package:electronics_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSucccessDialog(context,
              'Account created success! Login with the same credentials!');
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, e.toString());
    }
  }

  //sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final responseData = jsonDecode(res.body);
          final String userType = responseData['type'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          if (userType == 'admin') {
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
              context,
              AdminScreen.routeName,
              (route) => false,
            );
          } else {
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          }
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, e.toString());
    }
  }

  //get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        //get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(
          context,
          listen: false,
        );
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showErrorDialog(context, e.toString());
    }
  }
}
