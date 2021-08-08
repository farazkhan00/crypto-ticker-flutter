import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> stringRate;
  String selectedCrypto = 'BTC';
  bool isWaiting = false;



  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownData = [];
    for (String currency in currenciesList) {
      var menuItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownData.add(menuItem);
    }
    return DropdownButton<String>(
      dropdownColor: Colors.lightBlue,
      value: selectedCurrency,
      items: dropDownData,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getCoinData();
        });
      },
    );
  }

  void getCoinData() async {

    isWaiting = true;

    try{
      var rate = await CoinData().getNetworkData(selectedCurrency);
      isWaiting = false;

      setState(() {
          stringRate = rate;
      });
    }
    catch(e){
      print(e);
    }
  }

  CupertinoPicker iosPicker(){
    List<Text> currencyItems = [];
    for (String currency in currenciesList) {
      currencyItems.add(Text(currency));
    }

    return CupertinoPicker(
      children: currencyItems,
      itemExtent: 38.0,
      onSelectedItemChanged: (int selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getCoinData();
      },
    );
  }

@override
  void initState() {
    super.initState();
    getCoinData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(selectedCrypto: 'BTC', stringRate: isWaiting ? '?' : stringRate['BTC'], selectedCurrency: selectedCurrency),
          CryptoCard(selectedCrypto: 'ETH', stringRate: isWaiting ? '?' : stringRate['ETH'], selectedCurrency: selectedCurrency),
          CryptoCard(selectedCrypto: 'LTC', stringRate: isWaiting ? '?' : stringRate['LTC'], selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropDown()
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    @required this.selectedCrypto,
    @required this.stringRate,
    @required this.selectedCurrency,
  });

  final String selectedCrypto;
  final String stringRate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $selectedCrypto = $stringRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
