import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () {
              // TODO: Clear all notifications
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // Example count
        itemBuilder: (context, index) {
          return _buildNotificationCard(
            title: _getNotificationTitle(index),
            message: _getNotificationMessage(index),
            time: _getNotificationTime(index),
            type: _getNotificationType(index),
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String time,
    required NotificationType type,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _getNotificationColor(type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getNotificationIcon(type),
            color: _getNotificationColor(type),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.grey),
          onPressed: () {
            // TODO: Show notification options
          },
        ),
      ),
    );
  }

  String _getNotificationTitle(int index) {
    final titles = [
      'Order Confirmed',
      'Order Delivered',
      'Special Offer',
      'Payment Successful',
      'Order Status Update',
      'New Feature',
      'Promotion',
      'Order Cancelled',
      'Refund Processed',
      'Welcome Bonus',
    ];
    return titles[index % titles.length];
  }

  String _getNotificationMessage(int index) {
    final messages = [
      'Your order #12345 has been confirmed',
      'Your order has been delivered successfully',
      'Get 20% off on your next order',
      'Payment of ₹299 has been processed',
      'Your order is out for delivery',
      'Check out our new features',
      'Weekend special: Buy 1 Get 1 Free',
      'Your order has been cancelled',
      'Refund of ₹299 has been processed',
      'Welcome! Get ₹100 off on your first order',
    ];
    return messages[index % messages.length];
  }

  String _getNotificationTime(int index) {
    final times = [
      '2 minutes ago',
      '1 hour ago',
      '2 hours ago',
      '3 hours ago',
      '5 hours ago',
      '1 day ago',
      '2 days ago',
      '3 days ago',
      '1 week ago',
      '2 weeks ago',
    ];
    return times[index % times.length];
  }

  NotificationType _getNotificationType(int index) {
    final types = [
      NotificationType.order,
      NotificationType.delivery,
      NotificationType.offer,
      NotificationType.payment,
      NotificationType.status,
      NotificationType.feature,
      NotificationType.promotion,
      NotificationType.cancellation,
      NotificationType.refund,
      NotificationType.welcome,
    ];
    return types[index % types.length];
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.shopping_bag_outlined;
      case NotificationType.delivery:
        return Icons.local_shipping_outlined;
      case NotificationType.offer:
        return Icons.local_offer_outlined;
      case NotificationType.payment:
        return Icons.payment_outlined;
      case NotificationType.status:
        return Icons.info_outline;
      case NotificationType.feature:
        return Icons.new_releases_outlined;
      case NotificationType.promotion:
        return Icons.campaign_outlined;
      case NotificationType.cancellation:
        return Icons.cancel_outlined;
      case NotificationType.refund:
        return Icons.assignment_return_outlined;
      case NotificationType.welcome:
        return Icons.celebration_outlined;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Colors.blue;
      case NotificationType.delivery:
        return Colors.green;
      case NotificationType.offer:
        return Colors.orange;
      case NotificationType.payment:
        return Colors.purple;
      case NotificationType.status:
        return Colors.blue;
      case NotificationType.feature:
        return Colors.teal;
      case NotificationType.promotion:
        return Colors.red;
      case NotificationType.cancellation:
        return Colors.red;
      case NotificationType.refund:
        return Colors.orange;
      case NotificationType.welcome:
        return Colors.green;
    }
  }
}

enum NotificationType {
  order,
  delivery,
  offer,
  payment,
  status,
  feature,
  promotion,
  cancellation,
  refund,
  welcome,
}
