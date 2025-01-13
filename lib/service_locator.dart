import 'package:get_it/get_it.dart';
import 'package:project/core/network/dio_client.dart';

final sl = GetIt.instance;

void setupServiceLocator() async {
  sl.registerSingleton<DioClient>(DioClient());
}
