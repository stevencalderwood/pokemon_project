class ServiceResult<T> {
  final String? error;
  final T? data;
  const ServiceResult({this.error, this.data});

  @override
  String toString() => '{error: $error, data: $data}';
}
