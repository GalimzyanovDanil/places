import 'dart:async';
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
import 'package:places/features/common/service/redux/action_base.dart';
import 'package:places/features/common/service/redux/store.dart';
import 'package:places/features/common/widgets/ui_func.dart';
import 'package:places/features/navigation/app_router.dart';
import 'package:places/features/places_list/domain/repository/image_pick_repository.dart';
import 'package:places/features/places_list/service/image_picker_service.dart';
import 'package:places/features/search/repository/search_query_db_repository.dart';
import 'package:places/features/search/service/redux/search_screen_middleware.dart';
import 'package:places/features/search/service/redux/search_screen_reducer.dart';
import 'package:places/features/search/service/search_query_db_service.dart';
import 'package:places/util/default_error_handler.dart';
import 'package:places/util/shared_preferences_helper.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final VoidCallback _applicationRebuilder;
  late final AppRouter _router;

  late final StoreDispatcher _storeDispatcher;
  late final StreamSubscription<ActionBase> _storeDispatcherSubs;

  late final PlacesService _placesService;
  late final AppSettingsService _appSettingsService;
  late final SearchQueryDbService _searchDbService;
  late final FavoriteDbService _favoriteDbService;
  late final ImagePickerService _imagePickerService;

  late final PlaceApi _placeApi;
  late final PlacesRepository _placesRepository;
  late final SharedPreferencesHelper _sharedPreferencesHelper;
  late final SharedPrefsStorage _sharedPrefStorage;
  late final GeopositionBloc _geopositionBloc;
  late final SearchQueryDbRepository _searchQueryDbRepository;

  late final FavoriteDbRepository _favoriteDbRepository;
  late final PlacesDatabase _database;
  late final ImagePickerRepositry _imagePickerRepositry;

  late final MessageController _messageController;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  VoidCallback get applicationRebuilder => _applicationRebuilder;

  @override
  AppRouter get router => _router;

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

  @override
  ImagePickerService get imagePickerService => _imagePickerService;

  @override
  MessageController get messageController => _messageController;

  @override
  StoreDispatcher get storeDispatcher => _storeDispatcher;

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
    _router = AppRouter.instance();
    _initConnectivity();

    // Places API service
    _placeApi = PlaceApi(dio);
    _placesService = _initPlacesService();

    // Shared Preference storage
    _sharedPreferencesHelper = SharedPreferencesHelper();
    _sharedPrefStorage = SharedPrefsStorage(_sharedPreferencesHelper);
    _appSettingsService = AppSettingsService(_sharedPrefStorage);

    // Geoposition BLoC
    _geopositionBloc = GeopositionBloc();

    // Search Query Database service
    _database = PlacesDatabase();

    _searchQueryDbRepository = SearchQueryDbRepository(_database);
    _searchDbService = SearchQueryDbService(_searchQueryDbRepository);

    _favoriteDbRepository = FavoriteDbRepository(_database);
    _favoriteDbService = FavoriteDbService(_favoriteDbRepository);

    _imagePickerRepositry = ImagePickerRepositry();
    _imagePickerService = ImagePickerService(_imagePickerRepositry);

    _messageController = MessageController();

    _setupReduxStore();
  }

  // For dispose any controllers
  @override
  void dispose() {
    _appSettingsService.dispose();
    _storeDispatcherSubs.cancel();
  }

  void _setupReduxStore() {
    final searchReducer = SearchScreenReducer().obtainReducer();
    final searchMiddleware = SearchScreenMiddleware(
      queryDbRepository: _searchQueryDbRepository,
      placesRepository: _placesRepository,
    ).obtainMiddleware();
    final store = AppStore.createStore(
      reducer: searchReducer,
      middleware: [searchMiddleware],
    );
    _storeDispatcher = StoreDispatcher()..onChange = store.onChange;
    _storeDispatcherSubs = _storeDispatcher.onAction.listen(store.dispatch);
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

  /// Service for pick image gallery or camera
  ImagePickerService get imagePickerService;

  ///UI Function Controller
  MessageController get messageController;

  // Navigation on whole app
  AppRouter get router;

  // Dispatcher for Redux action
  StoreDispatcher get storeDispatcher;

  /// For dispose any controllers
  void dispose();
}
