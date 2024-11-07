import 'package:flutter/cupertino.dart';
import '../../utils/app_image_assets.dart';
import 'exception_indicator.dart';

class EmptyListIndicator extends StatelessWidget {
  const EmptyListIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return const ExceptionIndicator(
      title: 'Sorry!',
      message: 'No result found.',
      assetName: AssetImages.emptyListLight,
    );
  }
}
