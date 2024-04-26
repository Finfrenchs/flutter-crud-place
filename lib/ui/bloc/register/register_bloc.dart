import 'package:bloc/bloc.dart';
import 'package:flutter_place_app/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_place_app/data/model/request/register_request_model.dart';
import 'package:flutter_place_app/data/model/response/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource datasource;
  RegisterBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());

      final response = await datasource.register(event.requestModel);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
