class NetworkRoute {
  static String listOfAssets() {
    return "/v3/assets";
  }

  static String assetDetails(String slug) {
    return "/v3/assets/$slug";
  }

  static String assetHistory(String slug) {
    return "/v3/assets/$slug/history";
  }
}
