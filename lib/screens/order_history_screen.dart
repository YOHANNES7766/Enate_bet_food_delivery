import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Order History',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _dummyOrders.length,
        itemBuilder: (context, index) {
          final order = _dummyOrders[index];
          return _buildOrderCard(order);
        },
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  order.date,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...order.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.quantity}x ${item.name}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Implement reorder functionality
                  },
                  child: const Text('Reorder'),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Implement view details functionality
                  },
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color color;
    String text;

    switch (status) {
      case OrderStatus.delivered:
        color = Colors.green;
        text = 'Delivered';
        break;
      case OrderStatus.processing:
        color = Colors.orange;
        text = 'Processing';
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

enum OrderStatus { delivered, processing, cancelled }

class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class Order {
  final String id;
  final String date;
  final List<OrderItem> items;
  final double total;
  final OrderStatus status;

  Order({
    required this.id,
    required this.date,
    required this.items,
    required this.total,
    required this.status,
  });
}

final List<Order> _dummyOrders = [
  Order(
    id: '12345',
    date: 'March 15, 2024',
    items: [
      OrderItem(name: 'Margherita Pizza', quantity: 2, price: 12.99),
      OrderItem(name: 'Coca Cola', quantity: 2, price: 2.99),
    ],
    total: 31.96,
    status: OrderStatus.delivered,
  ),
  Order(
    id: '12344',
    date: 'March 14, 2024',
    items: [
      OrderItem(name: 'Chicken Burger', quantity: 1, price: 8.99),
      OrderItem(name: 'French Fries', quantity: 1, price: 3.99),
      OrderItem(name: 'Milkshake', quantity: 1, price: 4.99),
    ],
    total: 17.97,
    status: OrderStatus.delivered,
  ),
  Order(
    id: '12343',
    date: 'March 13, 2024',
    items: [
      OrderItem(name: 'Vegetable Salad', quantity: 1, price: 7.99),
      OrderItem(name: 'Green Tea', quantity: 1, price: 2.99),
    ],
    total: 10.98,
    status: OrderStatus.cancelled,
  ),
  Order(
    id: '12342',
    date: 'March 12, 2024',
    items: [
      OrderItem(name: 'Pasta Carbonara', quantity: 1, price: 11.99),
      OrderItem(name: 'Garlic Bread', quantity: 1, price: 3.99),
      OrderItem(name: 'Water', quantity: 1, price: 1.99),
    ],
    total: 17.97,
    status: OrderStatus.processing,
  ),
];
