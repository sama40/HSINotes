import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_notes/model/user_model.dart';
import 'package:light_notes/service/user/local_service.dart';
import 'package:light_notes/enum/status_enum.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<RegisterAuthEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusEnum.loading));

        final user = await UserLocalService.register(
          name: event.name,
          email: event.email,
          password: event.password,
        );

        emit(state.copyWith(status: StatusEnum.success, user: user));
      } on Exception catch (e) {
        emit(state.copyWith(status: StatusEnum.failure, error: e));
      }
    });
  }
}
