import 'dart:convert';

import 'package:ayurveda/api/api_constants.dart';
import 'package:ayurveda/api/endpoints.dart';
import 'package:ayurveda/models/patient_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PatientListServices {

  String? token;

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwtToken');
  }

  Future<List<PatientListModel>> fetchPatients() async {
    if (token == null) {
      await _loadToken(); // Ensure token is loaded before making request
    }

    final String patientListUrl = ApiConstants.kBaseUrl + EndPoints.patientList;
    final url = Uri.parse(patientListUrl);

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

        List patientsList = data['patient'] ?? [];
        return patientsList.map((p) => PatientListModel.fromJson(p)).toList();
      } else {
        throw Exception("Failed: ${data['message']}");
      }
    } else {
      throw Exception("Server error: ${response.statusCode}");
    }
  }
}