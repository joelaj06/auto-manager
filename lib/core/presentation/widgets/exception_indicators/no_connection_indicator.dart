
import 'package:flutter/cupertino.dart';

import '../../utils/app_image_assets.dart';
import 'exception_indicator.dart';

/// Indicates that a connection error occurred.
class NoConnectionIndicator extends StatelessWidget {
  const NoConnectionIndicator({
    super.key,
    this.onTryAgain,
  });

  final VoidCallback? onTryAgain;


  @override
  Widget build(BuildContext context) => ExceptionIndicator(
        title: 'No connection',
        message: 'Please check internet connection and try again.',
        assetName: AssetImages.noConnectionLight,
        onTryAgain: onTryAgain,
      );
}
