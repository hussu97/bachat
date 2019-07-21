enum Environment { DEV, STAGING, PROD }

class Constants {
  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.qaConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get SERVER_ONE {
    return _config[_Config.SERVER_ONE];
  }
}

class _Config {
  static const SERVER_ONE = "SERVER_ONE";

  static Map<String, dynamic> debugConstants = {
    SERVER_ONE: "192.168.1.106:3000/",
  };

  static Map<String, dynamic> qaConstants = {
    SERVER_ONE: "https://staging1.example.com/",
  };

  static Map<String, dynamic> prodConstants = {
    SERVER_ONE: "http://niranjanrakesh.me:3000",
  };
}