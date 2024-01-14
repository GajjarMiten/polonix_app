class HttpResult<T> {
  _HttpResultStatus status;
  T? data;
  String message;

  HttpResult.loading(this.message) : status = _HttpResultStatus.LOADING;
  HttpResult.completed(this.data,
      [this.status = _HttpResultStatus.COMPLETED, this.message = 'Success']);
  HttpResult.error([String? message])
      : status = _HttpResultStatus.ERROR,
        message = message ?? "";

  bool get hasError => status == _HttpResultStatus.ERROR && message.isNotEmpty;
  bool get hasData => status == _HttpResultStatus.COMPLETED && data != null;

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

enum _HttpResultStatus { LOADING, COMPLETED, ERROR }
