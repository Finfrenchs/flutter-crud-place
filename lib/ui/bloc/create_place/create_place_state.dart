part of 'create_place_bloc.dart';

@freezed
class CreatePlaceState with _$CreatePlaceState {
  const factory CreatePlaceState.initial() = _Initial;
  const factory CreatePlaceState.loading() = _Loading;
  const factory CreatePlaceState.loaded(
      CreatePlacesResponseModel responseModel) = _Loaded;
  const factory CreatePlaceState.error(String message) = _Error;
}
