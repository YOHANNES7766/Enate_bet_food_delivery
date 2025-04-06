import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Settings',
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
          _buildSection(
            title: 'Account',
            children: [
              _buildSettingTile(
                icon: Icons.person_outline,
                title: 'Account Information',
                onTap: () {
                  // TODO: Navigate to account information screen
                },
              ),
              _buildSettingTile(
                icon: Icons.security,
                title: 'Security',
                onTap: () {
                  // TODO: Navigate to security settings screen
                },
              ),
              _buildSettingTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  // TODO: Navigate to privacy policy screen
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Preferences',
            children: [
              _buildSwitchTile(
                icon: Icons.notifications_outlined,
                title: 'Push Notifications',
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              _buildSwitchTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
              ),
              _buildDropdownTile(
                icon: Icons.language,
                title: 'Language',
                value: _selectedLanguage,
                items: const ['English', 'Spanish', 'French', 'German'],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                },
              ),
              _buildDropdownTile(
                icon: Icons.attach_money,
                title: 'Currency',
                value: _selectedCurrency,
                items: const ['USD', 'EUR', 'GBP', 'JPY'],
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Support',
            children: [
              _buildSettingTile(
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () {
                  // TODO: Navigate to help center screen
                },
              ),
              _buildSettingTile(
                icon: Icons.feedback_outlined,
                title: 'Send Feedback',
                onTap: () {
                  // TODO: Navigate to feedback screen
                },
              ),
              _buildSettingTile(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {
                  // TODO: Navigate to about screen
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Legal',
            children: [
              _buildSettingTile(
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                onTap: () {
                  // TODO: Navigate to terms of service screen
                },
              ),
              _buildSettingTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  // TODO: Navigate to privacy policy screen
                },
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement logout functionality
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.orange,
      ),
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        underline: const SizedBox(),
      ),
    );
  }
}
