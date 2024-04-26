// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_place_app/data/model/request/create_place_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_place_app/data/datasource/places_remote_datasource.dart';
import 'package:flutter_place_app/data/model/response/create_response_model.dart';
import 'package:flutter_place_app/data/model/response/get_places_response_model.dart';

part 'create_place_bloc.freezed.dart';
part 'create_place_event.dart';
part 'create_place_state.dart';

class CreatePlaceBloc extends Bloc<CreatePlaceEvent, CreatePlaceState> {
  final PlacesRemoteDatasource datasource;
  CreatePlaceBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Create>((event, emit) async {
      emit(const _Loading());

      final requestData = CreatePlaceRequestModel(
        name: event.places.name!,
        address: event.places.address!,
        coordinates: event.places.coordinates!,
        description: event.places.description ?? '',
        image: event.image,
      );

      final response = await datasource.addPlace(requestData);

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
