import 'package:equatable/equatable.dart';

import '../models/form_status.dart';
import '../models/user_model.dart';

class UsersState extends Equatable {
  const UsersState({
    required this.status,
    required this.statusText,
    required this.users,
  });

  final FormStatus status;
  final List<UserModel> users;
  final String statusText;

  UsersState copyWith({
    FormStatus? status,
    List<UserModel>? users,
    String? statusText,
  }) =>
      UsersState(
        status: status ?? this.status,
        statusText: statusText ?? this.statusText,
        users: users ?? this.users,
      );

  @override
  List<Object?> get props => [
        status,
        users,
        statusText,
      ];
}
