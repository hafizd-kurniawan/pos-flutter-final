import 'package:dartz/dartz.dart';
import 'package:flutter_pos_responsive_app/core/constants/variables.dart';
import 'package:flutter_pos_responsive_app/data/datasource/auth_local_datasource.dart';
import 'package:flutter_pos_responsive_app/data/models/response/category_response_model.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  Future<Either<String, CategoryResponseModel>> getCategories() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/categories'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(CategoryResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
