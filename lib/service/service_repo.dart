import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

abstract class ServiceRepo<Data, Error> {
  Future<MainResponse> detail(Map<String, dynamic> param);
  // List<MainResponse<Data, Error>> put(Map<String, dynamic> param);
  // List<MainResponse<Data, Error>> patch(Map<String, dynamic> param);
  // List<MainResponse<Data, Error>> delete(Map<String, dynamic> param);
}

class ServiceRepoImpl implements ServiceRepo {
  late http.Client client;
  late Uri _url;
  Map<String, String> _getHeader() {
    const token = "your Token";
    return <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  ServiceRepoImpl() {
    _url = Uri(scheme: 'http', host: 'myhost');
    client = RetryClient(
      http.Client(),
      retries: 1,
      when: (response) => response.statusCode == 401 ? true : false,
      onRetry:
          (http.BaseRequest req, http.BaseResponse? res, int retryCount) async {
        /// here generate new token with your access token like this
        final request = await client.post(_url.replace(path: 'access/token'),
            body: {'refresh': 'your refresh token'});
        if (request.statusCode == 200) {
          final token = request.body;
          req.headers['Authorization'] = 'Bearer $token';
          return;
        }
        throw Exception('Authorization Exception');
      },
    );
  }

  @override
  Future<MainResponse> detail(Map<String, dynamic> param) async {
    final request = await client.get(
      _url.replace(path: 'your path', queryParameters: param),
      headers: _getHeader(),
    );
    if (request.statusCode == 200) {
      return MainResponse();
    }
    return MainResponse();
  }
}

class MainResponse<Data, Error> {
  final Data? data;
  final Error? error;
  MainResponse({this.data, this.error});
}
