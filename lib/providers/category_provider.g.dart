// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isarInstanceHash() => r'3bbbf5aa7cbc90053585882cd5d49de7af5cc384';

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

String _$downloadHash() => r'a435c351f7d2036ed662ced330a5825e52f7f392';

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
String _$modelManagerHash() => r'94ddb79d8702cbb115845cafe4db01930fda061a';

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
String _$downloadTabsHash() => r'9eb2e3c63a37288399e00e5c2d438849e1f9a854';

/// See also [DownloadTabs].
@ProviderFor(DownloadTabs)
final downloadTabsProvider =
    AutoDisposeNotifierProvider<DownloadTabs, List<String>>.internal(
  DownloadTabs.new,
  name: r'downloadTabsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$downloadTabsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DownloadTabs = AutoDisposeNotifier<List<String>>;
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
