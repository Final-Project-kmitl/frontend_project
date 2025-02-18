import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:project/core/error/server_failure.dart';
import 'package:project/features/splash/domain/usecases/check_user.dart';
import 'package:project/service_locator.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckUser checkUser;
  SplashBloc({required this.checkUser}) : super(SplashInitial()) {
    on<CheckUserEvent>(_onCheckUser);
  }

  Future<void> _onCheckUser(
      CheckUserEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    await Future.delayed(Duration(seconds: 2));

    final Either<Failure, bool> result = await sl<CheckUser>().call();

    return result.fold(
      (failure) => emit(SplashFailure(failure.message)),
      (userExit) => emit(
        SplashSuccess(),
      ),
    );
  }
}
