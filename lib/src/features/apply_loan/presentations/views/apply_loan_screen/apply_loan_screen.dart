import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:loanapp/core/constants/colors/app_colors.dart';
import 'package:loanapp/core/preferences/preferences.dart';
import 'package:loanapp/core/utils/size_config.dart';
import 'package:loanapp/src/features/apply_loan/presentations/provider/apply_loan_provider/provider/apply_loan_provider.dart';
import 'package:loanapp/src/widgets/custom_list_modal/custom_list_modal.dart';
import 'package:loanapp/src/widgets/on_process_button_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ApplyLoanScreen extends ConsumerStatefulWidget {
  const ApplyLoanScreen({super.key, required this.totalApprovedLoanAmount});
  final double totalApprovedLoanAmount;

  @override
  ApplyLoanScreenState createState() => ApplyLoanScreenState();
}

class ApplyLoanScreenState extends ConsumerState<ApplyLoanScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedLoanProduct;
  final List<String> _loanProducts = ['Personal Loan', 'Business Loan', 'Education Loan', 'Home Loan', 'Emergency Loan'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showLoanProducts() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(getScreenWidth(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Loan Product', style: TextStyle(fontSize: getFontSize(18), fontWeight: FontWeight.bold)),
              SizedBox(height: getScreenHeight(20)),
              ..._loanProducts.map((product) => ListTile(
                    title: Text(product),
                    onTap: () {
                      setState(() => _selectedLoanProduct = product);
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(applyLoanProvider);
    // final notifier = ref.read(applyLoanProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Loan', style: TextStyle(color: AppColors.kWhiteColor)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.kWhiteColor),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: AppColors.kSecondaryColor,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.kBgColor.withValues(alpha: 0.1),
              AppColors.kPrimaryColor.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(getScreenWidth(20)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildInputCard(
                  children: [
                    _buildNameField(
                      controller: _firstNameController,
                      label: 'First Name',
                      icon: Icons.person_outline,
                    ),
                    SizedBox(height: getScreenHeight(15)),
                    _buildNameField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      icon: Icons.person_outline,
                    ),
                    SizedBox(height: getScreenHeight(15)),
                    _buildPhoneField(),
                    SizedBox(height: getScreenHeight(15)),
                    if (sharedPrefIsUmojaClient.value == true)
                      Column(
                        children: [
                          AbsorbPointer(
                            child: _buildTextField(
                              controller: TextEditingController(text: 'Umoja Client dummy'),
                              label: 'Branch Name',
                              icon: Icons.credit_card,
                              validator: (value) => value!.isEmpty ? 'Please enter branch name' : null,
                            ),
                          ),
                          getVerticalSpace(15),
                          AbsorbPointer(
                            child: _buildTextField(
                              controller: TextEditingController(text: '0123456789'),
                              label: 'Client Id',
                              icon: Icons.pin,
                              validator: (value) => value!.isEmpty ? 'Please enter Client Id' : null,
                            ),
                          ),
                          getVerticalSpace(15),
                          AbsorbPointer(
                            child: _buildTextField(
                              controller: TextEditingController(text: 'Umoja dummy group'),
                              label: 'Group Name',
                              icon: Icons.group,
                              validator: (value) => value!.isEmpty ? 'Please enter Group Name' : null,
                            ),
                          ),
                          getVerticalSpace(15),
                          AbsorbPointer(
                            child: _buildTextField(
                              controller: TextEditingController(text: 'Monday'),
                              label: 'Meeting Day',
                              icon: Icons.meeting_room,
                              validator: (value) => value!.isEmpty ? 'Please upload Meeting Day' : null,
                            ),
                          ),
                        ],
                      ),
                    if (sharedPrefIsUmojaClient.value == true) getVerticalSpace(15),
                    _buildLoanProductField(),
                    getVerticalSpace(15),
                    _buildAmountField(),
                    getVerticalSpace(15),
                    _buildLoanPurposeField(),
                    getVerticalSpace(15),
                    _buildLoanRepaymentOptionField(),
                    getVerticalSpace(15),
                    _buildAppliedLoanAmountWithInterestField(
                      controller: TextEditingController(text: '20%'),
                      label: 'Applied Loan Amount with Interest',
                      icon: Icons.attach_money,
                    ),
                    getVerticalSpace(15),
                    _buildLoanChargeApplicableField(),
                    if (state.chargeApplicable == 'Bank') getVerticalSpace(15),
                    if (state.chargeApplicable == 'Bank')
                      Column(
                        children: [
                          _buildTextField(
                            controller: TextEditingController(),
                            label: 'Bank Account Number',
                            icon: Icons.account_balance,
                            validator: (value) => value!.isEmpty ? 'Please enter bank account number' : null,
                          ),
                          getVerticalSpace(15),
                          _buildTextField(
                            controller: TextEditingController(),
                            label: 'Bank Account Name',
                            icon: Icons.account_balance,
                            validator: (value) => value!.isEmpty ? 'Please enter bank account Name' : null,
                          ),
                          getVerticalSpace(15),
                          _buildTextField(
                            controller: TextEditingController(),
                            label: 'Branch Name',
                            icon: Icons.code,
                            validator: (value) => value!.isEmpty ? 'Please enter branch name' : null,
                          ),
                        ],
                      ),
                    if (state.chargeApplicable == 'Phone') getVerticalSpace(15),
                    if (state.chargeApplicable == 'Phone')
                      Column(
                        children: [
                          _buildTextField(
                            controller: TextEditingController(),
                            label: 'Phone Number',
                            icon: Icons.phone_android,
                            validator: (value) => value!.isEmpty ? 'Please enter phone number' : null,
                          ),
                          getVerticalSpace(15),
                          _buildTextField(
                            controller: TextEditingController(),
                            label: 'E-mail',
                            icon: Icons.email,
                            validator: (value) => value!.isEmpty ? 'Please enter e-mail' : null,
                          ),
                        ],
                      ),
                    getVerticalSpace(15),
                    _buildTextField(
                      controller: TextEditingController(),
                      label: 'Your Current Loan Amount with Umoja',
                      icon: Icons.balance,
                      validator: (value) => value!.isEmpty ? 'Please enter your current loan amount with Umoja' : null,
                    ),
                    getVerticalSpace(15),
                    _buildDailyIncomeField(),
                    if (state.dailyIncome == 'Yes') getVerticalSpace(15),
                    if (state.dailyIncome == 'Yes')
                      _buildTextField(
                        controller: TextEditingController(),
                        label: 'How much is your daily income?',
                        icon: Icons.money,
                        validator: (value) => value!.isEmpty ? 'Please enter your daily income' : null,
                      ),
                    getVerticalSpace(15),
                    _buildTextField(
                      controller: TextEditingController(),
                      label: 'How much is your monthly income?',
                      icon: Icons.money,
                      validator: (value) => value!.isEmpty ? 'Please enter your monthly income' : null,
                    ),
                    getVerticalSpace(15),
                    _buildTextField(
                      controller: TextEditingController(),
                      label: 'How much is your monthly expense?',
                      icon: Icons.money,
                      validator: (value) => value!.isEmpty ? 'Please enter your monthly expense' : null,
                    ),
                    getVerticalSpace(15),
                    _buildOtherLoanPurposeField(),
                    if (state.otherLoanPurpose == 'Yes') getVerticalSpace(15),
                    if (state.otherLoanPurpose == 'Yes')
                      _buildTextField(
                        controller: TextEditingController(),
                        label: 'How much?',
                        icon: Icons.money,
                        validator: (value) => value!.isEmpty ? 'Please enter your current loan with other company' : null,
                      ),
                    getVerticalSpace(15),
                    _buildTextField(
                      controller: TextEditingController(),
                      label: 'Who is your Guarantor?',
                      icon: Icons.info_outline,
                      validator: (value) => value!.isEmpty ? 'Please enter your Guarantor\'s name' : null,
                    ),
                    getVerticalSpace(15),
                    _buildTextField(
                      controller: TextEditingController(),
                      label: 'Guarantor\'s Phone Number',
                      icon: Icons.phone_android,
                      validator: (value) => value!.isEmpty ? 'Please enter your Guarantor\'s phone number' : null,
                    ),
                    getVerticalSpace(15),
                    _buildTextField(
                      controller: TextEditingController(),
                      label: 'Relationship with Guarantor',
                      icon: Icons.real_estate_agent_outlined,
                      validator: (value) => value!.isEmpty ? 'Please enter your relationship with Guarantor' : null,
                    ),
                  ],
                ),
                SizedBox(height: getScreenHeight(30)),
                _buildSubmitButton(ref, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard({required List<Widget> children}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getBorderRadius(15)),
      ),
      child: Padding(
        padding: EdgeInsets.all(getScreenWidth(20)),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildNameField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.kPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getBorderRadius(10)),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.kPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getBorderRadius(10)),
        ),
      ),
      validator: (value) => validator != null ? validator(value) : null,
    );
  }

  Widget _buildAppliedLoanAmountWithInterestField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return AbsorbPointer(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getBorderRadius(10)),
          ),
        ),
        // validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Phone Number',
        prefixIcon: const Icon(Icons.phone_android, color: AppColors.kPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getBorderRadius(10)),
        ),
      ),
      validator: (value) => value!.length != 10 ? 'Invalid phone number' : null,
    );
  }

  Widget _buildLoanProductField() {
    return InkWell(
      onTap: _showLoanProducts,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Loan Product',
          prefixIcon: const Icon(Icons.business_center, color: AppColors.kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getBorderRadius(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedLoanProduct ?? 'Select Loan Product',
              style: TextStyle(
                color: _selectedLoanProduct != null ? Colors.black : Colors.grey,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.kPrimaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanPurposeField() {
    return InkWell(
      onTap: () {
        showGenericListModal(
          context: context,
          items: ref.read(applyLoanProvider.notifier).loanPurpose,
          titleBuilder: (value) => value["name"],
          onItemSelected: (value) async {
            ref.read(applyLoanProvider.notifier).setLoanPurpose(value["name"]);
          },
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(15), vertical: getScreenHeight(10)),
        );
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Loan Purpose',
          prefixIcon: const Icon(Icons.business_center, color: AppColors.kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getBorderRadius(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ref.watch(applyLoanProvider).loanPurpose ?? 'Select Loan Purpose',
              style: TextStyle(
                color: ref.watch(applyLoanProvider).loanPurpose != null ? Colors.black : Colors.grey,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.kPrimaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanRepaymentOptionField() {
    return InkWell(
      onTap: () {
        showGenericListModal(
          context: context,
          items: ref.read(applyLoanProvider.notifier).loanRepaymentOption,
          titleBuilder: (value) => value["name"],
          onItemSelected: (value) async {
            ref.read(applyLoanProvider.notifier).setLoanRepaymentOption(value["name"]);
          },
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(15), vertical: getScreenHeight(10)),
        );
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Loan Repayment Option',
          prefixIcon: const Icon(Icons.access_time, color: AppColors.kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getBorderRadius(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ref.watch(applyLoanProvider).loanRepaymentOption ?? 'Select Loan Repayment Option',
              style: TextStyle(
                color: ref.watch(applyLoanProvider).loanRepaymentOption != null ? Colors.black : Colors.grey,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.kPrimaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanChargeApplicableField() {
    return InkWell(
      onTap: () {
        showGenericListModal(
          context: context,
          items: ref.read(applyLoanProvider.notifier).chargeApplicable,
          titleBuilder: (value) => value["name"],
          onItemSelected: (value) async {
            ref.read(applyLoanProvider.notifier).setChargeApplicable(value["name"]);
          },
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(15), vertical: getScreenHeight(10)),
        );
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Do you want to receive the loan through phone or bank account (charge applicable)?',
          prefixIcon: const Icon(Icons.access_time, color: AppColors.kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getBorderRadius(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              ref.watch(applyLoanProvider).chargeApplicable ?? 'Select Option',
              style: TextStyle(
                color: ref.watch(applyLoanProvider).chargeApplicable != null ? Colors.black : Colors.grey,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.kPrimaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyIncomeField() {
    return InkWell(
      onTap: () {
        showGenericListModal(
          context: context,
          items: ref.read(applyLoanProvider.notifier).isDailyIncome,
          titleBuilder: (value) => value["name"],
          onItemSelected: (value) async {
            ref.read(applyLoanProvider.notifier).setDailyIncome(value["name"]);
          },
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(15), vertical: getScreenHeight(10)),
        );
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Is your income daily?',
          prefixIcon: const Icon(Icons.add_shopping_cart_rounded, color: AppColors.kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getBorderRadius(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              ref.watch(applyLoanProvider).dailyIncome ?? 'Select Option',
              style: TextStyle(
                color: ref.watch(applyLoanProvider).dailyIncome != null ? Colors.black : Colors.grey,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: AppColors.kPrimaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildOtherLoanPurposeField() {
    return InkWell(
      onTap: () {
        showGenericListModal(
          context: context,
          items: ref.read(applyLoanProvider.notifier).isOtherLoanPurpose,
          titleBuilder: (value) => value["name"],
          onItemSelected: (value) async {
            ref.read(applyLoanProvider.notifier).setOtherLoanPurpose(value["name"]);
          },
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(15), vertical: getScreenHeight(10)),
        );
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Do you have any loan with other company?',
          prefixIcon: const Icon(Icons.account_balance_rounded, color: AppColors.kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(getBorderRadius(10)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              ref.watch(applyLoanProvider).otherLoanPurpose ?? 'Select Option',
              style: TextStyle(
                color: ref.watch(applyLoanProvider).otherLoanPurpose != null ? Colors.black : Colors.grey,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.kPrimaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: 'Loan Amount',
        prefixIcon: const Icon(Icons.currency_exchange, color: AppColors.kPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getBorderRadius(10)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) return 'Please enter amount';
        if (int.parse(value) < 1000) return 'Minimum amount 1,000';
        return null;
      },
      onChanged: (value) {
        final input = double.tryParse(value) ?? 0.0;

        final maxAllowed = widget.totalApprovedLoanAmount * 0.3;

        if (input > maxAllowed) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.info(
              message: 'You can only apply for a maximum of ${maxAllowed.toStringAsFixed(2)}',
            ),
          );
        }
      },
    );
  }

  Widget _buildSubmitButton(WidgetRef ref, BuildContext context) {
    final state = ref.watch(applyLoanProvider);
    final notifier = ref.read(applyLoanProvider.notifier);
    return Container(
      width: double.infinity,
      height: getScreenHeight(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getBorderRadius(15)),
        color: AppColors.kPrimaryColor,
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
          // if (_formKey.currentState!.validate()) {
          if (_formKey.currentState?.validate() == false) {
            sharedPrefIsApplyOperation.updateValue(true);
            final success = await notifier.applyLoan(
              token: sharedPrefAccessToken.value!.isEmpty ? null : sharedPrefAccessToken.value,
              body: {
              'firstName': _firstNameController.text,
              'lastName': _lastNameController.text,
              'phoneNumber': _phoneController.text,
              'productId': _selectedLoanProduct ?? '',
              'loanAmount': _amountController.text,
              'purposeId': state.loanPurpose ?? '',
              'loanRepaymentOption': state.loanRepaymentOption ?? '',
              'interest': '20%', // Placeholder, adjust as needed
              'currentLoanAmount': '',
              'isDailyIncome': state.dailyIncome ?? '',
              'monthlyIncome': state.otherLoanPurpose ?? '',
              'monthlyExpense':  '',
              'haveAnyLoan':  '',
              'guarantor':  '',
              'guarantorPhoneNumber':  '',
              'guarantorRelationship':  '',
            });
            return success;

          } else {
            return null;
          }
        },
        onDone: (isSuccess) {
          if(isSuccess == true){
            ref.read(applyLoanProvider.notifier).resetFields();
          GoRouter.of(context).pop();
          }
        },
        child: Text(
          'SUBMIT APPLICATION',
          style: TextStyle(
            fontSize: getFontSize(16),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
