import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountDetailsCard extends StatelessWidget {
  const AccountDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0.r, 5.r),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildDetailRow('Member Since', 'December 2024'),
            SizedBox(height: 16.r),
            _buildDetailRow('Member From', 'Egypt'),
            SizedBox(height: 16.r),
            _buildDetailRow('Account Status', 'Active',
                valueColor: Colors.green),
          ],
        ),
      ),
    );
  }
}
Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          color: valueColor ?? Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    ],
  );
}