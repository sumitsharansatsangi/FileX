// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isarInstanceHash() => r'a7c8a5b9a37fefef9bf6da8fddebba65d85aa2ab';

/// See also [isarInstance].
@ProviderFor(isarInstance)
final isarInstanceProvider = FutureProvider<Isar>.internal(
  isarInstance,
  name: r'isarInstanceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isarInstanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsarInstanceRef = FutureProviderRef<Isar>;
String _$searchFilesHash() => r'8856381dd0a302bedcab675db1233f66728aae4a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [searchFiles].
@ProviderFor(searchFiles)
const searchFilesProvider = SearchFilesFamily();

/// See also [searchFiles].
class SearchFilesFamily extends Family<AsyncValue<List<FileSystemEntity>>> {
  /// See also [searchFiles].
  const SearchFilesFamily();

  /// See also [searchFiles].
  SearchFilesProvider call(
    String query,
  ) {
    return SearchFilesProvider(
      query,
    );
  }

  @override
  SearchFilesProvider getProviderOverride(
    covariant SearchFilesProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchFilesProvider';
}

/// See also [searchFiles].
class SearchFilesProvider
    extends AutoDisposeFutureProvider<List<FileSystemEntity>> {
  /// See also [searchFiles].
  SearchFilesProvider(
    String query,
  ) : this._internal(
          (ref) => searchFiles(
            ref as SearchFilesRef,
            query,
          ),
          from: searchFilesProvider,
          name: r'searchFilesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchFilesHash,
          dependencies: SearchFilesFamily._dependencies,
          allTransitiveDependencies:
              SearchFilesFamily._allTransitiveDependencies,
          query: query,
        );

  SearchFilesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<FileSystemEntity>> Function(SearchFilesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchFilesProvider._internal(
        (ref) => create(ref as SearchFilesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<FileSystemEntity>> createElement() {
    return _SearchFilesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchFilesProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchFilesRef on AutoDisposeFutureProviderRef<List<FileSystemEntity>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchFilesProviderElement
    extends AutoDisposeFutureProviderElement<List<FileSystemEntity>>
    with SearchFilesRef {
  _SearchFilesProviderElement(super.provider);

  @override
  String get query => (origin as SearchFilesProvider).query;
}

String _$getThumbnailHash() => r'3e6c6075b0fe4288a9670bad98135fcd7935149d';

/// See also [getThumbnail].
@ProviderFor(getThumbnail)
const getThumbnailProvider = GetThumbnailFamily();

/// See also [getThumbnail].
class GetThumbnailFamily extends Family<AsyncValue<Uint8List?>> {
  /// See also [getThumbnail].
  const GetThumbnailFamily();

  /// See also [getThumbnail].
  GetThumbnailProvider call(
    String file,
  ) {
    return GetThumbnailProvider(
      file,
    );
  }

  @override
  GetThumbnailProvider getProviderOverride(
    covariant GetThumbnailProvider provider,
  ) {
    return call(
      provider.file,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getThumbnailProvider';
}

/// See also [getThumbnail].
class GetThumbnailProvider extends AutoDisposeFutureProvider<Uint8List?> {
  /// See also [getThumbnail].
  GetThumbnailProvider(
    String file,
  ) : this._internal(
          (ref) => getThumbnail(
            ref as GetThumbnailRef,
            file,
          ),
          from: getThumbnailProvider,
          name: r'getThumbnailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getThumbnailHash,
          dependencies: GetThumbnailFamily._dependencies,
          allTransitiveDependencies:
              GetThumbnailFamily._allTransitiveDependencies,
          file: file,
        );

  GetThumbnailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.file,
  }) : super.internal();

  final String file;

  @override
  Override overrideWith(
    FutureOr<Uint8List?> Function(GetThumbnailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetThumbnailProvider._internal(
        (ref) => create(ref as GetThumbnailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        file: file,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Uint8List?> createElement() {
    return _GetThumbnailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetThumbnailProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetThumbnailRef on AutoDisposeFutureProviderRef<Uint8List?> {
  /// The parameter `file` of this provider.
  String get file;
}

class _GetThumbnailProviderElement
    extends AutoDisposeFutureProviderElement<Uint8List?> with GetThumbnailRef {
  _GetThumbnailProviderElement(super.provider);

  @override
  String get file => (origin as GetThumbnailProvider).file;
}

String _$getAudioHash() => r'cf3f947c5e785e0704a79efccd71a4cddcdf5125';

/// See also [getAudio].
@ProviderFor(getAudio)
const getAudioProvider = GetAudioFamily();

/// See also [getAudio].
class GetAudioFamily extends Family<void> {
  /// See also [getAudio].
  const GetAudioFamily();

  /// See also [getAudio].
  GetAudioProvider call(
    String type,
  ) {
    return GetAudioProvider(
      type,
    );
  }

  @override
  GetAudioProvider getProviderOverride(
    covariant GetAudioProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getAudioProvider';
}

/// See also [getAudio].
class GetAudioProvider extends AutoDisposeProvider<void> {
  /// See also [getAudio].
  GetAudioProvider(
    String type,
  ) : this._internal(
          (ref) => getAudio(
            ref as GetAudioRef,
            type,
          ),
          from: getAudioProvider,
          name: r'getAudioProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAudioHash,
          dependencies: GetAudioFamily._dependencies,
          allTransitiveDependencies: GetAudioFamily._allTransitiveDependencies,
          type: type,
        );

  GetAudioProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final String type;

  @override
  Override overrideWith(
    void Function(GetAudioRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAudioProvider._internal(
        (ref) => create(ref as GetAudioRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<void> createElement() {
    return _GetAudioProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAudioProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAudioRef on AutoDisposeProviderRef<void> {
  /// The parameter `type` of this provider.
  String get type;
}

class _GetAudioProviderElement extends AutoDisposeProviderElement<void>
    with GetAudioRef {
  _GetAudioProviderElement(super.provider);

  @override
  String get type => (origin as GetAudioProvider).type;
}

String _$downloadHash() => r'c134a6c0d4415b0993148d90a62230f027246e1f';

/// See also [download].
@ProviderFor(download)
final downloadProvider = AutoDisposeFutureProvider<List<String>>.internal(
  download,
  name: r'downloadProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$downloadHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DownloadRef = AutoDisposeFutureProviderRef<List<String>>;
String _$imageHash() => r'13ca6f418dad83827fb2c26cef4b4341a56dd281';

/// See also [image].
@ProviderFor(image)
const imageProvider = ImageFamily();

/// See also [image].
class ImageFamily extends Family<List<String>> {
  /// See also [image].
  const ImageFamily();

  /// See also [image].
  ImageProvider call(
    String type,
  ) {
    return ImageProvider(
      type,
    );
  }

  @override
  ImageProvider getProviderOverride(
    covariant ImageProvider provider,
  ) {
    return call(
      provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'imageProvider';
}

/// See also [image].
class ImageProvider extends AutoDisposeProvider<List<String>> {
  /// See also [image].
  ImageProvider(
    String type,
  ) : this._internal(
          (ref) => image(
            ref as ImageRef,
            type,
          ),
          from: imageProvider,
          name: r'imageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$imageHash,
          dependencies: ImageFamily._dependencies,
          allTransitiveDependencies: ImageFamily._allTransitiveDependencies,
          type: type,
        );

  ImageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final String type;

  @override
  Override overrideWith(
    List<String> Function(ImageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ImageProvider._internal(
        (ref) => create(ref as ImageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<String>> createElement() {
    return _ImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ImageProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ImageRef on AutoDisposeProviderRef<List<String>> {
  /// The parameter `type` of this provider.
  String get type;
}

class _ImageProviderElement extends AutoDisposeProviderElement<List<String>>
    with ImageRef {
  _ImageProviderElement(super.provider);

  @override
  String get type => (origin as ImageProvider).type;
}

String _$availableStorageHash() => r'1ea4f9b401a8289264ff1909d7269bfa3deb435d';

/// See also [availableStorage].
@ProviderFor(availableStorage)
final availableStorageProvider =
    AutoDisposeProvider<List<FileSystemEntity>>.internal(
  availableStorage,
  name: r'availableStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AvailableStorageRef = AutoDisposeProviderRef<List<FileSystemEntity>>;
String _$checkSpaceHash() => r'47f4002a74b0aa74f2a9b4fbf49f166f0f115384';

/// See also [checkSpace].
@ProviderFor(checkSpace)
final checkSpaceProvider = AutoDisposeFutureProvider<void>.internal(
  checkSpace,
  name: r'checkSpaceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$checkSpaceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CheckSpaceRef = AutoDisposeFutureProviderRef<void>;
String _$themeModeManagerHash() => r'3ccb8e6d72021011d06ad15ed6d4ec4dbadbd448';

/// See also [ThemeModeManager].
@ProviderFor(ThemeModeManager)
final themeModeManagerProvider =
    NotifierProvider<ThemeModeManager, ThemeMode>.internal(
  ThemeModeManager.new,
  name: r'themeModeManagerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeModeManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeModeManager = Notifier<ThemeMode>;
String _$modelManagerHash() => r'f99db5ef207b7ce9b35a6363a722ea39edadd511';

/// See also [ModelManager].
@ProviderFor(ModelManager)
final modelManagerProvider = NotifierProvider<ModelManager, Model>.internal(
  ModelManager.new,
  name: r'modelManagerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$modelManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ModelManager = Notifier<Model>;
String _$audioTabsHash() => r'5d4848a54d9fa0c4b3721abd72c41e518fd8a790';

/// See also [AudioTabs].
@ProviderFor(AudioTabs)
final audioTabsProvider =
    AutoDisposeNotifierProvider<AudioTabs, List<String>>.internal(
  AudioTabs.new,
  name: r'audioTabsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$audioTabsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudioTabs = AutoDisposeNotifier<List<String>>;
String _$currentFileHash() => r'3b750fbf9a079ef2f731a1ff5c4bc8ea1e70747b';

/// See also [CurrentFile].
@ProviderFor(CurrentFile)
final currentFileProvider =
    AutoDisposeNotifierProvider<CurrentFile, List<String>>.internal(
  CurrentFile.new,
  name: r'currentFileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentFileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentFile = AutoDisposeNotifier<List<String>>;
String _$imageTabsHash() => r'daffd349cfdfe252ecce75dd89b92ede7e43d48c';

/// See also [ImageTabs].
@ProviderFor(ImageTabs)
final imageTabsProvider =
    AutoDisposeNotifierProvider<ImageTabs, List<String>>.internal(
  ImageTabs.new,
  name: r'imageTabsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$imageTabsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ImageTabs = AutoDisposeNotifier<List<String>>;
String _$audioHash() => r'37fd6662be2d5db99909190a96e00800ced611fd';

/// See also [Audio].
@ProviderFor(Audio)
final audioProvider = AutoDisposeNotifierProvider<Audio, List<String>>.internal(
  Audio.new,
  name: r'audioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$audioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Audio = AutoDisposeNotifier<List<String>>;
String _$pathHash() => r'6c93fd64997ba2f563058c651f9f53a3969550b6';

/// See also [Path].
@ProviderFor(Path)
final pathProvider = NotifierProvider<Path, String>.internal(
  Path.new,
  name: r'pathProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pathHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Path = Notifier<String>;
String _$pathsHash() => r'04055c35dca03605e89f765fc7f41c4b9a68946d';

/// See also [Paths].
@ProviderFor(Paths)
final pathsProvider = NotifierProvider<Paths, List<String>>.internal(
  Paths.new,
  name: r'pathsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pathsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Paths = Notifier<List<String>>;
String _$filesHash() => r'c2bd6fb8f8b4b73e3f7f1f408dcb3c3ba96e308e';

/// See also [Files].
@ProviderFor(Files)
final filesProvider = NotifierProvider<Files, List<FileSystemEntity>>.internal(
  Files.new,
  name: r'filesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$filesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Files = Notifier<List<FileSystemEntity>>;
String _$totalSpaceHash() => r'4fd4a0db31334a806ec2d2d61b1da6e523f6e1f8';

/// See also [TotalSpace].
@ProviderFor(TotalSpace)
final totalSpaceProvider =
    AutoDisposeNotifierProvider<TotalSpace, int>.internal(
  TotalSpace.new,
  name: r'totalSpaceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalSpaceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TotalSpace = AutoDisposeNotifier<int>;
String _$usedSpaceHash() => r'69b9f88771327ab61cfc5bafdc7c4ff553eecf46';

/// See also [UsedSpace].
@ProviderFor(UsedSpace)
final usedSpaceProvider = AutoDisposeNotifierProvider<UsedSpace, int>.internal(
  UsedSpace.new,
  name: r'usedSpaceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usedSpaceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UsedSpace = AutoDisposeNotifier<int>;
String _$totalSDSpaceHash() => r'9ce2eab349b825046b55726851f3b61cc5608edd';

/// See also [TotalSDSpace].
@ProviderFor(TotalSDSpace)
final totalSDSpaceProvider =
    AutoDisposeNotifierProvider<TotalSDSpace, int>.internal(
  TotalSDSpace.new,
  name: r'totalSDSpaceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalSDSpaceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TotalSDSpace = AutoDisposeNotifier<int>;
String _$usedSDSpaceHash() => r'95fae7ec18b618a061d060e65b0f716ffb869ea4';

/// See also [UsedSDSpace].
@ProviderFor(UsedSDSpace)
final usedSDSpaceProvider =
    AutoDisposeNotifierProvider<UsedSDSpace, int>.internal(
  UsedSDSpace.new,
  name: r'usedSDSpaceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usedSDSpaceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UsedSDSpace = AutoDisposeNotifier<int>;
String _$recentFileHash() => r'29e2d3e495a7100132a1452242283c260830b42f';

/// See also [RecentFile].
@ProviderFor(RecentFile)
final recentFileProvider =
    AutoDisposeNotifierProvider<RecentFile, List<String>>.internal(
  RecentFile.new,
  name: r'recentFileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$recentFileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RecentFile = AutoDisposeNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
