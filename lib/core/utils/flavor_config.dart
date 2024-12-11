enum FlavorEnvironment { automanager, junat }

class AppFlavorEnvironment {
  static late FlavorEnvironment _flavorEnvironment;
  static late String environmentName;

  static FlavorEnvironment get environment => _flavorEnvironment;


  static String? get appFlavor => const String.fromEnvironment('FLUTTER_APP_FLAVOR') != '' ?
  const String.fromEnvironment('FLUTTER_APP_FLAVOR') : null;

  static void init(FlavorEnvironment flavorEnvironment) {

    _flavorEnvironment = flavorEnvironment;
    switch(flavorEnvironment){
      case FlavorEnvironment.automanager:
        environmentName = 'automanager';
        break;
      case FlavorEnvironment.junat:
        environmentName = 'junat';
        break;
      default:
        environmentName = 'automanager';
    }
  }

}