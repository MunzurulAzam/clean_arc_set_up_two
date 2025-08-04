import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:loanapp/core/config/routes/app_routes.dart';
import 'package:loanapp/core/constants/colors/app_colors.dart';
import 'package:loanapp/core/helper/log_message.dart';
import 'package:loanapp/core/utils/size_config.dart';
import 'package:loanapp/src/features/auth/presentations/provider/auth/provider/auth_provider.dart';
import 'package:loanapp/src/widgets/app_text_input_field.dart';
import 'package:loanapp/src/widgets/common/app_text_field.dart';
import 'package:loanapp/src/widgets/on_process_button_widget.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  // New color scheme

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _nidController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final notifier = ref.watch(authNotifierProvider.notifier);
    logMessage('RegistrationScreen: isReformVisible: ${state.isReformVisible}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration', style: TextStyle(color: AppColors.kWhiteColor)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: AppColors.kSecondaryColor,
            // gradient: LinearGradient(
            //   colors: [AppColors.kPrimaryColor, AppColors.kSecondaryColor],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.kBgColor, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(getScreenWidth(20)),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getBorderRadius(20)),
            ),
            child: Padding(
              padding: EdgeInsets.all(getScreenWidth(25)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                    getVerticalSpace(30),
                    AppInputTextField(
                      textEditingController: _phoneController,
                      labelText: 'Phone Number',
                      hintText: '',
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'Enter your phone number';
                        } else if (p0.length != 12) {
                          return 'Enter valid phone number';
                        }
                        return null;
                      },
                      onChangedProcessing: (p0) async {
                        if (p0.length == 12) {
                          await notifier.checkUser(phoneNumber: _phoneController.text, body: {
                            "phoneNumber": _phoneController.text,
                          });
                        }
                      },
                    ),
                    getVerticalSpace(20),
                    if (state.isReformVisible == false)
                      CustomTextField(
                        controller: _nameController,
                        label: 'First Name',
                        icon: Icons.person,
                        validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                      ),
                    if (state.isReformVisible == false) getVerticalSpace(20),
                    if (state.isReformVisible == false)
                      CustomTextField(
                        controller: _lastNameController,
                        label: 'Last Name',
                        icon: Icons.person,
                        validator: (value) => value!.isEmpty ? 'Enter your last name' : null,
                      ),
                    state.isReformVisible == true
                        ? getVerticalSpace(20)
                        : state.isReformVisible == false
                            ? getVerticalSpace(20)
                            : getVerticalSpace(0),
                    state.isReformVisible == true
                        ? CustomTextField(
                            controller: _passwordController,
                            label: 'Password',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            validator: (value) => value!.length < 6 ? 'Enter 6 digit password' : null,
                          )
                        : state.isReformVisible == false
                            ? CustomTextField(
                                controller: _passwordController,
                                label: 'Password',
                                icon: Icons.password,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                validator: (value) => value!.length < 6 ? 'Enter 6 digit password' : null,
                              )
                            : SizedBox.shrink(),
                    if (state.isReformVisible == false) getVerticalSpace(20),
                    if (state.isReformVisible == false)
                      CustomTextField(
                        controller: _nidController,
                        label: 'NID Number',
                        icon: Icons.credit_card,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) => value!.length < 14 ? 'Enter valid NID number' : null,
                      ),
                    if (state.isReformVisible == false) getVerticalSpace(20),
                    if (state.isReformVisible == false)
                      CustomTextField(
                        controller: _addressController,
                        label: 'Address',
                        icon: Icons.location_on,
                        maxLines: 1,
                        validator: (value) => value!.isEmpty ? 'Enter your address' : null,
                      ),
                    getVerticalSpace(30),
                    Container(
                      width: double.infinity,
                      height: getScreenHeight(50),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(getBorderRadius(15)),
                        // gradient: LinearGradient(
                        //   colors: [AppColors.kPrimaryColor, AppColors.kSecondaryColor],
                        // ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.kPrimaryColor.withValues(alpha: .3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: OnProcessButtonWidget(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            final success = await notifier.signUp(body: {
                              "firstName": _nameController.text,
                              "lastName": _lastNameController.text,
                              "nationalId": _nidController.text,
                              "phoneNumber": _phoneController.text,
                              // "address": _addressController.text,
                              "password": _passwordController.text,
                            });
                            return success;
                          } else {
                            return false;
                          }
                        },
                        onDone: (isSuccess) {
                          if (isSuccess == true) {
                            notifier.clearState();
                            GoRouter.of(context).go(RouteName.loginScreen);
                          }
                        },
                        child: Text(
                          'REGISTER NOW',
                          style: TextStyle(
                            fontSize: getFontSize(18),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
