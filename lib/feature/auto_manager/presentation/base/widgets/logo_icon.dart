import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/app_logo.dart';
class LogoIcon extends StatelessWidget {
  const LogoIcon({required this.logoUrl});

  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 36,
        height: 36,
        child: logoUrl != null &&
            logoUrl != ''
            ? CachedNetworkImage(
          imageUrl: logoUrl!,
          errorWidget:
              (BuildContext context, String url, dynamic error) =>
          const Icon(Icons.error),
        )
            : const AppLogo()
    );
  }
}
