import 'package:flutter/material.dart';
import 'package:security/utils/custom_colors.dart';

class SecurityDetailView extends StatelessWidget {

  const SecurityDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                'Hi, securityName 👋',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Gate Controls Card
              _buildGateControlsCard(),

              const SizedBox(height: 20),

              // Quick Actions Card
              _buildQuickActionsCard(),

              const SizedBox(height: 20),

              // Emergency Contacts Card
              _buildEmergencyContactsCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGateControlsCard() {
    return Card(
      color: CustomColors.accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title: Gate Controls
            const Text(
              'Gate Controls',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Main Gate Button
            _buildGateButton('Main Gate'),
            const SizedBox(height: 16),

            // Pedestrian Gate Button
            _buildGateButton('Pedestrian Gate'),
            const SizedBox(height: 16),

            // Auto-close notice
            const Text(
              '🔒 Gates will auto-close after 30 seconds.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGateButton(String gateName) {
    return Card(
      color: CustomColors.accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              gateName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add logic for opening the gate
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.iconColor,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'Open',
                style: TextStyle(color: CustomColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Quick Actions Card
  Widget _buildQuickActionsCard() {
    final actions = ['Security Alert', 'Community Announcement', 'Message', 'Call'];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Bento box design for actions
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3,
              ),
              itemCount: actions.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    // Add action logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Text(actions[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Emergency Contacts Card
  Widget _buildEmergencyContactsCard() {
    final contacts = {
      'Society Manager': Icons.person,
      'Emergency Contact': Icons.phone,
    };

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Emergency Contacts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: contacts.entries.map((entry) {
                return ListTile(
                  leading: Icon(entry.value, color: Colors.red),
                  title: Text(entry.key),
                  trailing: const Icon(Icons.phone, color: Colors.green),
                  onTap: () {
                    // Add logic to call the contact
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
