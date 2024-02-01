import 'package:fidelyz/src/services/response/Status.dart';

class ApiResponse<T> {
  String? message;
  T? data;
  Status? status;

  ApiResponse(this.message, this.data, this.status);

  ApiResponse.pending() : status = Status.PENDING;
  ApiResponse.approved(this.data) : status = Status.APPROVED;
  ApiResponse.rejected(this.message) : status = Status.REJECTED;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data";
  }
}
