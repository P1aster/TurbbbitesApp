import 'package:get/get.dart';

mixin BaseApiController {
  final RxBool isLoading = false.obs;
  final RxBool isError = false.obs;
  final RxBool isSuccess = false.obs;
  final RxString message = ''.obs;
  final RxString error = "".obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void setSuccess(bool value) {
    isSuccess.value = value;
  }

  void setMessage(String value) {
    message.value = value;
  }

  void setError(String value) {
    error.value = value;
    isError.value = true;
  }

  void resetStates() {
    isLoading.value = false;
    isError.value = false;
    isSuccess.value = false;
    message.value = '';
    error.value = '';
  }
}
