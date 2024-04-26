// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_place_app/data/datasource/places_remote_datasource.dart';

part 'delete_place_bloc.freezed.dart';
part 'delete_place_event.dart';
part 'delete_place_state.dart';

class DeletePlaceBloc extends Bloc<DeletePlaceEvent, DeletePlaceState> {
  final PlacesRemoteDatasource datasource;
  DeletePlaceBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Delete>((event, emit) async {
      emit(const _Loading());

      final response = await datasource.deletePlace(event.id);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
