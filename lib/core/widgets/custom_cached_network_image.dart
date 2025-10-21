import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? defaultImageUrl;
  final bool isCircular;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.defaultImageUrl,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    final String finalImageUrl = (imageUrl.isNotEmpty) ? imageUrl : (defaultImageUrl ?? "https://via.placeholder.com/100/CCCCCC/808080?text=?");

    Widget imageWidget = CachedNetworkImage(
      imageUrl: finalImageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholder ?? _defaultPlaceholder(),
      errorWidget: (context, url, error) => errorWidget ?? _defaultErrorWidget(),
    );

    if (isCircular) {
      return ClipOval(child: imageWidget);
    } else if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }

  Widget _defaultPlaceholder() {
    if (isCircular) {
      return CircleAvatar(
        radius: (width != null) ? width! / 2 : 10,
        backgroundColor: Colors.grey[300],
        child: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      );
    }
    
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _defaultErrorWidget() {
    if (isCircular) {
      return CircleAvatar(
        radius: (width != null) ? width! / 2 : 10,
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    }
    
    return Container(
      width: width,
      height: height,
      color: Colors.grey,
      child: const Icon(
        Icons.broken_image,
        color: Colors.white,
      ),
    );
  }
}