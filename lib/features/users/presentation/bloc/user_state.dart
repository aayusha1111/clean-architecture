import 'package:clean_architecture/features/users/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {
  const UserInitialState();
}

class UserLoadingState extends UserState {
  const UserLoadingState();
}

class UserLoadedState extends UserState {
  final List<UserEntity> users;
  const UserLoadedState(this.users);
  @override
  List<Object?> get props => [users];
}
class UserCreatedState extends UserState{
  final String message;

  const UserCreatedState(this.message);
}

class UserErrorState extends UserState {
  final String message;
  const UserErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
