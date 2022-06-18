import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../export_feature.dart';
class ReusableCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  final double? height;
  final double? placeHolderHeight;
  final double? width;
  final double? placeHolderWidth;
  final int? memCacheWidth;
  final int? memCacheHeight;

  final BoxFit? fit;

  final bool showProgress, showOnError;
  final Function? onError;

  const ReusableCachedNetworkImage(
      {Key? key,
        required this.imageUrl,
        this.height,
        this.width,
        this.fit,
        this.showProgress = true,
        this.showOnError = true,
        this.placeHolderHeight,
        this.placeHolderWidth,
        this.memCacheWidth,
        this.memCacheHeight,
        this.onError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheKey: imageUrl,

      height: height,
      width: width,
      fit: fit,
      filterQuality: FilterQuality.medium,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      fadeInDuration: const Duration(milliseconds: 400),
      progressIndicatorBuilder: showProgress
          ? (_, __, DownloadProgress progress) {
        return SizedBox(
          height: placeHolderHeight ?? height,
          width: placeHolderWidth ?? width,
          child: getCenterCircularProgress(
            size: 24,
          ),
        );
      }
          : null,
      errorWidget: showOnError
          ? (context, url, error) {
        onError?.call();
        return SizedBox(
          height: placeHolderHeight ?? height,
          width: placeHolderWidth ?? width,
          child: Center(
            child: Icon(
              Icons.error,
              color: Theme.of(context).accentColor,
            ),
          ),
        );
      }
          : null,
    );
  }
}
