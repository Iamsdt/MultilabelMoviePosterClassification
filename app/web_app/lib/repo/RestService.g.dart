// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RestService.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Labels _$LabelsFromJson(Map<String, dynamic> json) {
  return Labels(
    (json['label'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$LabelsToJson(Labels instance) => <String, dynamic>{
      'label': instance.label,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestService implements RestService {
  _RestService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://rocky-beyond-88001.herokuapp.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getLabels(images) async {
    ArgumentError.checkNotNull(images, 'images');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = images;
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'analysis/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Labels.fromJson(_result.data);
    return Future.value(value);
  }
}
