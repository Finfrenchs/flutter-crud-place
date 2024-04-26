import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasource/auth_remote_datasource.dart';
import '../../../data/model/response/logout_response_model.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRemoteDatasource datasource;
  LogoutBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      emit(const _Loading());

      final response = await datasource.logout();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
