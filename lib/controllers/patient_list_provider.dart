import 'package:ayurveda/models/patient_list_model.dart';
import 'package:ayurveda/services/patient_list_services.dart';
import 'package:flutter/material.dart';

class PatientListProvider extends ChangeNotifier {
  final PatientListServices _patientListService = PatientListServices();

  List<PatientListModel> _patients = [];
  List<PatientListModel> get patients => _patients;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Fetch patient list
  Future<void> fetchPatients() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _patients = await _patientListService.fetchPatients();
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
