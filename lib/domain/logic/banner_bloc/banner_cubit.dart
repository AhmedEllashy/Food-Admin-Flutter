import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin/data/Repository/repository.dart';
import 'package:food_admin/domain/logic/banner_bloc/banner_state.dart';
import 'package:uuid/uuid.dart';

class BannerCubit extends Cubit<BannerState> {
  final Repository _repository;
  BannerCubit(this._repository) : super(GetAllBannerLoadingState());
  String bannerId = const Uuid().v4();
  static BannerCubit get(context) => BlocProvider.of<BannerCubit>(context);

  void addBanner(String bannerImageUrl) {
    emit(AddBannerLoadingStateState());
    _repository.addBanner(bannerId, bannerImageUrl).then((_) {
      emit(AddBannerCompletedState());
      bannerId = const Uuid().v4();
    }, onError: (e) {
      emit(AddBannerFailedState(e.toString()));
    });
  }

  void getAllBanners() {
    GetAllBannerLoadingState();
    _repository.getAllBanners().then(
        (banners) => emit(GetAllBannerCompletedState(banners)),
        onError: (e) => emit(GetAllBannerFailedState(e.toString())));
  }

  void editBanner(String id,String bannerImageUrl) {
    emit(EditBannerLoadingState());
    _repository.editBanner(id, bannerImageUrl).then((_) {
      emit(EditBannerCompletedState());
    }, onError: (e) {
      emit(EditBannerFailedState(e.toString()));
    });
  }
  void removeBanner(String id) {
    emit(RemoveBannerLoadingState());
    _repository.removeBanner(id).then((_) {
      emit(RemoveBannerCompletedState());
      getAllBanners();
    }, onError: (e) {
      emit(RemoveBannerFailedState(e.toString()));
    });
  }
}
