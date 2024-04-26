part of 'delete_place_bloc.dart';

@freezed
class DeletePlaceEvent with _$DeletePlaceEvent {
  const factory DeletePlaceEvent.started() = _Started;
  const factory DeletePlaceEvent.delete(int id) = _Delete;
}
