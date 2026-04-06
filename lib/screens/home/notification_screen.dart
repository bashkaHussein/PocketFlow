import 'package:flutter/material.dart';
import 'package:pocket_flow/screens/auth/login_screen_widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildNotificationItem(
            icon: Icons.account_balance_wallet,
            title: 'Salary Credited',
            desc: 'Your salary for February has been credited to your account.',
            time: '2 hours ago',
            color: AppColors.primaryGreen,
            isNew: true,
          ),
          _buildNotificationItem(
            icon: Icons.warning_amber_rounded,
            title: 'Low Balance Alert',
            desc: 'Your balance is below \$500.00. Please top up soon.',
            time: '1 day ago',
            color: AppColors.errorRed,
            isNew: false,
          ),
          _buildNotificationItem(
            icon: Icons.security_rounded,
            title: 'Security Update',
            desc: 'We have updated our terms of service for better security.',
            time: '2 days ago',
            color: AppColors.darkBlue,
            isNew: false,
          ),
          _buildNotificationItem(
            icon: Icons.redeem_rounded,
            title: 'New Offer!',
            desc: 'Get 5% cashback on all utility bills this month.',
            time: '3 days ago',
            color: Colors.orange,
            isNew: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String desc,
    required String time,
    required Color color,
    required bool isNew,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isNew ? color.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isNew ? Border.all(color: color.withOpacity(0.2)) : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textDark,
                        ),
                      ),
                      if (isNew)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
