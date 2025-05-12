import 'package:vibe_in/core/helpers/enum.dart';
import 'package:vibe_in/features/bottom_nav_bar/main_page/data/models/package_model.dart';

class PackagesState {
  final RequestsStatus packagesState;
  final List<PackageModel>? packagesModel;
  final bool isLoadingMore;
  final String? error;
  const PackagesState({
    this.packagesState = RequestsStatus.initial,
    this.packagesModel,
    this.isLoadingMore = false,
    this.error,
  });

  PackagesState copyWith({
    RequestsStatus? packagesState,
    List<PackageModel>? packagesModel,
    bool? isLoadingMore,
    String? error,
  }) {
    return PackagesState(
      packagesState: packagesState ?? this.packagesState,
      packagesModel: packagesModel ?? this.packagesModel,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}
