import 'package:clean_architecture/core/usecase/usecase.dart';
import 'package:clean_architecture/features/users/domain/usecase/post_user_usecase.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_event.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final PostUserUsecase postUserUsecase;
  final FetchUserUsecase fetchUserUsecase;
  final UpdateUserUsecase updateUserUsecase;
  UserBloc(this.postUserUsecase, this.fetchUserUsecase, this.updateUserUsecase) : super(const UserInitialState()) {
    on<PostUserEvent>(_onPostUserEvent);
    on<FetchUserEvent>(_onFetchUserEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
  }
  void _onPostUserEvent(PostUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final result = await postUserUsecase(event.user);
    result.fold(
      (f) {
        emit(UserErrorState(f.message));
      },
      (p) {
        emit(UserCreatedState(p));
      },
    );
  }

  void _onFetchUserEvent(FetchUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final result = await fetchUserUsecase(NoParams());
    result.fold(
      (f) {
        emit(UserErrorState(f.message));
      },
      (p) {
        emit(UserLoadedState(p));
      },
    );
  }

  void _onUpdateUserEvent(UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final result = await updateUserUsecase(event.user);
    result.fold(
      (f) {
        emit(UserErrorState(f.message));
      },
      (p) {
        emit(UserCreatedState(p));
      },
    );
  }}
