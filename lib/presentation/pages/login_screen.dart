import 'package:ayurveda/core/constants/spacing_constants.dart';
import 'package:ayurveda/core/constants/string_constants.dart';
import 'package:ayurveda/core/themes/text_styles.dart';
import 'package:ayurveda/core/utils/validators.dart';
import 'package:ayurveda/data/login_services.dart';
import 'package:ayurveda/presentation/widgets/button.dart';
import 'package:ayurveda/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top image section (fixed)
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/login1.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Image.asset('assets/images/login2.png'),
              ],
            ),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: kpaddingLR20,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: kpadding20,
                        child: Text(
                          login,
                          style: AppTextStyles.heading1,
                        ),
                      ),
                      kHeight20,
                      Text(
                        'Username',
                        style: AppTextStyles.textXMediumLightBlack,
                      ),
                      kHeight5,
                      textField(
                        controller: _usernameController,
                        keyboardType: TextInputType.name,
                        labelText: 'Enter Username',
                        validator: (value) => Validator.validateNotEmpty(value,
                            fieldName: 'Username'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      kHeight18,
                      Text(
                        'Password',
                        style: AppTextStyles.textXMediumLightBlack,
                      ),
                      kHeight5,
                      textField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: 'Enter Password',
                        validator: (value) => Validator.validateNotEmpty(value,
                            fieldName: 'Password'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        isObscured: true,
                      ),
                      kHeight25,
                      button(
                        buttonText: 'LOGIN',
                        color: const Color(0xFF006837),
                        buttonPressed: () async {
                         // Navigator.pushNamed(context, '/home');
                          if (_formKey.currentState!.validate()) {
                            final bool isVerified = await LoginServices()
                                .sendCredentials(
                                    username: _usernameController.text.trim(),
                                    password: _passwordController.text.trim());

                            if (isVerified) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
                            }
                          
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: kpaddingLR20,
              child: Text(
                terms,
                style: AppTextStyles.textXSmallBlack,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
