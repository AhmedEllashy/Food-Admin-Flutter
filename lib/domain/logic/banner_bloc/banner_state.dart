import '../../models/banner.dart';

abstract class BannerState{}
class BannerInitialState extends BannerState{}

class AddBannerCompletedState extends BannerState {}

class AddBannerLoadingStateState extends BannerState {}

class AddBannerFailedState extends BannerState {
  String message;
  AddBannerFailedState(this.message);
}

class GetAllBannerCompletedState extends BannerState {
  final List<BannerDataModel> banners;
  GetAllBannerCompletedState(this.banners);
}

class GetAllBannerLoadingState extends BannerState {}

class GetAllBannerFailedState extends BannerState {
  String message;
  GetAllBannerFailedState(this.message);
}

class EditBannerCompletedState extends BannerState {}

class EditBannerLoadingState extends BannerState {}

class EditBannerFailedState extends BannerState {
  String message;
  EditBannerFailedState(this.message);
}
class RemoveBannerCompletedState extends BannerState {}

class RemoveBannerLoadingState extends BannerState {}

class RemoveBannerFailedState extends BannerState {
  String message;
  RemoveBannerFailedState(this.message);
}