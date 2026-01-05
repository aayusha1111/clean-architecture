import 'package:clean_architecture/features/users/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class PostUserEvent extends UserEvent {
  final UserEntity user;

  const PostUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class FetchUserEvent extends UserEvent{
  const FetchUserEvent();
}

class UpdateUserEvent extends UserEvent{
  final UserEntity user;
  const UpdateUserEvent(this.user);
    @override
      List<Object?> get props => [user];




}