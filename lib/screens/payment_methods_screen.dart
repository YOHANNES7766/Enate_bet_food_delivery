import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      type: PaymentType.bankAccount,
      cardNumber: 'Commercial Bank of Ethiopia',
      cardHolder: 'Jo',
      expiryDate: 'N/A',
      isDefault: true,
    ),
    PaymentMethod(
      type: PaymentType.bankAccount,
      cardNumber: 'Tele Birr',
      cardHolder: 'Jo',
      expiryDate: 'N/A',
      isDefault: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Payment Methods',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                final paymentMethod = _paymentMethods[index];
                return _buildPaymentMethodCard(paymentMethod);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => _showAddPaymentMethodDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Add New Payment Method',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod paymentMethod) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: paymentMethod.isDefault ? Colors.orange : Colors.grey.shade300,
          width: paymentMethod.isDefault ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      paymentMethod.type == PaymentType.creditCard
                          ? Icons.credit_card
                          : Icons.account_balance,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      paymentMethod.type == PaymentType.creditCard
                          ? 'Credit Card'
                          : 'Bank Account',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (paymentMethod.isDefault)
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              paymentMethod.cardNumber,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  paymentMethod.cardHolder,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Expires: ${paymentMethod.expiryDate}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _editPaymentMethod(paymentMethod),
                  child: const Text('Edit'),
                ),
                TextButton(
                  onPressed: () => _deletePaymentMethod(paymentMethod),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPaymentMethodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const PaymentMethodDialog(),
    );
  }

  void _editPaymentMethod(PaymentMethod paymentMethod) {
    showDialog(
      context: context,
      builder: (context) => PaymentMethodDialog(paymentMethod: paymentMethod),
    );
  }

  void _deletePaymentMethod(PaymentMethod paymentMethod) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Payment Method'),
        content: const Text(
          'Are you sure you want to delete this payment method?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _paymentMethods.remove(paymentMethod);
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

enum PaymentType { creditCard, bankAccount }

class PaymentMethod {
  final PaymentType type;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final bool isDefault;

  PaymentMethod({
    required this.type,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.isDefault,
  });
}

class PaymentMethodDialog extends StatefulWidget {
  final PaymentMethod? paymentMethod;

  const PaymentMethodDialog({super.key, this.paymentMethod});

  @override
  State<PaymentMethodDialog> createState() => _PaymentMethodDialogState();
}

class _PaymentMethodDialogState extends State<PaymentMethodDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _cardNumberController;
  late TextEditingController _cardHolderController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cvvController;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    _cardNumberController = TextEditingController(
      text: widget.paymentMethod?.cardNumber ?? '',
    );
    _cardHolderController = TextEditingController(
      text: widget.paymentMethod?.cardHolder ?? '',
    );
    _expiryDateController = TextEditingController(
      text: widget.paymentMethod?.expiryDate ?? '',
    );
    _cvvController = TextEditingController();
    _isDefault = widget.paymentMethod?.isDefault ?? false;
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.paymentMethod == null
            ? 'Add Payment Method'
            : 'Edit Payment Method',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1234 5678 9012 3456',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a card number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cardHolderController,
                decoration: const InputDecoration(
                  labelText: 'Card Holder Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter card holder name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateController,
                      decoration: const InputDecoration(
                        labelText: 'Expiry Date',
                        hintText: 'MM/YY',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter expiry date';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                        hintText: '123',
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Set as default payment method'),
                  const Spacer(),
                  Switch(
                    value: _isDefault,
                    onChanged: (value) {
                      setState(() {
                        _isDefault = value;
                      });
                    },
                    activeColor: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _savePaymentMethod,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _savePaymentMethod() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement save payment method logic
      Navigator.pop(context);
    }
  }
}
