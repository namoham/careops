import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareOps Dashboard'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Supervisor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildStatCard('Staff', '12', Icons.people, Colors.blue),
                const SizedBox(width: 16),
                _buildStatCard('Clients', '8', Icons.person, Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatCard('Incidents', '3', Icons.warning, Colors.orange),
                const SizedBox(width: 16),
                _buildStatCard('Shifts', '5', Icons.schedule, Colors.purple),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  _buildActivityItem('Incident reported', 'Room 102 - Fall', '2 min ago'),
                  _buildActivityItem('Shift started', 'John Doe - Night', '1 hour ago'),
                  _buildActivityItem('Client note added', 'Sarah Smith', '3 hours ago'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String time) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.teal,
        child: Icon(Icons.notifications, color: Colors.white),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(
        time,
        style: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}