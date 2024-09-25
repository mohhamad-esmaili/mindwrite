/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/GoogleSans-Bold.ttf
  String get googleSansBold => 'assets/fonts/GoogleSans-Bold.ttf';

  /// File path: assets/fonts/GoogleSans-BoldItalic.ttf
  String get googleSansBoldItalic => 'assets/fonts/GoogleSans-BoldItalic.ttf';

  /// File path: assets/fonts/GoogleSans-Italic.ttf
  String get googleSansItalic => 'assets/fonts/GoogleSans-Italic.ttf';

  /// File path: assets/fonts/GoogleSans-Medium.ttf
  String get googleSansMedium => 'assets/fonts/GoogleSans-Medium.ttf';

  /// File path: assets/fonts/GoogleSans-MediumItalic.ttf
  String get googleSansMediumItalic =>
      'assets/fonts/GoogleSans-MediumItalic.ttf';

  /// File path: assets/fonts/GoogleSans-Regular.ttf
  String get googleSansRegular => 'assets/fonts/GoogleSans-Regular.ttf';

  /// List of all assets
  List<String> get values => [
        googleSansBold,
        googleSansBoldItalic,
        googleSansItalic,
        googleSansMedium,
        googleSansMediumItalic,
        googleSansRegular
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/book.png
  AssetGenImage get book => const AssetGenImage('assets/images/book.png');

  /// File path: assets/images/food_light.png
  AssetGenImage get foodLight =>
      const AssetGenImage('assets/images/food_light.png');

  /// File path: assets/images/food_night.png
  AssetGenImage get foodNight =>
      const AssetGenImage('assets/images/food_night.png');

  /// File path: assets/images/fruit_light.png
  AssetGenImage get fruitLight =>
      const AssetGenImage('assets/images/fruit_light.png');

  /// File path: assets/images/fruit_night.png
  AssetGenImage get fruitNight =>
      const AssetGenImage('assets/images/fruit_night.png');

  /// File path: assets/images/logo_dark.svg
  SvgGenImage get logoDark => const SvgGenImage('assets/images/logo_dark.svg');

  /// File path: assets/images/music.png
  AssetGenImage get music => const AssetGenImage('assets/images/music.png');

  /// File path: assets/images/park_light.png
  AssetGenImage get parkLight =>
      const AssetGenImage('assets/images/park_light.png');

  /// File path: assets/images/park_night.png
  AssetGenImage get parkNight =>
      const AssetGenImage('assets/images/park_night.png');

  /// File path: assets/images/pencill.png
  AssetGenImage get pencill => const AssetGenImage('assets/images/pencill.png');

  /// File path: assets/images/pool_light.png
  AssetGenImage get poolLight =>
      const AssetGenImage('assets/images/pool_light.png');

  /// File path: assets/images/pool_night.png
  AssetGenImage get poolNight =>
      const AssetGenImage('assets/images/pool_night.png');

  /// File path: assets/images/tran_light.png
  AssetGenImage get tranLight =>
      const AssetGenImage('assets/images/tran_light.png');

  /// File path: assets/images/tran_night.png
  AssetGenImage get tranNight =>
      const AssetGenImage('assets/images/tran_night.png');

  /// List of all assets
  List<dynamic> get values => [
        appLogo,
        book,
        foodLight,
        foodNight,
        fruitLight,
        fruitNight,
        logoDark,
        music,
        parkLight,
        parkNight,
        pencill,
        poolLight,
        poolNight,
        tranLight,
        tranNight
      ];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
