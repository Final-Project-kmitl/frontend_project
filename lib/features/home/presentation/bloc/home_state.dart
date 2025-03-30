part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeBenefitLaoding extends HomeState {}

class HomeBenefitLoaded extends HomeState {
  final List<ProductEntity> products;
  final List<ProductEntity> allProducts; // เก็บข้อมูลทั้งหมด
  final FilterEntity filter;
  final List<int> favorite;
  final bool isLoadingMore; // สถานะการโหลดเพิ่ม

  HomeBenefitLoaded({
    required this.products,
    required this.allProducts,
    required this.filter,
    required this.favorite,
    this.isLoadingMore = false,
  });

  HomeBenefitLoaded copyWith({
    List<ProductEntity>? products,
    List<ProductEntity>? allProducts,
    FilterEntity? filter,
    List<int>? favorite,
    bool? isLoadingMore,
  }) {
    return HomeBenefitLoaded(
      products: products ?? this.products,
      allProducts: allProducts ?? this.allProducts,
      filter: filter ?? this.filter,
      favorite: favorite ?? this.favorite,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props =>
      [products, allProducts, filter, favorite, isLoadingMore];
}

class HomeRecommendedLoaded extends HomeState {
  final List<ProductEntity> recommended;
  HomeRecommendedLoaded({required this.recommended});
}

class HomePopularLoaded extends HomeState {
  final List<ProductEntity> popular;
  HomePopularLoaded({required this.popular});
}

class HomeRecentLoaded extends HomeState {
  final List<ProductEntity> recent;
  HomeRecentLoaded({required this.recent});
}

class HomeFavoriteLoaded extends HomeState {
  final List<int> favorite;
  HomeFavoriteLoaded({required this.favorite});
}

class HomeLoaded extends HomeState {
  final List<ProductEntity> recommended;
  final List<ProductEntity> popular;
  final List<ProductEntity> recent;
  final List<int> favorite;

  // ✅ เพิ่ม flags เพื่อตรวจสอบว่าโหลดเสร็จหรือยัง
  final bool isRecommendedLoaded;
  final bool isPopularLoaded;
  final bool isRecentLoaded;
  final bool isFavoriteLoaded;

  HomeLoaded({
    required this.recommended,
    required this.popular,
    required this.recent,
    required this.favorite,
    required this.isRecommendedLoaded,
    required this.isPopularLoaded,
    required this.isRecentLoaded,
    required this.isFavoriteLoaded,
  });

  // ✅ สร้าง state เริ่มต้น (empty state)
  factory HomeLoaded.empty() {
    return HomeLoaded(
      recommended: [],
      popular: [],
      recent: [],
      favorite: [],
      isRecommendedLoaded: false,
      isPopularLoaded: false,
      isRecentLoaded: false,
      isFavoriteLoaded: false,
    );
  }

  // ✅ copyWith() เพื่ออัปเดต state เฉพาะบางส่วน
  HomeLoaded copyWith({
    List<ProductEntity>? recommended,
    List<ProductEntity>? popular,
    List<ProductEntity>? recent,
    List<int>? favorite,
    bool? isRecommendedLoaded,
    bool? isPopularLoaded,
    bool? isRecentLoaded,
    bool? isFavoriteLoaded,
  }) {
    return HomeLoaded(
      recommended: recommended ?? this.recommended,
      popular: popular ?? this.popular,
      recent: recent ?? this.recent,
      favorite: favorite ?? this.favorite,
      isRecommendedLoaded: isRecommendedLoaded ?? this.isRecommendedLoaded,
      isPopularLoaded: isPopularLoaded ?? this.isPopularLoaded,
      isRecentLoaded: isRecentLoaded ?? this.isRecentLoaded,
      isFavoriteLoaded: isFavoriteLoaded ?? this.isFavoriteLoaded,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
