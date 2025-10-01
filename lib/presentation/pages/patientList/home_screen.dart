import 'package:ayurveda/presentation/pages/patientList/patient_list_card.dart';
import 'package:ayurveda/presentation/pages/patientList/patient_list_provider.dart';
import 'package:ayurveda/presentation/widgets/button.dart';
import 'package:ayurveda/presentation/widgets/button_small.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PatientListProvider>(context, listen: false)
            .fetchPatients());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildSortBar(),
                Divider(),
                Expanded(
                  child: Consumer<PatientListProvider>(
                    builder: (context, patientListProvider, _) {
                      if (patientListProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (patientListProvider.errorMessage != null) {
                        return Center(
                            child: Text(
                                'Error: ${patientListProvider.errorMessage!}'));
                      }
                      if (patientListProvider.patients.isEmpty) {
                        return const Center(child: Text("No patients found"));
                      }

                      return ListView.builder(
                        itemCount: patientListProvider.patients.length,
                        itemBuilder: (context, index) {
                          final patient = patientListProvider.patients[index];
                          final formattedDate = formatDate(patient.date);
                         
                          return PatientListCard(
                            patientListModel: patient,
                            formattedDate: formattedDate,
                            index: index + 1,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            // Floating bottom button
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: button(
                buttonText: 'REGISTER NOW',
                color: const Color(0xFF006837),
                buttonPressed: () {
                  // Your logic
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Header/AppBar Implementation ---
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    //controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search for treatments",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              buttonSmall(
                  buttonText: 'Search ',
                  color: const Color(0xFF006837),
                  buttonPressed: () {})
            ],
          ),
        ),
      ),
    );
  }

  // --- Sort Bar Implementation ---
  Widget _buildSortBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Sort by : ',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          Container(
            width: 150,
            height: 37,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String? apiDate) {
  if (apiDate == null || apiDate.isEmpty) {
    return ""; // show empty or "N/A"
  }
  try {
    DateTime parsedDate = DateTime.parse(apiDate);
    return DateFormat("dd/MM/yyyy").format(parsedDate);
  } catch (e) {
    return ""; // fallback if parsing fails
  }
}
}
