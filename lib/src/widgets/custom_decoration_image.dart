import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loanapp/core/constants/assets/app_images.dart';
import 'package:loanapp/core/constants/colors/app_colors.dart';

import '../../core/constants/strings/app_constants.dart';

DecorationImage customDecorationImage({
  final String? image,
  final BoxFit? fit,
  final bool innerShadow = false,
}) {
  return image == null || image.isEmpty
      ? DecorationImage(
          image: AssetImage(
            AppImages.placeholder,
          ),
          colorFilter: innerShadow
              ? ColorFilter.mode(
                  AppColors.kBlackColor.withOpacity(.2),
                  BlendMode.darken,
                )
              : null,
          fit: fit ?? BoxFit.cover,
        )
      : DecorationImage(
          image: CachedNetworkImageProvider(
            AppConstant.imagePath + image,
          ),
          colorFilter: innerShadow
              ? ColorFilter.mode(
                  AppColors.kBlackColor.withOpacity(.2),
                  BlendMode.darken,
                )
              : null,
          fit: fit ?? BoxFit.cover,
        );
}
