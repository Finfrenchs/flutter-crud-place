part of 'create_place_bloc.dart';

@freezed
class CreatePlaceEvent with _$CreatePlaceEvent {
  const factory CreatePlaceEvent.started() = _Started;
  const factory CreatePlaceEvent.create(Places places, XFile image) = _Create;
}
