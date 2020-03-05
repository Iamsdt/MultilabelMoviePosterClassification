import 'package:json_annotation/json_annotation.dart';
import "dart:async";
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'RestService.g.dart';

@RestApi(
  baseUrl: "https://rocky-beyond-88001.herokuapp.com/",
)
abstract class RestService {
  factory RestService(Dio dio, {String baseUrl}) = _RestService;

  @POST("analysis/")
  Future<Labels> getLabels(
    @Body() String images,
  );
}

@JsonSerializable()
class Labels {

  List<String> label;

  Labels(this.label);

  factory Labels.fromJson(Map<String, dynamic> json) {
    return Labels(json['result']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.label;
    return data;
  }
}
