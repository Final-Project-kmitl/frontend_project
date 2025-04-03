import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/home/domain/entities/product_entity.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';

class ShowTest extends StatefulWidget {
  final int benefitId;
  final String benefit;
  const ShowTest({
    super.key,
    required this.benefitId,
    required this.benefit,
  });

  @override
  State<ShowTest> createState() => _ShowTestState();
}

class _ShowTestState extends State<ShowTest> {
  String selectSort = "ค่าเริ่มต้น";
  List<ProductEntity> originalProducts = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    print("object");
    context
        .read<HomeBloc>()
        .add(LoadByBenefitEvent(benefitId: widget.benefitId));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore) {
        print("📌 Scrolled to bottom, calling _loadMoreData");
        _loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreData() {
    print("LOADING");
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    _currentPage++;

    context.read<HomeBloc>().add(LoadMoreByBenefitEvent(
          benefitId: widget.benefitId,
          page: _currentPage,
        ));

    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
