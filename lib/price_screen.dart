import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'networkHelper.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Map<String, String> dataCurrency = {};
  String selectedValue = 'USD';
  @override
  void initState() {
    super.initState();
    //getusd();
    getData();
  }

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper(usd: selectedValue);

    for (String curr in cryptoList) {
      var data = await networkHelper.getDataforCurrency(curr);
      try {
        // int convertData = data.toInt();
        setState(() {
          dataCurrency[curr] = data.toString();
        });
      } catch (e) {
        print(e);
      }
    }
  }

  DropdownButton<String> getDropDownItem() {
    List<DropdownMenuItem<String>> dropDownList = [];

    for (String item in currenciesList) {
      var list = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      dropDownList.add(list);
    }

    return DropdownButton<String>(
        value: selectedValue,
        items: dropDownList,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            //getusd();
            getData();
          });
        });
  }

  CupertinoPicker getPicker() {
    List<Widget> value = [];
    for (String item in currenciesList) {
      var newValue = Text(item);
      value.add(newValue);
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
        },
        children: value);
  }

  Widget getPlatform() {
    if (Platform.isAndroid) {
      return getDropDownItem();
    } else if (Platform.isIOS) {
      return getPicker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BoxCard(
            //values: valueforBTC,
            values: dataCurrency['BTC'] ?? '?',
            selectedValue: selectedValue,
            cryptoValue: cryptoList[0],
          ),
          BoxCard(
              // values: valueforETH,
              values: dataCurrency['ETH'] ?? '?',
              selectedValue: selectedValue,
              cryptoValue: cryptoList[1]),
          BoxCard(
              // values: valueforLTC,
              values: dataCurrency['LTC'] ?? '?',
              selectedValue: selectedValue,
              cryptoValue: cryptoList[2]),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getDropDownItem(),
          ),
        ],
      ),
    );
  }
}

class BoxCard extends StatelessWidget {
  const BoxCard(
      {@required this.values,
      @required this.selectedValue,
      @required this.cryptoValue});

  final String values;
  final String selectedValue;
  final String cryptoValue;

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
            '1 $cryptoValue = $values $selectedValue',
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

// void getusd() async {
//   print(selectedValue);
//   NetworkHelper networkHelper = NetworkHelper(usd: selectedValue);
//   double dataOfBTC = await networkHelper.getDataforBTC();
//   double dataOfLTC = await networkHelper.getDataforLTC();
//   double dataOfETH = await networkHelper.getDataforETH();
//   try {
//     int convDataBTC = dataOfBTC.toInt();
//     setState(() {
//       valueforBTC = convDataBTC.toString();
//     });
//   } catch (e) {
//     print(e);
//   }
//   try {
//     int convDataLTC = dataOfLTC.toInt();
//     setState(() {
//       valueforLTC = convDataLTC.toString();
//     });
//   } catch (e) {
//     print(e);
//   }
//   try {
//     int convDataETH = dataOfETH.toInt();
//     setState(() {
//       valueforETH = convDataETH.toString();
//     });
//   } catch (e) {
//     print(e);
//   }
// }
