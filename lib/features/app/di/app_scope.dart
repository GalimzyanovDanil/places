import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:places/api/service/place_api.dart';
import 'package:places/config/app_config.dart';
import 'package:places/config/environment/environment.dart';
import 'package:places/database/places_database.dart';
import 'package:places/features/common/domain/repository/favorite_db_repository.dart';
import 'package:places/features/common/domain/repository/places_repository.dart';
import 'package:places/features/common/domain/repository/shared_prefs_storage.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/common/service/favorite_db_service.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/common/service/places_service.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/search/repository/search_query_db_repository.dart';
import 'package:places/features/search/service/search_query_db_service.dart';
import 'package:places/util/default_error_handler.dart';
import 'package:places/util/shared_preferences_helper.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final VoidCallback _applicationRebuilder;
  late final Coordinator _coordinator;
  late final PlacesService _placesService;
  late final AppSettingsService _appSettingsService;
  late final SearchQueryDbService _searchDbService;
  late final FavoriteDbService _favoriteDbService;

  late final PlaceApi _placeApi;
  late final PlacesRepository _placesRepository;
  late final SharedPreferencesHelper _sharedPreferencesHelper;
  late final SharedPrefsStorage _sharedPrefStorage;
  late final GeopositionBloc _geopositionBloc;
  late final SearchQueryDbRepository _searchQueryDbRepository;
  late final FavoriteDbRepository _favoriteDbRepository;
  late final PlacesDatabase _database;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  VoidCallback get applicationRebuilder => _applicationRebuilder;

  @override
  Coordinator get coordinator => _coordinator;

  @override
  PlacesService get placesService => _placesService;

  @override
  ConnectivityResult get connectivityResult => _connectivityResult;

  @override
  AppSettingsService get appSettingsService => _appSettingsService;

  @override
  GeopositionBloc get geopositionBloc => _geopositionBloc;

  @override
  SearchQueryDbService get searchDbService => _searchDbService;

  @override
  FavoriteDbService get favoriteDbService => _favoriteDbService;

  late ConnectivityResult _connectivityResult;

  /// Create an instance [AppScope].
  AppScope({
    required VoidCallback applicationRebuilder,
  }) : _applicationRebuilder = applicationRebuilder {
    /// List interceptor. Fill in as needed.
    final additionalInterceptors = <Interceptor>[
      InterceptorsWrapper(
        onError: (e, handler) {
          handler.reject(e);
        },
      ),
    ];

    _dio = _initDio(additionalInterceptors);
    _errorHandler = DefaultErrorHandler();
    _coordinator = Coordinator();
    _initConnectivity();

    // Places API service
    _placeApi = PlaceApi(dio);
    _placesService = _initPlacesService();

    // Shared Preference storage
    _sharedPreferencesHelper = SharedPreferencesHelper();
    _sharedPrefStorage = SharedPrefsStorage(_sharedPreferencesHelper);
    _appSettingsService = AppSettingsService(_sharedPrefStorage);

    // Geoposition BLoC
    _geopositionBloc = GeopositionBloc()
      ..add(const GeopositionEvent.checkAndRequestPermission());

    // Search Query Database service
    _database = PlacesDatabase();

    _searchQueryDbRepository = SearchQueryDbRepository(_database);
    _searchDbService = SearchQueryDbService(_searchQueryDbRepository);

    _favoriteDbRepository = FavoriteDbRepository(_database);
    _favoriteDbService = FavoriteDbService(_favoriteDbRepository);
  }

  // For dispose any controllers
  @override
  void dispose() {
    _appSettingsService.dispose();
  }

  Dio _initDio(Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment<AppConfig>.instance().config.url
      ..connectTimeout = timeout.inMilliseconds
      ..receiveTimeout = timeout.inMilliseconds
      ..sendTimeout = timeout.inMilliseconds;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        // ignore: body_might_complete_normally_nullable
        (client) {
      final proxyUrl = Environment<AppConfig>.instance().config.proxyUrl;
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        client
          ..findProxy = (uri) {
            return 'PROXY $proxyUrl';
          }
          ..badCertificateCallback = (_, __, ___) {
            return true;
          };
      }
    };

    dio.interceptors.addAll(additionalInterceptors);

    if (Environment<AppConfig>.instance().isDebug) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }

  Future<void> _initConnectivity() async {
    final connectivity = Connectivity();
    _connectivityResult = await connectivity.checkConnectivity();

    connectivity.onConnectivityChanged.listen((result) {
      _connectivityResult = result;
    });
  }

  PlacesService _initPlacesService() {
    _placesRepository = PlacesRepository(_placeApi);
    return PlacesService(_placesRepository);
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  /// Class that coordinates navigation for the whole app.
  Coordinator get coordinator;

  /// Places service.
  PlacesService get placesService;

  /// Connect to Internet status.
  ConnectivityResult get connectivityResult;

  /// App settings service.
  AppSettingsService get appSettingsService;

  ///Geolocation service
  GeopositionBloc get geopositionBloc;

  /// Service for work with SearchQueries Database
  SearchQueryDbService get searchDbService;

  /// Service for work with Favorite Database
  FavoriteDbService get favoriteDbService;

  /// For dispose any controllers
  void dispose();
}
