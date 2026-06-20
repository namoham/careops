import '../../domain/entities/staff.dart';
import '../../domain/repositories/staff_repository.dart';

class StaffRepositoryImpl implements StaffRepository {
  final List<Staff> _mockStaff = [
    const Staff(id: 1, fullName: 'John Doe', phone: '555-0101', email: 'john@careops.com', certification: 'CNA'),
    const Staff(id: 2, fullName: 'Sarah Smith', phone: '555-0102', email: 'sarah@careops.com', certification: 'RN'),
    const Staff(id: 3, fullName: 'Mike Johnson', phone: '555-0103', email: 'mike@careops.com', certification: 'LPN'),
  ];

  @override
  Future<List<Staff>> getAllStaff() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    return _mockStaff;
  }

  @override
  Future<Staff?> getStaffById(int id) async {
    try {
      return _mockStaff.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int> addStaff(Staff staff) async {
    _mockStaff.add(staff);
    return 1;
  }

  @override
  Future<int> updateStaff(Staff staff) async {
    final index = _mockStaff.indexWhere((s) => s.id == staff.id);
    if (index != -1) {
      _mockStaff[index] = staff;
    }
    return 1;
  }

  @override
  Future<int> deleteStaff(int id) async {
    _mockStaff.removeWhere((s) => s.id == id);
    return 1;
  }
}