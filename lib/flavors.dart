enum Flavor {
  dev,
  stg,
  prod,
}

extension FlavorName on Flavor {
  String get name => toString().split('.').last;
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Base Code (development)';
      case Flavor.stg:
        return 'Base Code (stg)';
      case Flavor.prod:
        return 'Base Code';
      default:
        return 'title';
    }
  }
  // Server URLs
  static String get serverURL {
    switch (appFlavor) {
      case Flavor.dev:
        return "server_dev";
      case Flavor.stg:
        return "server_staging";
      case Flavor.prod:
        return "server_live";
      default:
        return "";
    }
  }
 //SSO URLS
  static String get ssoURL {
    switch (appFlavor) {
      case Flavor.dev:
        return "SSOURL_DEV";
      case Flavor.stg:
        return "SSOURL_STAGING";
      case Flavor.prod:
        return "SSOURL_LIVE";
      default:
        return "";
    }
  }
}
