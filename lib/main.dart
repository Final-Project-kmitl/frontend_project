import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/config/theme/app_theme.dart';
import 'package:project/features/home/presentation/pages/home_page.dart';
import 'package:project/features/routine/data/datasource/routine_datasource.dart';
import 'package:project/features/routine/data/repository/routine_repository_impl.dart';
import 'package:project/features/routine/domain/usecases/get_no_match_routine.dart';
import 'package:project/features/routine/domain/usecases/get_product_routine.dart';
import 'package:project/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:project/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //ให้มองเห็นนาฬิกาเพราะ appbar มันสีขาว
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  setupServiceLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RoutineBloc>(
        create: (context) => RoutineBloc(
          getNoMatchRoutine: GetNoMatchRoutine(
              routineRepository: RoutineRepositoryImpl(
                  routineRemoteDatasource: apiServiceRoutine())),
          getProductRoutine: GetProductRoutine(
              routineRepository: RoutineRepositoryImpl(
                  routineRemoteDatasource: apiServiceRoutine())),
        ),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skin',
      theme: AppTheme.appTheme,
      home: const HomePage(),
    );
  }
}
