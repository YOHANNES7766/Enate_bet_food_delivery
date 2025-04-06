import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _faqItems = [
    {
      'question': 'How do I track my order?',
      'answer':
          'You can track your order by going to the Orders tab and selecting your current order. You\'ll see real-time updates of your order status and delivery progress.',
    },
    {
      'question': 'How can I change my delivery address?',
      'answer':
          'To change your delivery address, go to Profile > Addresses > Edit. You can update your address before placing a new order.',
    },
    {
      'question': 'What payment methods are accepted?',
      'answer':
          'We accept credit/debit cards, digital wallets (PayPal, Google Pay, Apple Pay), and cash on delivery.',
    },
    {
      'question': 'How do I cancel my order?',
      'answer':
          'You can cancel your order within 5 minutes of placing it. Go to Orders > Select the order > Cancel Order.',
    },
  ];

  List<Map<String, dynamic>> _getContactItems() {
    return [
      {
        'title': 'Email Support',
        'action': () async {
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'support@enatebet.com',
          );
          if (await canLaunchUrl(emailLaunchUri)) {
            await launchUrl(emailLaunchUri);
          }
        },
      },
      {
        'title': 'Phone Support',
        'action': () async {
          final Uri phoneLaunchUri = Uri(
            scheme: 'tel',
            path: '+1234567890',
          );
          if (await canLaunchUrl(phoneLaunchUri)) {
            await launchUrl(phoneLaunchUri);
          }
        },
      },
      {
        'title': 'Live Chat',
        'action': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Live chat feature coming soon!')),
          );
        },
      },
    ];
  }

  List<Map<String, dynamic>> _getAccountItems() {
    return [
      {
        'title': 'Order History',
        'action': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order history feature coming soon!')),
          );
        },
      },
      {
        'title': 'Refund Policy',
        'action': () {
          _showPolicyDialog('Refund Policy',
              'Our refund policy ensures that you get your money back if there are any issues with your order...');
        },
      },
      {
        'title': 'Privacy Policy',
        'action': () {
          _showPolicyDialog('Privacy Policy',
              'We take your privacy seriously. Here\'s how we handle your data...');
        },
      },
      {
        'title': 'Terms of Service',
        'action': () {
          _showPolicyDialog('Terms of Service',
              'By using our service, you agree to these terms...');
        },
      },
    ];
  }

  void _showPolicyDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(content),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFAQDialog(String question, String answer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(question),
        content: Text(answer),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredFAQs() {
    if (_searchQuery.isEmpty) return _faqItems;
    return _faqItems
        .where((item) => item['question']
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final contactItems = _getContactItems();
    final accountItems = _getAccountItems();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Help & Support',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchBar(),
          const SizedBox(height: 24),
          _buildSection(
            'Frequently Asked Questions',
            _getFilteredFAQs()
                .map((item) => item['question'] as String)
                .toList(),
            onTap: (index) => _showFAQDialog(
              _getFilteredFAQs()[index]['question'],
              _getFilteredFAQs()[index]['answer'],
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Contact Us',
            contactItems.map((item) => item['title'] as String).toList(),
            onTap: (index) => contactItems[index]['action'](),
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Account & Orders',
            accountItems.map((item) => item['title'] as String).toList(),
            onTap: (index) => accountItems[index]['action'](),
          ),
          const SizedBox(height: 24),
          _buildEmergencySupport(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search for help',
        prefixIcon: const Icon(Icons.search, color: Colors.orange),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _searchQuery = '';
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.orange),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  Widget _buildSection(String title, List<String> items,
      {required Function(int) onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...items.asMap().entries.map((entry) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(entry.value),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => onTap(entry.key),
              ),
            )),
      ],
    );
  }

  Widget _buildEmergencySupport() {
    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(
              Icons.emergency,
              color: Colors.orange,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Need Immediate Assistance?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Our support team is available 24/7 to help you',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final Uri phoneLaunchUri = Uri(
                  scheme: 'tel',
                  path: '+1234567890',
                );
                if (await canLaunchUrl(phoneLaunchUri)) {
                  await launchUrl(phoneLaunchUri);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: const Text('Contact Support'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
