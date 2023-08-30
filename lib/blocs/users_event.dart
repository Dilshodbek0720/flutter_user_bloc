import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

abstract class UsersEvent extends Equatable {}

class AddUser extends UsersEvent {
  final UserModel newUser;

  AddUser({required this.newUser});

  @override
  List<Object?> get props => [newUser];
}

class GetUsers extends UsersEvent {
  @override
  List<Object?> get props => [];
}

class UpdateUser extends UsersEvent {
  final UserModel updatedUser;

  UpdateUser({required this.updatedUser});

  @override
  List<Object?> get props => [updatedUser];
}

class DeleteUser extends UsersEvent {
  final int id;

  DeleteUser({required this.id});

  @override
  List<Object?> get props => [id];
}