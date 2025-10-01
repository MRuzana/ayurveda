import 'dart:convert';
import 'package:ayurveda/core/api/api_constants.dart';
import 'package:ayurveda/core/api/endpoints.dart';
import 'package:ayurveda/domain/models/treatment_list_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TreatmentListServices {

  String? token;

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('jwtToken');
  }

  Future<List<TreatmentListModel>> fetchTreatments() async {
  if (token == null) {
    await _loadToken();
  }

  final String treatmentListUrl = ApiConstants.kBaseUrl + EndPoints.treatmentList;
  final url = Uri.parse(treatmentListUrl);

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == true) {
      List treatmentList = data['treatments'] ?? [];

      // Convert to TreatmentListModel objects
      List<TreatmentListModel> treatments = treatmentList
          .map((p) => TreatmentListModel.fromJson(p))
          .toList();

      // Remove duplicates based on treatment name
      final uniqueTreatments = <String, TreatmentListModel>{};
      for (var t in treatments) {
        uniqueTreatments[t.name] = t; // same name will overwrite, keeping last
      }

      return uniqueTreatments.values.toList();
    } else {
      throw Exception("Failed: ${data['message']}");
    }
  } else {
    throw Exception("Server error: ${response.statusCode}");
  }
}
}










// class TreatmentListServices {

//   String? token;

//   Future<void> _loadToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('jwtToken');
//   }

//   Future<List<TreatmentListModel>> fetchTreatments() async {
//     if (token == null) {
//       await _loadToken(); // Ensure token is loaded before making request
//     }

//     final String treatmentListUrl = ApiConstants.kBaseUrl + EndPoints.treatmentList;
//     final url = Uri.parse(treatmentListUrl);

//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',  // attach token
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data['status'] == true) {

//         List treatmentList = data['treatments'] ?? [];
//         return treatmentList.map((p) => TreatmentListModel.fromJson(p)).toList();
        
//       } else {
//         throw Exception("Failed: ${data['message']}");
//       }
//     } else {
//       throw Exception("Server error: ${response.statusCode}");
//     }
//   }
// }