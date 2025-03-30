import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project/core/constants/exception.dart';
import 'package:project/features/search/domain/entities/auto_complete_entity.dart';
import 'package:project/features/search/domain/entities/count_filter_entity.dart';
import 'package:project/features/search/domain/entities/search_entity.dart';
import 'package:project/features/search/domain/usecases/get_query.dart';
import 'package:project/features/search/domain/usecases/get_submit.dart';
import 'package:project/features/search/domain/usecases/get_submit_by_benefit.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetQuery getQuery;
  Timer? _debounce;
  final GetSubmit getSubmit;
  bool _isSubmitting = false;
  final GetSubmitByBenefit getSubmitByBenefit;

  SearchBloc({
    required this.getQuery,
    required this.getSubmit,
    required this.getSubmitByBenefit,
  }) : super(SearchOnEmpty()) {
    on<OnSearchQueryChanged>(_onSearch);
    on<OnEmptyEvent>(_onEmpty);
    on<OnLoadMoreEvent>(_onLoadMore);
    on<OnSubmitEvent>(_onSubmit);
    on<SearchLoadBybenefitEvent>(_onSearchLoadBybenefitEvent);
  }
  String _lastQuery = ""; // เก็บ query ล่าสุด

  Future<void> _onSearchLoadBybenefitEvent(
      SearchLoadBybenefitEvent event, Emitter<SearchState> emit) async {
    final currentState = state as SubmitLoaded;
    emit(SearchLoading());
    try {
      final res = await getSubmitByBenefit(
        event.query,
        1,
        10,
        event.minPrice,
        event.maxPrice,
        event.skinProblemIds,
        event.benefitIds,
        event.productTypeIds,
        event.skinProblemIds,
        event.brands,
      );
      emit(SubmitLoaded(
          submitReturn: currentState.submitReturn.copyWith(products: res)));
    } catch (e) {
      SearchError("fail to get by benefit");
    }
  }

  Future<void> _onLoadMore(
      OnLoadMoreEvent event, Emitter<SearchState> emit) async {
    if (state is! SubmitLoaded) return;
    final currentState = state as SubmitLoaded;

    try {
      final result = await getSubmit(
        _lastQuery,
        event.page,
        10,
        event.minPrice,
        event.maxPrice,
        event.skinProblemIds,
        event.benefitIds,
        event.productTypeIds,
        event.skinProblemIds,
        event.brands,
      );

      emit(SubmitLoaded(
          submitReturn: currentState.submitReturn.copyWith(products: [
        ...currentState.submitReturn.products,
        ...result.products
      ])));
    } on TimeoutException {
      SearchError(Exception_String.timeout_error);
    } on SocketException {
      SearchError(Exception_String.netwok_error);
    } catch (e) {
      emit(SearchError("Failed to load more data."));
    }
  }

  Future<void> _onSearch(
      OnSearchQueryChanged event, Emitter<SearchState> emit) async {
    if (_isSubmitting) return;
    final query = event.params.trim();

    // ถ้า query ว่าง ให้ clear state และหยุด debounce
    if (query.isEmpty) {
      _debounce?.cancel();
      emit(SearchOnEmpty());
      _lastQuery = query;
      return;
    }

    // ถ้า query เหมือนเดิม ไม่ต้องโหลดซ้ำ
    if (_lastQuery == query) return;
    _lastQuery = query;

    _debounce?.cancel();
    emit(SearchLoading());

    final completer = Completer<void>();

    _debounce = Timer(Duration(milliseconds: 300), () async {
      if (_isSubmitting) return;
      try {
        final result = await getQuery(query);
        if (_lastQuery == query && !emit.isDone) {
          emit(SearchLoaded(result));
        }
      } on TimeoutException {
        if (_lastQuery == query && !emit.isDone) {
          emit(SearchError(Exception_String.timeout_error));
        }
      } on SocketException {
        if (_lastQuery == query && !emit.isDone) {
          emit(SearchError(Exception_String.netwok_error));
        }
      } catch (e) {
        if (_lastQuery == query && !emit.isDone) {
          emit(SearchError("Something went wrong. Please try again."));
        }
      } finally {
        completer.complete();
      }
    });

    await completer.future; // รอให้ Timer ทำงานเสร็จก่อนออกจากฟังก์ชัน
  }

  Future<void> _onSubmit(OnSubmitEvent event, Emitter<SearchState> emit) async {
    _isSubmitting = true;
    _debounce?.cancel(); // ยกเลิก debounce เมื่อกด Enter
    final query = event.query;

    emit(SearchLoading());

    try {
      final result = await getSubmit(
        query,
        1,
        10,
        event.minPrice,
        event.maxPrice,
        event.skinProblemIds,
        event.benefitIds,
        event.productTypeIds,
        event.skinProblemIds,
        event.brands,
      );

      emit(SubmitLoaded(
        submitReturn: result,
      ));
    } on TimeoutException {
      SearchError(Exception_String.timeout_error);
    } on SocketException {
      if (_lastQuery == query && !emit.isDone) {
        emit(SearchError(Exception_String.netwok_error));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    } finally {
      _isSubmitting = false;
    }
  }

// เพิ่มฟังก์ชันใหม่เพื่อจัดการการกด Enter
  Future<void> _onSearchSubmit(
      OnSearchQueryChanged event, Emitter<SearchState> emit) async {
    _debounce?.cancel(); // ยกเลิก debounce
    await _onSubmit(
        OnSubmitEvent(
          query: event.params.trim(),
          minPrice: 0,
          maxPrice: 1000000,
          skinProblemIds: [],
          benefitIds: [],
          productTypeIds: [],
          brands: [],
        ),
        emit);
  }

  void _onEmpty(OnEmptyEvent event, Emitter<SearchState> emit) {
    _debounce?.cancel();
    emit(SearchOnEmpty()); // ✅ บังคับให้เป็น SearchOnEmpty
    _lastQuery = ""; // รีเซ็ตค่า query
  }
}
