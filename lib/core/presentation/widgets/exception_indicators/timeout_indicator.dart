import 'package:flutter/cupertino.dart';

import '../../utils/app_image_assets.dart';
import 'exception_indicator.dart';

/// Indicates that a connection timeout error occurred.
class RequestTimeoutIndicator extends StatelessWidget {
  const RequestTimeoutIndicator({
    super.key,
    this.onTryAgain,
  });

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => ExceptionIndicator(
    title: 'Request Timeout',
    message: 'The app took too long to respond',
    assetName: AssetImages.timeOut,
    onTryAgain: onTryAgain,
  );
}
