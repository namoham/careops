import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/staff_bloc.dart';
import '../../domain/entities/staff.dart';


class StaffListPage extends StatefulWidget {
  const StaffListPage({super.key});

  @override
  State<StaffListPage> createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage> {
  @override
  void initState() {
    super.initState();
    context.read<StaffBloc>().add(LoadStaff());
  }

  void _showAddStaffDialog(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final certController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Staff'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: certController,
                decoration: const InputDecoration(labelText: 'Certification'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  context.read<StaffBloc>().add(
                    AddStaff(
                      Staff(
                        fullName: nameController.text,
                        phone: phoneController.text,
                        certification: certController.text,
                      ),
                    ),
                  );
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<StaffBloc, StaffState>(
        builder: (context, state) {
          if (state is StaffLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is StaffError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          
          if (state is StaffLoaded) {
            if (state.staff.isEmpty) {
              return const Center(child: Text('No staff members found'));
            }
            
            return ListView.builder(
              itemCount: state.staff.length,
              itemBuilder: (context, index) {
                final staff = state.staff[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Text(
                        staff.fullName[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(staff.fullName),
                    subtitle: Text(
                      '${staff.certification ?? 'No certification'} • ${staff.phone ?? 'No phone'}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<StaffBloc>().add(DeleteStaff(staff.id!));
                      },
                    ),
                  ),
                );
              },
            );
          }
          
          return const Center(child: Text('Loading...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddStaffDialog(context);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}