class ApiConstants {
  static const String baseUrl = "https://ecommerce-backend-production-0e7b.up.railway.app/api";

  // Auth
  static const String register = "/auth/register";
  static const String login = "/auth/login";
  static const String logout = "/auth/logout";
  static const String refreshToken = "/auth/refresh-token";
  static const String profile = "/auth/profile";

  // Products
  static const String products = "/products";

  // Cart
  static const String cart = "/cart";

  // Orders
  static const String orders = "/orders";
  static const String myOrders = "/orders/my-orders";

  // Categories
  static const String categories = "/categories";

  // Favourites
  static const String favourites = "/favourites";

  // Reviews
  static const String reviews = "/reviews";

  // Addresses
  static const String addresses = "/addresses";

  // Notifications
  static const String notifications = "/notifications";
}