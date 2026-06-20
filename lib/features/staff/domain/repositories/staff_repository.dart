import '../entities/staff.dart';

abstract class StaffRepository {
  Future<List<Staff>> getAllStaff();
  Future<Staff?> getStaffById(int id);
  Future<int> addStaff(Staff staff);
  Future<int> updateStaff(Staff staff);
  Future<int> deleteStaff(int id);
}