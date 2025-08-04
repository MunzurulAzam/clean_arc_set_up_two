import 'package:flutter/material.dart';
import 'package:loanapp/core/constants/colors/app_colors.dart';
import 'package:loanapp/core/utils/size_config.dart';

class LoanDetailsScreen extends StatelessWidget {
  final LoanDetails loanDetails;

  const LoanDetailsScreen({super.key, required this.loanDetails});

  @override
  Widget build(BuildContext context) {
     //! calculate total loan amount
    return Scaffold(
      appBar: AppBar(
        title: const Text( "Loan Details" ,//loanDetails.loanType,
            style: TextStyle(color: AppColors.kWhiteColor)),
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
              AppColors.kBgColor.withValues(alpha:  0.1),
              AppColors.kPrimaryColor.withValues(alpha:  0.05),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(getScreenWidth(20)),
          child: Column(
            children: [
              _buildLoanSummaryCard(),
              SizedBox(height: getScreenHeight(20)),
              _buildCollectionProgress(),
              SizedBox(height: getScreenHeight(20)),
              _buildPaymentSchedule(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoanSummaryCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getBorderRadius(15)),
      ),
      child: Padding(
        padding: EdgeInsets.all(getScreenWidth(20)),
        child: Column(
          children: [
            _buildDetailRow('Loan Amount', loanDetails.totalAmount),
            // _buildDetailRow('Interest Rate', '${loanDetails.interestRate}%'),
            _buildDetailRow('Disbursement Date', loanDetails.disbursementDate),
            _buildDetailRow('Due Date', loanDetails.dueDate),
            _buildDetailRow('Remaining Balance', loanDetails.remainingAmount),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getScreenHeight(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
            fontSize: getFontSize(14),
            color: Colors.grey.shade600,
          )),
          Text(value, style: TextStyle(
            fontSize: getFontSize(14),
            fontWeight: FontWeight.bold,
          )),
        ],
      ),
    );
  }

  Widget _buildCollectionProgress() {
    double progress = double.parse(loanDetails.paidAmount) / double.parse(loanDetails.totalAmount);
    
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getBorderRadius(15)),
      ),
      child: Padding(
        padding: EdgeInsets.all(getScreenWidth(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Loan Progress', 
                    style: TextStyle(
                      fontSize: getFontSize(16),
                      fontWeight: FontWeight.bold,
                    )),
                Text('${(progress * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            SizedBox(height: getScreenHeight(15)),
            LinearProgressIndicator(
              value: progress,
              minHeight: getScreenHeight(10),
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
              borderRadius: BorderRadius.circular(getBorderRadius(10)),
            ),
            SizedBox(height: getScreenHeight(15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAmountIndicator('Paid', loanDetails.paidAmount),
                _buildAmountIndicator('Remaining', loanDetails.remainingAmount),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountIndicator(String title, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
          fontSize: getFontSize(12),
          color: Colors.grey.shade600,
        )),
        Text(amount, style: TextStyle(
          fontSize: getFontSize(16),
          fontWeight: FontWeight.bold,
          color: title == 'Paid' ? Colors.green : AppColors.kPrimaryColor,
        )),
      ],
    );
  }

  Widget _buildPaymentSchedule() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getBorderRadius(15)),
      ),
      child: Padding(
        padding: EdgeInsets.all(getScreenWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Repayment Schedule',
                style: TextStyle(
                  fontSize: getFontSize(16),
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: getScreenHeight(15)),
            ...loanDetails.paymentSchedule.map((payment) => 
              _buildPaymentItem(payment)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentItem(PaymentSchedule payment) {
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.pending;
    
    if (payment.status == 'Paid') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else if (payment.status == 'Due') {
      statusColor = Colors.orange;
      statusIcon = Icons.warning;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: getScreenHeight(8)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: EdgeInsets.all(getScreenWidth(10)),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha:  0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(payment.dueDate,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(payment.installmentNumber),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(payment.amount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getFontSize(14),
                )),
            Text(payment.status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: getFontSize(12)),
                ),
          ],
        ),
      ),
    );
  }
}

// Data Models
class LoanDetails {
  final String loanType;
  final String totalAmount;
  final String paidAmount;
  final String remainingAmount;
  final String interestRate;
  final String disbursementDate;
  final String dueDate;
  final int? installment;
  final List<PaymentSchedule> paymentSchedule;

  LoanDetails({
    required this.loanType,
    required this.totalAmount,
    required this.paidAmount,
    required this.remainingAmount,
    required this.interestRate,
    required this.disbursementDate,
    required this.dueDate,
    required this.paymentSchedule,
     this.installment,
  });
}

class PaymentSchedule {
  final String installmentNumber;
  final String dueDate;
  final String amount;
  final String status;

  PaymentSchedule({
    required this.installmentNumber,
    required this.dueDate,
    required this.amount,
    required this.status,
  });
}