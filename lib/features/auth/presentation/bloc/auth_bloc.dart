import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:async/async.dart';
import 'package:project/core/constants/share_pref.dart';
import 'package:project/features/auth/domain/entities/ingredient_entity.dart';
import 'package:project/features/auth/domain/usecases/get_auth_ingredient.dart';
import 'package:project/features/auth/domain/usecases/register.dart';
import 'package:project/features/home/presentation/bloc/home_bloc.dart';
import 'package:project/service_locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //import usecase
  final GetAuthIngredient getAuthIngredient;
  final Register register;
  CancelableOperation? _currentOperation;

  AuthBloc({
    required this.getAuthIngredient,
    required this.register,
  }) : super(AuthInitial()) {
    //จัดการเรื่อง req ของ usecase
    on<AuthQueryChanged>(
      _onQueryChange,
      transformer: (events, mapper) => events
          .debounceTime(Duration(milliseconds: 300))
          .distinct()
          .asyncExpand(mapper),
    );
    on<ResetAuthState>(_onreset);
    on<SendingDataToBackend>(_onUserSending);
  }

  //ทำการ register พร้อมส่งข้อมูลไปยัง backend
  Future<void> _onUserSending(
      SendingDataToBackend event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      await Future.delayed(Duration(seconds: 3));

      await register.call(event.userId, event.skinType, event.allergicListId,
          event.benefitListId);

      sl<SharedPreferences>()
          .setString(shared_pref.userId, event.userId.toString());

      // final homeBloc = sl<HomeBloc>();
      // homeBloc.add(HomeDataRequestedEvent());
      // await homeBloc.stream.firstWhere((state) => state is HomeLoaded);

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void _onreset(ResetAuthState event, Emitter<AuthState> emit) {
    if (state is AuthLoaded) {
      emit(AuthInitial());
    }
  }

  //query inredient
  Future<void> _onQueryChange(
      AuthQueryChanged event, Emitter<AuthState> emit) async {
    if (event.query.isEmpty) {
      emit(AuthInitial());
      return;
    }

    emit(AuthLoading());

    _currentOperation?.cancel();

    _currentOperation = CancelableOperation.fromFuture(
      getAuthIngredient.call(event.query),
      onCancel: () {
        print("🔴 API Request ถูกยกเลิก: ${event.query}");
      },
    );

    try {
      await Future.delayed(Duration(seconds: 2));
      final result = await _currentOperation!.value;
      print("✅ Data received: ${result.length} items");
      print("🔄 Emitting AuthLoaded: ${result.map((e) => e.name).toList()}");

      //จัดการเปลี่ยน state
      emit(AuthLoaded(ingredients: List.from(result)));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _currentOperation?.cancel();
    return super.close();
  }
}
