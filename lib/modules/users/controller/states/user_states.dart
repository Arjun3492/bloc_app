import 'package:bloc_app/modules/users/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {
  final String message;

  UserLoading({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserLoaded extends UserState {
  final List<UserModel> users;

  UserLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserNetworkError extends UserState {
  final String message;

  UserNetworkError({required this.message});

  @override
  List<Object?> get props => [message];
}
