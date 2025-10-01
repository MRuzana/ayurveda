import 'package:ayurveda/core/themes/text_styles.dart';
import 'package:ayurveda/data/treatment_list_services.dart';
import 'package:ayurveda/domain/models/treatment_list_modal.dart';
import 'package:ayurveda/presentation/widgets/button_small.dart';
import 'package:flutter/material.dart';

class TreatmentDialog extends StatefulWidget {
  @override
  State<TreatmentDialog> createState() => _TreatmentDialogState();
}

class _TreatmentDialogState extends State<TreatmentDialog> {
  String? selectedTreatment;
  List<TreatmentListModel> treatmentList = [];

  int maleCount = 0;
  int femaleCount = 0;
  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTreatments();
  }

  Future<void> _loadTreatments() async {
    try {
      TreatmentListServices service = TreatmentListServices();
      List<TreatmentListModel> treatments = await service.fetchTreatments();
      setState(() {
        treatmentList = treatments;
        //  isLoading = false;
      });
    } catch (e) {
      print("Error fetching treatments: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Choose Treatment',
        style: AppTextStyles.textXMediumBlack,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dropdown
            SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                value: treatmentList.any((t) => t.name == selectedTreatment)
                    ? selectedTreatment
                    : null,
                items: treatmentList
                    .map((treatment) => DropdownMenuItem(
                          value: treatment.name,
                          child: Text(
                            treatment.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedTreatment = val;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Choose treatment',
                ),
                validator: (val) =>
                    val == null ? "Please select a treatment" : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            const SizedBox(height: 20),

            // Patients Label
            Text(
              'Add patients',
              style: AppTextStyles.textXMediumBlack,
            ),
            const SizedBox(height: 10),

            // Male Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Male'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (maleCount > 0) setState(() => maleCount--);
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Color(0xFF006837),
                      ),
                    ),
                    Text(
                      maleCount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () => setState(() => maleCount++),
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF006837),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Female Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Female'),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (femaleCount > 0) setState(() => femaleCount--);
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Color(0xFF006837),
                      ),
                    ),
                    Text(
                      femaleCount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () => setState(() => femaleCount++),
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF006837),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        buttonSmall(
          buttonText: 'SAVE',
          color: const Color(0xFF006837),
          buttonPressed: () {
            if (selectedTreatment == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select a treatment')),
              );
              return;
            }

            // Process the data
            print('Treatment: $selectedTreatment');
            print('Male: $maleCount, Female: $femaleCount');

            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

// class TreatmentDialog extends StatefulWidget {
//   @override
//   State<TreatmentDialog> createState() => _TreatmentDialogState();
// }

// class _TreatmentDialogState extends State<TreatmentDialog> {
//   String? selectedTreatment;
//   List<TreatmentListModel> treatmentList = [];

//   int maleCount = 0;
//   int femaleCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadTreatments();
//   }

//   Future<void> _loadTreatments() async {
//     try {
//       TreatmentListServices service = TreatmentListServices();
//       List<TreatmentListModel> treatments = await service.fetchTreatments();
//       setState(() {
//         treatmentList = treatments;
//       });
//     } catch (e) {
//       print("Error fetching treatments: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         'Choose Treatment',
//         style: AppTextStyles.textXMediumBlack,
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Dropdown
//             SizedBox(
//             width:  double.infinity,
//             child: dropdownField<String>(
//               value: selectedTreatment,
//               items: treatmentList
//                   .map((treatment) => DropdownMenuItem(
//                         value: treatment.name,
//                         child: Text(
//                           treatment.name,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedTreatment = val;
//                 });
//               },
//               labelText: "Choose treatment",
//               validator: (val) =>
//                   val == null ? "Please select the treatment" : null,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//             ),
//                           ),

//             const SizedBox(height: 20),

//             // Patients Label
//             Text(
//               'Add patients',
//               style: AppTextStyles.textXMediumBlack,
//             ),

//             const SizedBox(height: 10),

//             // Male Counter
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Male'),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         if (maleCount > 0) setState(() => maleCount--);
//                       },
//                       icon: const Icon(
//                         Icons.remove_circle_outline,
//                         color: Color(0xFF006837),
//                       ),
//                     ),
//                     Text(
//                       maleCount.toString(),
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     IconButton(
//                       onPressed: () => setState(() => maleCount++),
//                       icon: const Icon(
//                         Icons.add_circle_outline,
//                         color: Color(0xFF006837),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),

//             // Female Counter
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Female'),
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         if (femaleCount > 0) setState(() => femaleCount--);
//                       },
//                       icon: const Icon(
//                         Icons.remove_circle_outline,
//                         color: Color(0xFF006837),
//                       ),
//                     ),
//                     Text(
//                       femaleCount.toString(),
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     IconButton(
//                       onPressed: () => setState(() => femaleCount++),
//                       icon: const Icon(
//                         Icons.add_circle_outline,
//                         color: Color(0xFF006837),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Cancel'),
//         ),
//         buttonSmall(
//           buttonText: 'SAVE',
//           color: const Color(0xFF006837),
//           buttonPressed: () {
//             if (selectedTreatment == null) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Please select a treatment')),
//               );
//               return;
//             }

//             // Save or process the data
//             print('Treatment: $selectedTreatment');
//             print('Male: $maleCount, Female: $femaleCount');

//             Navigator.pop(context);
//           },
//         ),
//       ],
//     );
//   }
// }
