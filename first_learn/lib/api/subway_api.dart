import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:hello_flutter/model/subway_arrival.dart';

const int STATUS_OK = 200;

const String _urlPrefix = 'http://swopenapi.seoul.go.kr/api/subway/';
const String _userKey = 'sample';
const String _urlSuffix = '/json/realtimeStationArrival/0/5/';
const String defaultStation = '광화문';

String buildUrl(String station) {
  StringBuffer sb = StringBuffer();
  sb.write(_urlPrefix);
  sb.write(_userKey);
  sb.write(_urlSuffix);
  sb.write(station);
  return sb.toString();
}
