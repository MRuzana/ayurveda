import 'package:ayurveda/core/constants/spacing_constants.dart';
import 'package:ayurveda/core/themes/text_styles.dart';
import 'package:ayurveda/core/utils/validators.dart';
import 'package:ayurveda/data/branch_list_services.dart';
import 'package:ayurveda/domain/models/branch_list_modal.dart';
import 'package:ayurveda/presentation/pages/register/treatment_dialog.dart';
import 'package:ayurveda/presentation/widgets/button.dart';
import 'package:ayurveda/presentation/widgets/dropdown_widget.dart';
import 'package:ayurveda/presentation/widgets/payment_radio_button.dart';
import 'package:ayurveda/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _watsappController = TextEditingController();
  final _addressController = TextEditingController();
  final _totalAmountController = TextEditingController();
  final _discountAmountController = TextEditingController();
  final _advanceAmountController = TextEditingController();
  final _balanceAmountController = TextEditingController();
  final _treatmentDateController = TextEditingController();

  String? selectedLocation;
  String _selectedPayment = "Cash";
  String? selectedBranch;
  List<BranchListModel> branchList = [];
  String? selectedHour;
  String? selectedMin;

  @override
  void initState() {
    super.initState();
    _loadBranches();
  }

  Future<void> _loadBranches() async {
    try {
      BranchListServices service = BranchListServices();
      List<BranchListModel> branches = await service.fetchBranches();
      setState(() {
        branchList = branches;
      });
    } catch (e) {
      print("Error fetching branches: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: kpaddingLR20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register',
                style: AppTextStyles.heading2,
              ),
              Divider(),

              // -------- name ---------------
              Text(
                'Name',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              textField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                labelText: 'Enter your full name',
                validator: (value) =>
                    Validator.validateNotEmpty(value, fieldName: 'Name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              kHeight18,

              // -------- watsapp ---------------
              Text(
                'Watsapp Number',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              textField(
                controller: _watsappController,
                keyboardType: TextInputType.number,
                labelText: 'Enter your watsapp number',
                validator: (value) => Validator.validateNotEmpty(value,
                    fieldName: 'Watsapp number'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              kHeight18,

              // -------- address ---------------
              Text(
                'Address',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              textField(
                controller: _addressController,
                keyboardType: TextInputType.name,
                labelText: 'Enter your address',
                validator: (value) =>
                    Validator.validateNotEmpty(value, fieldName: 'Address'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              kHeight18,

              // -------- Location ---------------
              Text(
                'Location',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              dropdownField<String>(
                value: selectedBranch,
                items: ['Calicut', 'Malappuram', 'Pgdi']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedLocation = val;
                },
                labelText: "Choose your location",
                validator: (val) =>
                    val == null ? "Please select a location" : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              kHeight18,

              // -------- Branch ---------------
              Text(
                'Branch',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              dropdownField<String>(
                value: selectedBranch,
                items: branchList
                    .map((branch) => DropdownMenuItem(
                          value: branch.name,
                          child: Text(branch.name),
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedBranch = val;
                },
                labelText: "Choose the branch",
                validator: (val) =>
                    val == null ? "Please select the branch" : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              kHeight18,

              // -------- Treatments ---------------
              Text(
                'Treatments',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              button(
                  buttonText: '+ Add treatments',
                  color: Color(0xFF006837),
                  buttonPressed: () {
                   

                    showDialog(
                      context: context,
                      builder: (context) => TreatmentDialog(),
                    );
                  }),
              kHeight18,

              // -------- Total amount ---------------
              Text(
                'Total Amount',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              textField(
                controller: _totalAmountController,
                keyboardType: TextInputType.number,
                labelText: '',
                validator: (value) => Validator.validateNotEmpty(value,
                    fieldName: 'Total amount'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              kHeight18,

              // -------- Discount amount ---------------
              Text(
                'Discount Amount',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              textField(
                controller: _discountAmountController,
                keyboardType: TextInputType.number,
                labelText: '',
                validator: (value) => Validator.validateNotEmpty(value,
                    fieldName: 'Discount amount'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              kHeight18,

              // -------- radio button ---------------

              Text(
                'Payment Option',
                style: AppTextStyles.textXMediumBlack,
              ),

              paymentRadioButtons(
                selectedPayment: _selectedPayment,
                onChanged: (val) {
                  if (val != null) {
                    _selectedPayment = val;
                    setState(() {}); // update UI
                  }
                },
              ),

              // -------- Advance amount ---------------
              Text(
                'Advance Amount',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              textField(
                controller: _advanceAmountController,
                keyboardType: TextInputType.number,
                labelText: '',
                validator: (value) => Validator.validateNotEmpty(value,
                    fieldName: 'Advance amount'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              kHeight18,

              // -------- Balance amount ---------------
              Text(
                'Balance Amount',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              textField(
                controller: _balanceAmountController,
                keyboardType: TextInputType.number,
                labelText: '',
                validator: (value) => Validator.validateNotEmpty(value,
                    fieldName: 'Balance amount'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              kHeight18,

              // -------- Treatment date ---------------
              Text(
                'Treatment Date',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              textField(
                controller: _treatmentDateController,
                keyboardType: TextInputType.text,
                labelText: 'Treatment Date',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validator.validateNotEmpty(value, fieldName: 'Date'),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today,
                      color: Color(0xFF006837)),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      _treatmentDateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                ),
              ),
              kHeight18,

              // -------- Treatment Time ---------------
              Text(
                'Treatment Time',
                style: AppTextStyles.textXMediumBlack,
              ),
              kHeight5,
              Row(
                children: [
                  Expanded(
                    child: dropdownField<String>(
                      value: selectedHour,
                      items: ['1', '2', '3', '4', '5']
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (val) {
                        selectedHour = val;
                      },
                      labelText: "Hour",
                      validator: (val) =>
                          val == null ? "Please select hour" : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  kWidth4,
                  Expanded(
                    child: dropdownField<String>(
                      value: selectedMin,
                      items: ['10', '20', '30', '40', '50']
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (val) {
                        selectedMin = val;
                      },
                      labelText: "Min",
                      validator: (val) =>
                          val == null ? "Please select a min" : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ],
              ),
              kHeight18,

              button(
                buttonText: 'SAVE',
                color: const Color(0xFF006837),
                buttonPressed: () async {},
              ),
              kHeight20
            ],
          ),
        ),
      )),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications_none),
        onPressed: () {},
      ),
    ],
  );
}
