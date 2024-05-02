// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$checkSpaceAndRecentFilesHash() =>
    r'3cde6730b39e31c663a65df3c7f452d0eb5b678c';

/// See also [checkSpaceAndRecentFiles].
@ProviderFor(checkSpaceAndRecentFiles)
final checkSpaceAndRecentFilesProvider =
    AutoDisposeFutureProvider<void>.internal(
  checkSpaceAndRecentFiles,
  name: r'checkSpaceAndRecentFilesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$checkSpaceAndRecentFilesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CheckSpaceAndRecentFilesRef = AutoDisposeFutureProviderRef<void>;
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
