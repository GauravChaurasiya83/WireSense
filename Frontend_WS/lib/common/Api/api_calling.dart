import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../features/ReversedProcessing/model/data_model_new.dart';

class Api {
  static String url = 'http://10.10.210.254:8000';

  /// forward
  static Future<Map<String, dynamic>> getProperties(
      {required double EMUL_OIL_L_TEMP,
      required double STAND_OIL_L_TEMP_PV,
      required double GEAR_OIL_L_TEMP_PV,
      required double EMUL_OIL_L_PR_VAL0,
      required double QUENCH_CW_FLOW_EXIT,
      required double CAST_WHEEL_RPM_VAL0,
      required double BAR_TEMP_VAL0,
      required double GEAR_OIL_L_PR_VAL0,
      required double STANDS_OIL_L_PR_VAL0,
      required double TUNDISH_TEMP_VAL0,
      required double RM_MOTOR_COOL_WATER__VAL0,
      required double ROLL_MILL_AMPS_VAL0,
      required double RM_COOL_WATER_FLOW_VAL0,
      required double QUENCH_CW_FLOW_ENTRY_VAL0,
      required double EMULSION_LEVEL_ANALO_VAL0,
      required double Furnace_Temperature,
      required double Si,
      required double Fe,
      required double Ti,
      required double V,
      required double al}) async {
    Map<String, dynamic> data = {
      "EMUL_OIL_L_TEMP_PV_VAL0": EMUL_OIL_L_TEMP,
      "STAND_OIL_L_TEMP_PV_REAL_VAL0": STAND_OIL_L_TEMP_PV,
      "GEAR_OIL_L_TEMP_PV_REAL_VAL0": GEAR_OIL_L_TEMP_PV,
      "EMUL_OIL_L_PR_VAL0": EMUL_OIL_L_PR_VAL0,
      "QUENCH_CW_FLOW_EXIT_VAL0": QUENCH_CW_FLOW_EXIT,
      "CAST_WHEEL_RPM_VAL0": CAST_WHEEL_RPM_VAL0,
      "BAR_TEMP_VAL0": BAR_TEMP_VAL0,
      "QUENCH_CW_FLOW_ENTRY_VAL0": QUENCH_CW_FLOW_ENTRY_VAL0,
      "GEAR_OIL_L_PR_VAL0": GEAR_OIL_L_PR_VAL0,
      "STANDS_OIL_L_PR_VAL0": STANDS_OIL_L_PR_VAL0,
      "TUNDISH_TEMP_VAL0": TUNDISH_TEMP_VAL0,
      "RM_MOTOR_COOL_WATER__VAL0": RM_MOTOR_COOL_WATER__VAL0,
      "ROLL_MILL_AMPS_VAL0": ROLL_MILL_AMPS_VAL0,
      "RM_COOL_WATER_FLOW_VAL0": RM_MOTOR_COOL_WATER__VAL0,
      "EMULSION_LEVEL_ANALO_VAL0": EMULSION_LEVEL_ANALO_VAL0,
      "Furnace_Temperature": Furnace_Temperature,
      "%SI": Si,
      "%FE": Fe,
      "%TI": Ti,
      "%V": V,
      "%AL": al
    };
    try {
      final response = await http.post(
        Uri.parse("$url/api/manual_predict/"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint('data from ml model is -> ${response.body}');
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print(jsonResponse);
        }
        return jsonResponse;
      } else if (response.statusCode == 400) {
        debugPrint('error is -> bad request');
        return {"error": 0};
      } else {
        debugPrint(
          'error:Failed to get data from model. Status code: ${response.statusCode}',
        );
        return {"error": 0};
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return {"error": 0};
    }
  }

  /// reverse
  static Future<void> getParameters({
    required String uts,
    required String conductivity,
    required String elongation,
  }) async {
    Map<String, dynamic> data = {
      "UTS": uts,
      "Elongation": elongation,
      "Conductivity": conductivity,
    };

    try {
      final response = await http.post(
        Uri.parse('$url/read-csv-type-1'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        debugPrint('data from ml model is -> ${response.body}');
      } else if (response.statusCode == 400) {
        debugPrint('error is -> bad request');
      } else {
        debugPrint(
          'error: Failed to get data from model. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
    }
  }

  static Future<bool> loginUser(
      {required String employeeId, required String password}) async {
    Map<String, dynamic> data = {
      "employee_id": employeeId,
      "password": password
    };

    Dio dio = Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      ),
    );

    try {
      final response = await dio.post('$url/api/employee_login/', data: data);

      if (response.statusCode == 200) {
        debugPrint('user successfully registered-> ${response.data}');
        return true;
      } else if (response.statusCode == 401) {
        debugPrint('error is -> invalid credentials');
        return false;
      } else {
        debugPrint(
          'error:Failed to login model. Status code: ${response.statusCode}',
        );
        return false;
      }
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        debugPrint('DioError: ${dioError.response?.data}');
        return false;
      } else {
        debugPrint('DioError: ${dioError.message}');
        return false;
      }
    } catch (e) {
      debugPrint('Exception caught: $e');
      return false;
    }
  }

  static Future<List<MeasurementData>> getDashBoardData() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:5000/read-csv-type-0'));

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Fetch charges has been successfully hit");
        }
        final Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> data = jsonData['data'];

        List<MeasurementData> measurementList = data.map((item) => MeasurementData.fromJson(item)).toList();
        return measurementList;
      }
      else if (response.statusCode == 404) {
        throw Exception('Resource not found');
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error');
      } else {
        throw Exception('Failed to load charges with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load charges: $e');
    }
  }

}
