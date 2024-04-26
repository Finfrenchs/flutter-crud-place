// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_place_app/data/datasource/places_remote_datasource.dart';
import 'package:flutter_place_app/data/model/request/update_places_request_model.dart';
import 'package:flutter_place_app/data/model/response/get_places_response_model.dart';
import 'package:flutter_place_app/data/model/response/update_places_response_model.dart';

part 'update_places_bloc.freezed.dart';
part 'update_places_event.dart';
part 'update_places_state.dart';

class UpdatePlacesBloc extends Bloc<UpdatePlacesEvent, UpdatePlacesState> {
  final PlacesRemoteDatasource datasource;
  UpdatePlacesBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Update>((event, emit) async {
      emit(const _Loading());

      final response = await datasource.updatePlaces(
        event.requestModel,
        event.id,
      );

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
