import 'package:image_picker/image_picker.dart';

import '../presentation/utils/app_snack.dart';
import 'base_64.dart';

class AppImagePicker {
  AppImagePicker._();

 static ImagePicker picker = ImagePicker();

 static Future<String?> showImagePicker() async {
    final XFile? imageFile =
    await picker.pickImage(source: ImageSource.gallery);
    final double size = await Base64Convertor.checkImageSize(imageFile);
    if (size > 5) {
      AppSnack.show(
        message: 'Image should not exceed 5MB',
        status: SnackStatus.info,
      );
      return null;
    } else{
      if (imageFile != null) {
        final String base64StringImage =
        Base64Convertor().imageToBase64(imageFile.path);
        return (base64StringImage.split('base64,').last);
      }
    }
    return null;
  }




}