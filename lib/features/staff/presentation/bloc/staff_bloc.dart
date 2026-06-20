import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/staff.dart';
import '../../domain/repositories/staff_repository.dart';

abstract class StaffEvent extends Equatable {
  const StaffEvent();
  @override
  List<Object?> get props => [];
}

class LoadStaff extends StaffEvent {}

class AddStaff extends StaffEvent {
  final Staff staff;
  const AddStaff(this.staff);
  @override
  List<Object?> get props => [staff];
}

class DeleteStaff extends StaffEvent {
  final int id;
  const DeleteStaff(this.id);
  @override
  List<Object?> get props => [id];
}

abstract class StaffState extends Equatable {
  const StaffState();
  @override
  List<Object?> get props => [];
}

class StaffInitial extends StaffState {}

class StaffLoading extends StaffState {}

class StaffLoaded extends StaffState {
  final List<Staff> staff;
  const StaffLoaded(this.staff);
  @override
  List<Object?> get props => [staff];
}

class StaffError extends StaffState {
  final String message;
  const StaffError(this.message);
  @override
  List<Object?> get props => [message];
}

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final StaffRepository repository;

  StaffBloc({required this.repository}) : super(StaffInitial()) {
    on<LoadStaff>(_onLoadStaff);
    on<AddStaff>(_onAddStaff);
    on<DeleteStaff>(_onDeleteStaff);
  }

  Future<void> _onLoadStaff(
    LoadStaff event,
    Emitter<StaffState> emit,
  ) async {
    emit(StaffLoading());
    try {
      final staff = await repository.getAllStaff();
      emit(StaffLoaded(staff));
    } catch (e) {
      emit(StaffError(e.toString()));
    }
  }

  Future<void> _onAddStaff(
    AddStaff event,
    Emitter<StaffState> emit,
  ) async {
    try {
      await repository.addStaff(event.staff);
      add(LoadStaff());
    } catch (e) {
      emit(StaffError(e.toString()));
    }
  }

  Future<void> _onDeleteStaff(
    DeleteStaff event,
    Emitter<StaffState> emit,
  ) async {
    try {
      await repository.deleteStaff(event.id);
      add(LoadStaff());
    } catch (e) {
      emit(StaffError(e.toString()));
    }
  }
}