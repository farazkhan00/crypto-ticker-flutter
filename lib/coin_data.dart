import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = '87632ADB-A0B6-4077-9118-924229FEDD28';
const domainURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getNetworkData(String currency) async {
    var currencyData;
    Map<String, String> cryptoPrices = {};
    for(String crypto in cryptoList) {

      var url = Uri.parse('$domainURL/$crypto/$currency?apikey=$apiKey');
      http.Response response = await http.get(url);
      currencyData = response.body;
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(currencyData);
        double lastRate = decodedData ['rate'];
        cryptoPrices[crypto] = lastRate.toStringAsFixed(0);
      }
      else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
