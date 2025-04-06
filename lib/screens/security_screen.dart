import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection(
            'Account Security',
            [
              _buildListTile(
                'Change Password',
                'Update your account password',
                Icons.lock_outline,
                () {
                  // TODO: Implement change password functionality
                },
              ),
              _buildListTile(
                'Two-Factor Authentication',
                'Add an extra layer of security',
                Icons.security,
                () {
                  // TODO: Implement 2FA functionality
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Login Security',
            [
              _buildListTile(
                'Login History',
                'View your recent login activity',
                Icons.history,
                () {
                  // TODO: Implement login history functionality
                },
              ),
              _buildListTile(
                'Connected Devices',
                'Manage devices logged into your account',
                Icons.devices,
                () {
                  // TODO: Implement connected devices functionality
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Privacy',
            [
              _buildListTile(
                'Privacy Settings',
                'Control your privacy preferences',
                Icons.privacy_tip_outlined,
                () {
                  // TODO: Implement privacy settings functionality
                },
              ),
              _buildListTile(
                'Data & Permissions',
                'Manage app permissions and data',
                Icons.settings,
                () {
                  // TODO: Implement data & permissions functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
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
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildListTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
