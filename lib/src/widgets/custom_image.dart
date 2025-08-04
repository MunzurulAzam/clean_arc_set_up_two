import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loanapp/core/constants/assets/app_images.dart';
import 'package:loanapp/core/constants/strings/app_constants.dart';

import '../../core/constants/colors/app_colors.dart';

class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String? image;
  final String? productType;
  final String? baseUrl;
  final String? placeHolder;
  final BoxFit? fit;
  final double radius;
  final bool innerShadow;

  const CustomImage({
    Key? key,
    this.width,
    this.height,
    this.placeHolder,
    this.fit,
    this.baseUrl,
    this.radius = 0,
    this.innerShadow = false,
    this.productType,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: image == null || image!.isEmpty
            ? Image.asset(
                AppImages.placeholder,
                fit: fit ?? BoxFit.cover,
                color: innerShadow ? Colors.black.withOpacity(.3) : null,
                colorBlendMode: innerShadow ? BlendMode.darken : null,
              )
            : CachedNetworkImage(
                imageUrl: baseUrl ?? AppConstant.imagePath + image!,
                fit: fit ?? BoxFit.cover,
                color: innerShadow ? Colors.black.withOpacity(.3) : null,
                colorBlendMode: innerShadow ? BlendMode.darken : null,
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.kDividerColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Image.asset(
                    placeHolder ?? AppImages.placeholder,
                    fit: BoxFit.cover,
                    height: height,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  placeHolder ?? AppImages.placeholder,
                  fit: BoxFit.cover,
                  height: height,
                ),
              ),
      ),
    );
  }
}

class AppImagerLoader extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double? errorIconSize;
  final BoxFit? fit;
  final String? placeholder;

  const AppImagerLoader({Key? key, required this.imageUrl, required this.height, required this.width, this.fit, this.errorIconSize, this.placeholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        color: Colors.grey[100],
        height: height,
        width: width,
      ),
      errorWidget: (context, url, error) => placeholder != null
          ? Image.asset(
              placeholder!,
              width: width,
              height: height,
            )
          : Icon(
              Icons.error,
              size: errorIconSize ?? height,
            ),
    );
  }
}

class AppRatioImager extends StatelessWidget {
  final String imageUrl;
  final double? errorIconSize;
  final double aspectRatio;
  final BoxFit? fit;

  const AppRatioImager({Key? key, required this.imageUrl, this.fit, this.errorIconSize, this.aspectRatio = 16 / 9}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
          ),
        ),
        placeholder: (context, url) => Container(
          color: Colors.grey[100],
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          size: errorIconSize ?? 25,
        ),
      ),
    );
  }
}
