import 'package:bank_loan/core/util/local_storage/sqflite_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import '../../../features/clients_page/data/repo/clients_repo_impl.dart';
import '../screen_size.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<SqfliteHelper>(SqfliteHelper());
  getIt.registerSingleton<ClientsRepoImpl>(ClientsRepoImpl(getIt.get<SqfliteHelper>()));
  getIt.registerSingleton(ScreenSizeUtil());
}
