import 'package:equatable/equatable.dart';

class Staff extends Equatable {
  final int? id;
  final String fullName;
  final String? phone;
  final String? email;
  final String? certification;
  final bool isActive;

  const Staff({
    this.id,
    required this.fullName,
    this.phone,
    this.email,
    this.certification,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [id, fullName, phone, email, certification, isActive];
}