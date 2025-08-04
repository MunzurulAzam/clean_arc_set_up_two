import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:loanapp/core/config/routes/app_routes.dart';
import 'package:loanapp/core/constants/assets/app_images.dart';
import 'package:loanapp/core/constants/colors/app_colors.dart';
import 'package:loanapp/core/helper/log_message.dart';
import 'package:loanapp/core/utils/size_config.dart';
import 'package:loanapp/src/features/auth/presentations/provider/auth/provider/auth_provider.dart';
import 'package:loanapp/src/widgets/common/app_text_field.dart';
import 'package:loanapp/src/widgets/on_process_button_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final notifier = ref.watch(authNotifierProvider.notifier);
    // final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          // color: AppColors.kBgColor,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.kBgColor, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(getScreenWidth(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: Image.asset(
                    AppImages.appLogo, // Replace with your transparent logo path
                    height: getScreenHeight(100),
                  ),
                ),
                getVerticalSpace(30),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(getBorderRadius(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(getScreenWidth(25)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            // maxLength: 11,
                            controller: _phoneController,
                            label: 'Phone Number',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            validator: (value) => value!.length != 12 ? 'Enter valid 12 digits phone number' : null,
                          ),
                          getVerticalSpace(20),
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Password',
                            icon: Icons.lock,
                            // obscureText: true,
                            validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
                          ),
                          getVerticalSpace(30),
                          Container(
                            width: double.infinity,
                            height: getScreenHeight(50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(getBorderRadius(15)),
                              color: AppColors.kPrimaryColor,
                              // gradient: LinearGradient(
                              //   colors: [AppColors.kPrimaryColor, AppColors.kSecondaryColor],
                              // ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: OnProcessButtonWidget(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  final success = await notifier.logIn(body: {
                                    'password': _passwordController.text,
                                    'phoneNumber': _phoneController.text,
                                  });
                                  return success;
                                } else {
                                  return null;
                                }
                              },
                              onDone: (isSuccess) {
                                if (isSuccess == true) {
                                  logMessage('check${state.beforeLogInEntity?.isProduction.toString()}');
                                  GoRouter.of(context).goNamed(RouteName.home);
                                }
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: getFontSize(18),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          getVerticalSpace(15),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                getVerticalSpace(20),
                TextButton(
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return CustomPopUpWindow(
                    //       child: Column(
                    //         children: [
                    //           getVerticalSpace(10),
                    //           Align(
                    //             alignment: Alignment.center,
                    //             child: Text(
                    //               'Are you a Umoja Client?',
                    //               style: theme.textTheme.bodyLarge?.copyWith(
                    //                 color: AppColors.kPrimaryColor,
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: getFontSize(17),
                    //               ),
                    //             ),
                    //           ),
                    //           getVerticalSpace(15),
                    //           OnProcessButtonWidget(
                    //             onTap: () async {
                    //               sharedPrefIsUmojaClient.updateValue(true);
                    //               await Future.delayed(const Duration(seconds: 1));
                    //               if (context.mounted) {
                    //                 showDialog(
                    //                   context: context,
                    //                   builder: (context) {
                    //                     return CustomPopUpWindow(
                    //                       child: Column(
                    //                         children: [
                    //                           getVerticalSpace(10),
                    //                           CustomTextField(controller: TextEditingController(), label: 'Enter your Mobile Number', icon: Icons.phone),
                    //                           getVerticalSpace(10),
                    //                           CustomTextField(controller: TextEditingController(), label: 'Create new password', icon: Icons.phone),
                    //                           getVerticalSpace(15),
                    //                           OnProcessButtonWidget(
                    //                             onTap: () {
                    //                               GoRouter.of(context).pop();
                    //                               GoRouter.of(context).pop();
                    //                               return null;
                    //                             },
                    //                             child: Text('send', style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
                    //                           )
                    //                         ],
                    //                       ),
                    //                     );
                    //                   },
                    //                 );
                    //               }
                    //               return null;
                    //             },
                    //             backgroundColor: Colors.transparent,
                    //             child: Text(
                    //               'Yes, I am a client',
                    //               style: theme.textTheme.bodyLarge?.copyWith(
                    //                 color: Colors.green[700],
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //           getVerticalSpace(15),
                    //           OnProcessButtonWidget(
                    //             onTap: () {
                    //               sharedPrefIsUmojaClient.updateValue(false);
                    //               // await Future.delayed(const Duration(seconds: 1));
                    //               if (context.mounted) {
                    //                 GoRouter.of(context).pushNamed(RouteName.registrationScreen);
                    //               }
                    //               return null;
                    //             },
                    //             backgroundColor: Colors.transparent,
                    //             child: Text(
                    //               'No, I am not a client',
                    //               style: theme.textTheme.bodyLarge?.copyWith(
                    //                 color: AppColors.kErrorColor,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //           getVerticalSpace(10),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // );

                    GoRouter.of(context).pushNamed(RouteName.registrationScreen);
                  },
                  child: const Text(
                    'Don’t have an account? Register',
                    style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
