import 'package:ayurveda/core/constants/spacing_constants.dart';
import 'package:ayurveda/domain/models/patient_list_model.dart';
import 'package:flutter/material.dart';

class PatientListCard extends StatelessWidget {
  final PatientListModel patientListModel;
  final String? formattedDate;
  final int index;
  const PatientListCard(
      {super.key,
      required this.patientListModel,
      required this.formattedDate,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kpadding20,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFFF1F1F1),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side index
              Text(
                "$index.",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 12),

              // Right side booking details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      patientListModel.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),

                    const SizedBox(height: 4),

                    // Package title
                    Text(
                      'Couple combo package',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Date and Person row
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 16, color: Colors.deepOrange),
                        const SizedBox(width: 4),
                        Text(
                          formattedDate!.isEmpty ? " " : formattedDate!,
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 20),
                        Icon(Icons.group, size: 16, color: Colors.deepOrange),
                        const SizedBox(width: 4),
                        Text(
                          patientListModel.user,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),

                    const Divider(height: 20),

                    // Booking details row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "View Booking details",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.green),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
