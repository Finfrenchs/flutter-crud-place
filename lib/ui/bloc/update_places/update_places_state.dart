part of 'update_places_bloc.dart';

@freezed
class UpdatePlacesState with _$UpdatePlacesState {
  const factory UpdatePlacesState.initial() = _Initial;
  const factory UpdatePlacesState.loading() = _Loading;
  const factory UpdatePlacesState.loaded(
      UpdatePlacesResponseModel responseModel) = _Loaded;
  const factory UpdatePlacesState.error(String message) = _Error;
}
