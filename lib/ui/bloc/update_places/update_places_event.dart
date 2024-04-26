part of 'update_places_bloc.dart';

@freezed
class UpdatePlacesEvent with _$UpdatePlacesEvent {
  const factory UpdatePlacesEvent.started() = _Started;
  const factory UpdatePlacesEvent.update(
      UpdatePlacesRequestModel requestModel, int id) = _Update;
}
