import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/Data_source/remote_data_source.dart';
import '../data/Network/app_api.dart';
import '../data/Network/auth_api.dart';
import '../data/Network/network_info.dart';
import '../data/Repository/repository.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule()async{

  //shared_preferences
  final _sharedPreferences =await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>( ()=>_sharedPreferences);

  //AppPreferences
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  //Network Info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementer(InternetConnectionChecker()));
  //AppService Client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient());

  //Remote Data Source
  instance.registerLazySingleton<RemoteDataSource>(() =>RemoteDataSourceImplementer(instance(),instance()));
  //Repository
  instance.registerLazySingleton<Repository>(() => RepositoryImplementer(instance(), instance()));

  instance.registerLazySingleton<AuthApi>(() => AuthApi());


}