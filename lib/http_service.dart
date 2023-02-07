import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Api_Utils.dart';
import 'modal.dart';


class HttpService
{
  Future<List<Result>> getUserDataResponse() async {
    var url = Uri.parse("https://randomuser.me/api/?results=${ApiUtils.person}");
    var response = await http.get(url);
    if(response.statusCode == 200)
      {
        UserDataList users = UserDataList.fromJson(jsonDecode(response.body));
        List<Result> resultsList = [];
        resultsList.addAll(users.results!);
        print(resultsList);
        return resultsList;
      }
    else
      {
        throw "The Code Is Error";
      }
  }
}