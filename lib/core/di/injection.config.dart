// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:groupedbydate/data/repo/todo_repo_impl.dart' as _i889;
import 'package:groupedbydate/domain/data/datasource.dart' as _i1003;
import 'package:groupedbydate/domain/repo/todo_repo.dart' as _i742;
import 'package:groupedbydate/presentaion/blocs/todo_bloc.dart' as _i186;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1003.Datasource>(() => _i1003.Datasource());
    gh.lazySingleton<_i742.TodoRepo>(
      () => _i889.TodoRepoImpl(gh<_i1003.Datasource>()),
    );
    gh.factory<_i186.TodoBloc>(() => _i186.TodoBloc(gh<_i742.TodoRepo>()));
    return this;
  }
}
