
import 'package:flutter/cupertino.dart';

import 'core/utils/flavor_config.dart';
import 'main_common.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  AppFlavorEnvironment.init(FlavorEnvironment.junat);
  mainCommon();
}