class Api {
  static const baseUrl = "https://unstoppabledomains.com/api/v1/resellers/";

  static const String domainName = "/myetherwallet/domains/variations?";
  static const String ordersNumber = "/{resellerID}/users/{email}/orders";
  static const String pollStatus = "{resellerID}/users/{email}/orders/{orderNumber}";
}
