part of 'delete_place_bloc.dart';

@freezed
class DeletePlaceState with _$DeletePlaceState {
  const factory DeletePlaceState.initial() = _Initial;
  const factory DeletePlaceState.loading() = _Loading;
  const factory DeletePlaceState.loaded(String loaded) = _Loaded;
  const factory DeletePlaceState.error(String message) = _Error;
}
