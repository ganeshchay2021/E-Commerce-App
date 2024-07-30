class  Constant {
  //base url of Api
  static const String _baseUrl = "https://ecommerce-api-3sb4.onrender.com/api";

  //api of login (post request)
  static String login = "$_baseUrl/auth/login";

  //api of signup (post request)
  static String signup = "$_baseUrl/auth/register";

  //api of banner (get request)
  static String banner = "$_baseUrl/products/featured";

  //api of All product (get request)
  static String allProduct = "$_baseUrl/products";

  //api to add product in cart (Post request)
  static String addToCcart = "$_baseUrl/cart";

  //api to get total price  (get request)
  static String cartTotalPrice = "$_baseUrl/cart/total";
  
  //api to Create Order (post request)
  static String createOrder = "$_baseUrl/orders";

  
  //api to get total numbe or cart product  (get request)
  static String totalNumberOfCartItem = "$_baseUrl/cart/count";

  //api to get order list  (get request)
  static String orderList = "$_baseUrl/orders";
}
