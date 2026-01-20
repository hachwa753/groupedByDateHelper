import 'package:get_it/get_it.dart';
import 'package:groupedbydate/core/di/injection.config.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init();
}
