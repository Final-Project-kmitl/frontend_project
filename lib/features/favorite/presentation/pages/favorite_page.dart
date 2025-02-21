import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/core/config/assets/svg_assets.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:project/features/favorite/presentation/widgets/favorite_button.dart';
import 'package:project/features/favorite/presentation/widgets/favorite_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<FavoriteBloc>()..add(LoadFavoritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        title: const Text(
          "การกดถูกใจ",
          style: TextThemes.headline1,
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.black,
              strokeWidth: 6,
            ),
          );
        } else if (state is FavoriteLoaded) {
          if (state.favorites.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(SvgAssets.favorite_empty),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "ยังไม่มีผลิตภัณฑ์ที่คุณกดถูกใจ",
                    style: TextThemes.bodyBold,
                  ),
                  SizedBox(
                    height: 62 + 82,
                  )
                ],
              ),
            );
          }
          return SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), //ขอบจอ 20
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 168.5 / 262,
                      ),
                      itemCount: state.favorites.length,
                      itemBuilder: (context, index) {
                        final product = state.favorites[index];
                        final isUnfav =
                            state.unfavList?.contains(product.id) ?? false;
                        return FavoriteCard(
                          product: product,
                          isUnFav: isUnfav,
                          onToggleFavorite: () {
                            context.read<FavoriteBloc>().add(
                                ToggleFavoriteEvent(productId: product.id));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: Text("ไม่สามารถโหลดข้อมูล กลับมาใหม่ในภายหลัง"),
        );
      }),
    );
  }
}
