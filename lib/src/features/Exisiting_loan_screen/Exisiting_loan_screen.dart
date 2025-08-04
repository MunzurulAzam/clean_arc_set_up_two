import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loanapp/core/config/routes/app_routes.dart';
import 'package:loanapp/core/constants/colors/app_colors.dart';
import 'package:loanapp/core/utils/size_config.dart';
import 'package:loanapp/src/features/loan_details_screen/loan_details_screen.dart';
import 'package:loanapp/src/widgets/on_process_button_widget.dart';

class ExistingLoanScreen extends StatelessWidget {
  const ExistingLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildLoanList(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Existing Loan List',
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

  Widget _buildLoanList() {
    final loans = _generateLoanData();
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: getScreenWidth(20),
        vertical: getScreenHeight(15),
      ),
      itemCount: loans.length,
      itemBuilder: (context, index) {
        return _buildLoanCard(
          loan: loans[index],
          onTap: () => _navigateToLoanDetails(context),
        );
      },
    );
  }

  List<Loan> _generateLoanData() {
    return [
      Loan(
        type: 'Umoja Micro Loan',
        amount: '2,00,000',
        status: 'Approved',
        date: '2024-03-10',
        weekPending: 7,
        interest: 20000.0,
        totalLoanDue: 220000.0,
        collection: 30000.0,
        outstanding: 190000.0,
        overdue: 10000.0,
        disbarmentDate: '10/Mar/2025',
        loanStatus: 'Active',
      ),
      Loan(
        type: 'Umoja Micro Loan',
        amount: '2,00,000',
        status: 'Approved',
        date: '2024-03-10',
        weekPending: 7,
        interest: 20000.0,
        totalLoanDue: 220000.0,
        collection: 30000.0,
        outstanding: 190000.0,
        overdue: 10000.0,
        disbarmentDate: '10/Mar/2025',
        loanStatus: 'close',
      ),
    ];
  }

  void _navigateToLoanDetails(BuildContext context) {
    final dummyLoanDetails = LoanDetails(
      loanType: 'Personal Loan',
      totalAmount: '50000.00',
      paidAmount: '15000.00',
      remainingAmount: '35000.00',
      interestRate: '12.5%',
      disbursementDate: '15 Mar 2024',
      dueDate: '15 Sep 2024',
      paymentSchedule: _generatePaymentSchedule(),
    );

    GoRouter.of(context).pushNamed(
      RouteName.loanDetailsScreen,
      extra: dummyLoanDetails,
    );
  }

  List<PaymentSchedule> _generatePaymentSchedule() {
    return [
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
      PaymentSchedule(
        installmentNumber: 'Installment #3',
        dueDate: '15 Jun 2024',
        amount: '8500.00',
        status: 'Pending',
      ),
      PaymentSchedule(
        installmentNumber: 'Installment #4',
        dueDate: '15 Jul 2024',
        amount: '8500.00',
        status: 'Pending',
      ),
      PaymentSchedule(
        installmentNumber: 'Installment #5',
        dueDate: '15 Aug 2024',
        amount: '8500.00',
        status: 'Pending',
      ),
      PaymentSchedule(
        installmentNumber: 'Installment #6',
        dueDate: '15 Sep 2024',
        amount: '8500.00',
        status: 'Pending',
      ),
    ];
  }

  Widget _buildLoanCard({
    required Loan loan,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
            if (loan.loanStatus != 'close') ...[
              _buildLoanDetailRow('Total Loan Due:', loan.totalLoanDue.toString()),
              _buildLoanDetailRow('Collection:', loan.collection.toString()),
              _buildLoanDetailRow('OutStanding:', loan.outstanding.toString()),
              _buildLoanDetailRow('OverDue:', loan.overdue.toString()),
            ],
            _buildLoanDetailRow('Disbursement Date:', loan.disbarmentDate),
            _buildLoanDetailRow('Loan Status:', loan.loanStatus),
            _buildActionButtons(),
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

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.only(top: getScreenHeight(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildActionButton(
            text: 'Schedule',
            color: AppColors.kErrorColor,
          ),
          getHorizontalSpace(15),
          _buildActionButton(
            text: 'Collection',
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
  }) {
    return OnProcessButtonWidget(
      borderRadius: BorderRadius.circular(getBorderRadius(13)),
      border: Border.all(
        color: color,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      backgroundColor: Colors.transparent,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: getFontSize(14),
        ),
      ),
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