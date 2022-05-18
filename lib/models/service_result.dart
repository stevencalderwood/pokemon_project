/// Helps with the function returns that may fail with specific errors.
///
/// It can carry a [String] as [error]
/// and a variable type [T] as [data].
class ServiceResult<T> {
  final String? error;
  final T? data;
  const ServiceResult({this.error, this.data});

  @override
  String toString() => 'ServiceResult(error: $error, data: $data)';
}
