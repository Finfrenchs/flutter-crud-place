part of 'get_all_places_bloc.dart';

@freezed
class GetAllPlacesState with _$GetAllPlacesState {
  const factory GetAllPlacesState.initial() = _Initial;
  const factory GetAllPlacesState.loading() = _Loading;
  const factory GetAllPlacesState.loaded(List<Places> places) = _Loaded;
  const factory GetAllPlacesState.error(String message) = _Error;
}
