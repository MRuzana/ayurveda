import 'dart:convert';
import 'dart:developer';
import 'package:ayurveda/api/api_constants.dart';
import 'package:ayurveda/api/endpoints.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  Future<bool> sendCredentials({required String username, required String password}) async {
    final String sendLoginUrl = ApiConstants.kBaseUrl + EndPoints.login;
    final url = Uri.parse(sendLoginUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
       
        if (responseData['status'] == true) {
          final token = responseData['token'];
          print('token is: $token');

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwtToken', token);

          Fluttertoast.showToast(
            msg: "${responseData['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          log(" ${responseData['message']}");
          return true; // Indicate success

        } else {
          Fluttertoast.showToast(
            msg: "${responseData['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
          log("Failed: ${responseData['message']}");
          return false; // Indicate failure
        }
      } else {
        Fluttertoast.showToast(
          msg: "Server error: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      log("Server error: ${response.statusCode}");
        return false; // Indicate failure
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Exception occurred: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      log("Exception occurred: $e");
      return false; // Indicate failure
    }
  }
}
