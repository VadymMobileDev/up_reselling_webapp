class Api {
  static const baseUrl = "https://unstoppabledomains.com/api/v1/resellers/";

  static const String domainName = "/myetherwallet/domains/variations?";
  static const String ordersNumber = "/{resellerID}/users/{email}/orders";
  static const String pollStatus = "{resellerID}/users/{email}/orders/{orderNumber}";
  static const String checkDomain = "{resellerID}/domains/{domainName}";

  static const baseUrlXumm = "https://xumm.app/api/v1/platform/rates/";
  static const String currency = "{currency}";


}
