import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_padding.dart';
import '../../../../../core/presentation/widgets/app_logo.dart';
class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key,
    this.logoUrl,
    this.size = 50,
    this.radius = 15,
  });

  final String? logoUrl;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: context.colorScheme.secondary
                  .withValues(alpha: 0.4),
            ),
          ),
          child: logoUrl != null && logoUrl!.isNotEmpty
              ? CachedNetworkImage(
            imageUrl: logoUrl!,
            errorWidget: (BuildContext context, String url,
                dynamic error) =>
            const Icon(Icons.error),
          )
              : const AppLogo(),
        ),
      ),
    );
  }
}

