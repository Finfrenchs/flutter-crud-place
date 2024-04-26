import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_place_app/data/model/response/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasource/auth_remote_datasource.dart';
import '../../../data/model/request/login_request_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource datasource;
  LoginBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());

      final response = await datasource.login(event.requestModel);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
