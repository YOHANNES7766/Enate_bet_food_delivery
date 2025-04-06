import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: 2,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.shopping_bag, color: Colors.orange),
              ),
              title: Text('Order #${1001 + index}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text('Status: ${index == 0 ? 'In Progress' : 'Delivered'}'),
                  const SizedBox(height: 4),
                  Text(
                      'Date: ${DateTime.now().subtract(Duration(days: index)).toString().split('.')[0]}'),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Add order details navigation
              },
            ),
          );
        },
      ),
    );
  }
}
