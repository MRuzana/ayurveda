import 'package:ayurveda/data/patient_list_services.dart';
import 'package:ayurveda/domain/models/patient_list_model.dart';
import 'package:flutter/material.dart';

class PatientListProvider extends ChangeNotifier {
  final PatientListServices _patientListService = PatientListServices();

  List<PatientListModel> _patients = [];
  List<PatientListModel> get patients => _patients;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Fetch patient list
  Future<void> fetchPatients({bool reset = false}) async {

    if (reset) {
      _patients = []; //  clear old list on refresh
    }
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
