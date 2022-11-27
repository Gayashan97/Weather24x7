import 'package:http/http.dart' as http;

class Networking {
  final String url;

  Networking(this.url);

  Future<String> getData() async {
    http.Response response;

    try {
      response = await http.get(Uri.parse(url));
    } catch (e) {
      print("Unable to get response");
    }

    String data;

    if (response.statusCode == 200) {
      data = response.body;
    } else {
      print(response.statusCode);
      data = response.body;
    }
    return data;
  }
}
