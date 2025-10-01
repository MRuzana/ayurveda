import 'dart:convert';

import 'package:ayurveda/core/api/api_constants.dart';
import 'package:ayurveda/core/api/endpoints.dart';
import 'package:ayurveda/domain/models/branch_list_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BranchListServices {

  String? token;

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwtToken');
  }

  Future<List<BranchListModel>> fetchBranches() async {
    if (token == null) {
      await _loadToken(); // Ensure token is loaded before making request
    }

    final String branchListUrl = ApiConstants.kBaseUrl + EndPoints.branchList;
    final url = Uri.parse(branchListUrl);

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',  // attach token
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == true) {

        List branchList = data['branches'] ?? [];
        return branchList.map((p) => BranchListModel.fromJson(p)).toList();
        
      } else {
        throw Exception("Failed: ${data['message']}");
      }
    } else {
      throw Exception("Server error: ${response.statusCode}");
    }
  }
}