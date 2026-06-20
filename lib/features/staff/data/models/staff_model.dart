import '../../domain/entities/staff.dart';

class StaffModel extends Staff {
  const StaffModel({
    super.id,
    required super.fullName,
    super.phone,
    super.email,
    super.certification,
    super.isActive,
  });

  factory StaffModel.fromMap(Map<String, dynamic> map) {
    return StaffModel(
      id: map['id'] as int?,
      fullName: map['fullName'] as String,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      certification: map['certification'] as String?,
      isActive: (map['isActive'] as int) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'certification': certification,
      'isActive': isActive ? 1 : 0,
    };
  }
}