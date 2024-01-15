class HttpResult<T> {
  final HttpResultStatus status;
  final T? data;
  final String message;

  HttpResult.loading(this.message)
      : status = HttpResultStatus.loading,
        data = null;
  HttpResult.completed(this.data,
      [this.status = HttpResultStatus.completed, this.message = 'Success']);
  HttpResult.error([String? message])
      : status = HttpResultStatus.error,
        message = message ?? "",
        data = null;

  bool get isLoading => status == HttpResultStatus.loading;

  bool get hasError => status == HttpResultStatus.error && message.isNotEmpty;
  bool get hasData => status == HttpResultStatus.completed && data != null;

  bool get isNull => data == null;

  bool get isNotNull => !isNull;

  bool get isEmpty {
    if (isNull) return true;

    if (data is List) {
      return (data as List).isEmpty;
    }
    if (data is Map) {
      return (data as Map).isEmpty;
    }

    return data.toString().trim().isEmpty;
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum HttpResultStatus { loading, completed, error }
