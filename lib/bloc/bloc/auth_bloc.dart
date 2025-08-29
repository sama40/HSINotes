import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_notes/enum/status_enum.dart';
import 'package:light_notes/model/user_model.dart';
import 'package:light_notes/service/user/user_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.service) : super(AuthState.initial()) {
    on<RegisterAuthEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusEnum.loading));

        final user = await service.register(
          name: event.name,
          email: event.email,
          password: event.password,
        );

        emit(state.copyWith(status: StatusEnum.success, user: user));
      } on Exception catch (e) {
        emit(state.copyWith(status: StatusEnum.failure, error: e));
      }
    });

    on<CheckAuthEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusEnum.loading));

        final user = await service.user();

        emit(state.copyWith(status: StatusEnum.success, user: user));
      } on Exception catch (e) {
        emit(state.copyWith(status: StatusEnum.failure, error: e));
      }
    });

    on<LoginAuthEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusEnum.loading));

        final user = await service.login(
          email: event.email,
          password: event.password,
        );

        emit(state.copyWith(status: StatusEnum.success, user: user));
      } on Exception catch (e) {
        emit(state.copyWith(status: StatusEnum.failure, error: e));
      }
    });

    on<LogoutAuthEvent>((event, emit) async {
      await service.logout();

      emit(AuthState.initial());
    });
  }

  final UserService service;
}
