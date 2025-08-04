import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loanapp/core/config/routes/app_routes.dart';
import 'package:loanapp/core/constants/colors/app_colors.dart';
import 'package:loanapp/core/preferences/preferences.dart';
import 'package:loanapp/core/utils/size_config.dart';
import 'package:loanapp/src/features/loan_details_screen/loan_details_screen.dart';
import 'package:loanapp/src/widgets/on_process_button_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomeScreen extends StatelessWidget {
  final List<Loan> loans = [
    // Loan(
    //   type: 'Business Loan',
    //   amount: '2,00,000',
    //   status: 'Approved',
    //   date: '2024-03-10',
    //   weekPending: 9,
    //   interest: 20000.0,
    //   totalLoanDue: 220000.0,
    //   collection: 30000.0,
    //   outstanding: 190000.0,
    //   overdue: 10000.0,
    //   disbarmentDate: '10/Mar/2025',
    //   loanStatus: 'Active',
    // ),
    // if (sharedPrefIsApplyOperation.value == true)
    //   Loan(
    //     type: 'Personal Loan',
    //     amount: '60,000',
    //     status: 'Pending',
    //     date: '2024-03-10',
    //     weekPending: 8,
    //     interest: 6000.0,
    //     totalLoanDue: 66000.0,
    //     collection: 0.0,
    //     outstanding: 66000.0,
    //     overdue: 0.0,
    //     disbarmentDate: '10/Mar/2025',
    //     loanStatus: 'Active',
    //   ),
  
  ];

  HomeScreen({super.key});

  bool get canApplyForLoan {
    return !loans.any((loan) => loan.weekPending <= 8 || loan.status == 'Pending');
  }

  double get totalApprovedLoanAmount {
    return loans
        .where((loan) => loan.status == 'Approved')
        .fold(0.0, (sum, loan) => sum + double.parse(loan.amount.replaceAll(',', '')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomBar(theme),
      body: _buildBody(context, theme),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Loan Dashboard',
        style: TextStyle(color: AppColors.kWhiteColor),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.kWhiteColor),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: AppColors.kSecondaryColor,
        ),
      ),
    );
  }

  Widget? _buildBottomBar(TextTheme theme) {
    if (canApplyForLoan) return null;
    
    return SafeArea(
      child: Container(
        height: getScreenHeight(40),
        color: AppColors.kErrorColor,
        child: Center(
          child: Text(
            'You have Existing Loans',
            style: theme.displaySmall?.copyWith(
              color: AppColors.kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, TextTheme theme) {
    return Container(
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
      child: Column(
        children: [
          _buildActionButtons(context),
          _buildSecurityDepositCard(theme),
          getVerticalSpace(15),
          _buildLoanList(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getScreenWidth(20)),
      child: Row(
        children: [
          _buildActionButton(
            context: context,
            title: 'App Loan',
            icon: Icons.add_circle_outline,
            color: AppColors.kPrimaryColor,
            onPressed: _handleApplyLoanPress,
          ),
          SizedBox(width: getScreenWidth(15)),
          _buildActionButton(
            context: context,
            title: 'Existing Loans',
            icon: Icons.history,
            color: AppColors.kSecondaryColor,
            onPressed: _handleExistingLoansPress,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityDepositCard(TextTheme theme) {
    return OnProcessButtonWidget(
      boxShadow: [
        BoxShadow(
          color: AppColors.kBlackColor.withValues(alpha: 0.2),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
      backgroundColor: AppColors.kWhiteColor,
      contentPadding: EdgeInsets.symmetric(
        vertical: getScreenHeight(15),
        horizontal: getScreenWidth(15),
      ),
      margin: EdgeInsets.symmetric(horizontal: getScreenWidth(15)),
      enable: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Security Deposited :',
            style: theme.bodyMedium?.copyWith(color: AppColors.kCardDarkColor),
          ),
          Text(
            loans.isEmpty ? '0' :'20,000',
            style: theme.bodyMedium?.copyWith(color: AppColors.kCardDarkColor),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: getScreenWidth(15)),
        itemCount: loans.length,
        itemBuilder: (context, index) {
          return _buildLoanCard(
            ctx: context,
            loan: loans[index],
            onTap: () => _navigateToLoanDetails(context),
          );
        },
      ),
    );
  }

  void _handleApplyLoanPress(BuildContext context) {
    if (!canApplyForLoan) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.info(
          message: "You have a pending personal loan or you have due 8 weeks",
        ),
      );
      return;
    }
    GoRouter.of(context).pushNamed(
      RouteName.applyLoanScreen,
      extra: totalApprovedLoanAmount,
    );
  }

  void _handleExistingLoansPress(BuildContext context) {
    GoRouter.of(context).pushNamed(RouteName.existingLoanScreen);
  }

  void _navigateToLoanDetails(BuildContext context) {
    // Dummy data for testing
    final dummyLoanDetails = LoanDetails(
      loanType: 'Personal Loan',
      totalAmount: '50000.00',
      paidAmount: '15000.00',
      remainingAmount: '35000.00',
      interestRate: '12.5%',
      disbursementDate: '15 Mar 2024',
      dueDate: '15 Sep 2024',
      installment: 8,
      paymentSchedule: [
        PaymentSchedule(
          installmentNumber: 'Installment #1',
          dueDate: '15 Apr 2024',
          amount: '8500.00',
          status: 'Paid',
        ),
        PaymentSchedule(
          installmentNumber: 'Installment #2',
          dueDate: '15 May 2024',
          amount: '8500.00',
          status: 'Due',
        ),
        // Add more payment schedules as needed
      ],
    );

    GoRouter.of(context).pushNamed(
      RouteName.loanDetailsScreen,
      extra: dummyLoanDetails,
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required Function(BuildContext) onPressed,
    bool isShowIcon = true,
  }) {
    return Expanded(
      child: Container(
        height: getScreenHeight(100),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(getBorderRadius(15)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(getBorderRadius(15)),
            onTap: () => onPressed(context),
            child: Padding(
              padding: EdgeInsets.all(getScreenWidth(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isShowIcon)
                    Icon(icon, size: getScreenHeight(30), color: color),
                  if (isShowIcon) SizedBox(height: getScreenHeight(10)),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: getFontSize(16),
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoanCard({
    required Loan loan,
    required void Function()? onTap,
    required BuildContext ctx,
  }) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.only(bottom: getScreenHeight(15)),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getBorderRadius(15)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLoanIcon(),
                _buildLoanDetails(loan),
              ],
            ),
          ),
          if (canApplyForLoan && sharedPrefIsApplyOperation.value == false)
            // _buildApplyNowSection(ctx),
                    Positioned(
          left: getScreenWidth(15),
          bottom: getScreenHeight(68),
          child: Text(
            '  You are eligible for easy loan',
            style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontSize: getFontSize(getFontSize(20)),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
     if (canApplyForLoan && sharedPrefIsApplyOperation.value == false)    Positioned(
          left: getScreenWidth(50),
          right: getScreenWidth(50),
          bottom: getScreenHeight(25),
          child: OnProcessButtonWidget(
            onDone: (_) {
              GoRouter.of(ctx).pushNamed(
                RouteName.applyLoanScreen,
                extra: totalApprovedLoanAmount,
              );
            },
            backgroundColor: Colors.green,
            child: Text(
              'Apply Now',
              style: TextStyle(
                color: AppColors.kWhiteColor,
                fontSize: getFontSize(getFontSize(14)),
              ),
            ),
          ),
        ),
      
        ],
      ),
    );
  }

  Widget _buildLoanIcon() {
    return Padding(
      padding: EdgeInsets.all(getScreenWidth(20)),
      child: Container(
        padding: EdgeInsets.all(getScreenWidth(10)),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(getBorderRadius(10)),
        ),
        child: const Icon(
          Icons.account_balance_wallet,
          color: AppColors.kPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildLoanDetails(Loan loan) {
    return Expanded(
      child: ListTile(
        contentPadding: EdgeInsets.only(
          top: getScreenWidth(20),
          right: getScreenWidth(20),
          bottom: getScreenWidth(20),
        ),
        title: Text(
          loan.type,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getFontSize(16),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLoanDetailRow('Amount:', loan.amount),
            _buildLoanDetailRow('Interest:', loan.interest.toString()),
            _buildLoanDetailRow('Total Loan Due:', loan.totalLoanDue.toString()),
            _buildLoanDetailRow('Collection:', loan.collection.toString()),
            _buildLoanDetailRow('OutStanding:', loan.outstanding.toString()),
            _buildLoanDetailRow('OverDue:', loan.overdue.toString()),
            _buildLoanDetailRow(
              'Disbursement Date:',
              loan.disbarmentDate.toString(),
            ),
            _buildLoanDetailRow('Loan Status:', loan.loanStatus.toString()),
            getVerticalSpace(15),
            _buildActionButtonsForLoan(),
            if (canApplyForLoan) getVerticalSpace(75),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanDetailRow(String label, String value) {
    return Column(
      children: [
        getVerticalSpace(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: getFontSize(14))),
            Text(value, style: TextStyle(fontSize: getFontSize(14))),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtonsForLoan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OnProcessButtonWidget(
          borderRadius: BorderRadius.circular(getBorderRadius(13)),
          border: Border.all(
            color: AppColors.kErrorColor,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          backgroundColor: Colors.transparent,
          child: Text(
            'Schedule',
            style: TextStyle(
              color: AppColors.kErrorColor,
              fontSize: getFontSize(14),
            ),
          ),
        ),
        getHorizontalSpace(15),
        OnProcessButtonWidget(
          borderRadius: BorderRadius.circular(getBorderRadius(13)),
          border: Border.all(
            color: Colors.green,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          backgroundColor: Colors.transparent,
          child: Text(
            'Collection',
            style: TextStyle(
              color: Colors.green,
              fontSize: getFontSize(14),
            ),
          ),
        ),
      ],
    );
  }

}

class Loan {
  final String type;
  final String amount;
  final String status;
  final String date;
  final int weekPending;
  final double interest;
  final double totalLoanDue;
  final double collection;
  final double outstanding;
  final double overdue;
  final String disbarmentDate;
  final String loanStatus;

  Loan({
    required this.type,
    required this.amount,
    required this.status,
    required this.date,
    required this.weekPending,
    this.interest = 0.0,
    this.totalLoanDue = 0.0,
    this.collection = 0.0,
    this.outstanding = 0.0,
    this.overdue = 0.0,
    this.disbarmentDate = '',
    this.loanStatus = '',
  });
}