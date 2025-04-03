// import 'package:flutter/material.dart';
// import 'package:project/core/config/theme/app_color.dart';

// class FavoriteButton extends StatelessWidget {
//   final int index;
//   const FavoriteButton({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     final favoriteProvider = Provider.of<FavoriteProvider>(context);

//     return IconButton(
//       icon: Icon(
//         favoriteProvider.isFavorite(index)
//             ? Icons.favorite
//             : Icons.favorite_border,
//         color: favoriteProvider.isFavorite(index)
//             ? Colors.red
//             : AppColors.black, //ลองหัวใจสีแดงละสวยกว่า
//       ),
//       onPressed: () {
//         favoriteProvider.toggleFavorite(index);
//       },
//     );
//   }
// }`
