class Api {
  static const baseUrl = 'https://civiltw-c0bb2554960c.herokuapp.com/api';

  static String urlBuilder({required String endPoint}) {
    return baseUrl + endPoint;
  }
}
