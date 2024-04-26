part of 'get_all_places_bloc.dart';

@freezed
class GetAllPlacesEvent with _$GetAllPlacesEvent {
  const factory GetAllPlacesEvent.started() = _Started;
  const factory GetAllPlacesEvent.fetch() = _Fetch;
}
