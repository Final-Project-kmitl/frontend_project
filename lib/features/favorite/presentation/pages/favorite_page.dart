import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/config/theme/app_color.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:project/features/favorite/presentation/widgets/favorite_button.dart';
import 'package:project/features/favorite/presentation/widgets/favorite_card.dart';

var name = 'OOTD Dark Spot Vitamin C Serum';
var brand = 'OOTD';

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
        title: Text(
          "การกดถูกใจ",
          style: TextThemes.headline1,
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
        if (state is FavoriteLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FavoriteLoaded) {
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
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        print(index);
                        if (index == 9 || index == 9 + 1) {
                          return Container(
                            height: 20,
                            color: AppColors.red,
                          );
                        }
                        return FavoriteCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: Text("data"),
        );
      }),
    );
  }
}
