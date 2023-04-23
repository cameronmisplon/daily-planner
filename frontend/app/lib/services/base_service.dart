import 'package:app/services/api.dart';
import 'package:app/services/locator.dart';

abstract class BaseService {
  final Api api = locator<Api>();

  validateSuccessfulJsonResponse(
      dynamic responseBody, {
        Function? preExceptionFunction,
        Map<String, dynamic>? preExceptionFunctionParameters,
        List<int> acceptableCodes = const [200],
      }) {
    if (responseBody.containsKey('status')) {
      if (!acceptableCodes.contains(responseBody['status']['code'])) {
        if (preExceptionFunction != null)
          preExceptionFunction(preExceptionFunctionParameters);
      }
    } else {
    }
  }
}