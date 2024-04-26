// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_place_app/data/datasource/places_remote_datasource.dart';

import '../../../data/model/response/get_places_response_model.dart';

part 'get_all_places_bloc.freezed.dart';
part 'get_all_places_event.dart';
part 'get_all_places_state.dart';

class GetAllPlacesBloc extends Bloc<GetAllPlacesEvent, GetAllPlacesState> {
  final PlacesRemoteDatasource datasource;
  GetAllPlacesBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const _Loading());

      final response = await datasource.getPlaces();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
