import 'package:flutter/material.dart';

class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Address'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildAddressCard(
            'Home',
            '123 Main Street, Apartment 4B',
            'New York, NY 10001',
            true,
          ),
          _buildAddressCard(
            'Office',
            '456 Business Ave, Suite 200',
            'New York, NY 10002',
            false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add new address functionality
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddressCard(
    String title,
    String address1,
    String address2,
    bool isDefault,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Default',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(address1),
            Text(address2),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Implement edit functionality
                  },
                  child: const Text('Edit'),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Implement delete functionality
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
