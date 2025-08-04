import 'dart:convert';

extension StringExtensions on String {
  String get svg => 'assets/icons/$this.svg';
  String get png => 'assets/images/$this.png';
  String get jpeg => 'assets/images/$this.jpeg';


  get price => '\$$this';

  int get toInt {
    try {
      return int.parse(this);
    } catch(e) {
      return double.parse(this).round();
    }
  }

  double get toDouble {
    return double.parse(this);
  }

  List<String> get toList {
    List<String> list = [];
    try {
      json.decode(this).forEach((v) {
        list.add(v.toString());
      });
    } catch(e) {
      list.add(this);
    }
    return list;
  }

}

