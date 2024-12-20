import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../common/Api/api_calling.dart';
import '../../ForwardOutputScreen/view/forward_output.dart';

// Import your property result screen (assuming it's in a separate file)
// import 'property_result_screen.dart';

class ForwardInputScreen extends StatefulWidget {
  const ForwardInputScreen({super.key});

  @override
  ForwardInputScreenState createState() => ForwardInputScreenState();
}

class ForwardInputScreenState extends State<ForwardInputScreen> {
  // ... (keep all your existing parameter variables)

  double emulOilTemp = 40.18;
  double standOilTemp = 39.58;
  double gearOilTemp = 49.99;
  double emulOilPr = 1.52;
  double quenchCWFlowExit = -0.03;
  double castWheelRPM = 1.23;
  double barTemp = 206.23;
  double quenchCWFlowEntry = -0.84;
  double gearOilPr = 1.75;
  double standOilPr = 1.39;
  double tundishTemp = -15.74;
  double rmMotorCoolWater = 1.07;
  double rollMillAmps = 220.61;
  double rmCoolWaterFlow = 193.92;
  double emulsionLevelAnalo = 806.48;
  double siPercent = 0.06;
  double fePercent = 0.14;
  double tiPercent = 0.001;
  double vPercent = 0.001;
  double alPercent = 99.62;
  double furnaceTemperature = 345.84;

  // void _sendRequest() async {
  //   // Define the URL
  //   const String url = 'http://192.168.115.158:8000/api/manual_predict/';
  //
  //   // Create the request body
  //   final Map<String, dynamic> requestBody = {
  //     "EMUL_OIL_L_TEMP_PV_VAL0": emulOilTemp,
  //     "STAND_OIL_L_TEMP_PV_REAL_VAL0": standOilTemp,
  //     "GEAR_OIL_L_TEMP_PV_REAL_VAL0": gearOilTemp,
  //     "EMUL_OIL_L_PR_VAL0": emulOilPr,
  //     "QUENCH_CW_FLOW_EXIT_VAL0": quenchCWFlowExit,
  //     "CAST_WHEEL_RPM_VAL0": castWheelRPM,
  //     "BAR_TEMP_VAL0": barTemp,
  //     "QUENCH_CW_FLOW_ENTRY_VAL0": quenchCWFlowEntry,
  //     "GEAR_OIL_L_PR_VAL0": gearOilPr,
  //     "STANDS_OIL_L_PR_VAL0": standOilPr,
  //     "TUNDISH_TEMP_VAL0": tundishTemp,
  //     "RM_MOTOR_COOL_WATER__VAL0": rmMotorCoolWater,
  //     "ROLL_MILL_AMPS_VAL0": rollMillAmps,
  //     "RM_COOL_WATER_FLOW_VAL0": rmCoolWaterFlow,
  //     "EMULSION_LEVEL_ANALO_VAL0": emulsionLevelAnalo,
  //     "Furnace_Temperature": furnaceTemperature,
  //     "%SI": siPercent,
  //     "%FE": fePercent,
  //     "%TI": tiPercent,
  //     "%V": vPercent,
  //     "%AL": alPercent
  //   };
  //
  //   try {
  //     // Send the POST request
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {'Content-Type': 'application/json; charset=utf-8'},
  //       body: jsonEncode(requestBody),
  //     );
  //
  //     // Handle the response
  //     if (response.statusCode == 200) {
  //       // Parse the response if needed
  //       final responseData = jsonDecode(response.body);
  //       log('Response: $responseData');
  //
  //       // Show a success message or navigate to another screen
  //
  //       // showDialog(
  //       //   context: context,
  //       //   builder: (BuildContext context) {
  //       //     return AlertDialog(
  //       //       title: const Text('Success'),
  //       //       content: const Text('Data sent successfully.'),
  //       //       actions: [
  //       //         TextButton(
  //       //           child: const Text('OK'),
  //       //           onPressed: () {
  //       //             Navigator.of(context).pop();
  //       //           },
  //       //         ),
  //       //       ],
  //       //     );
  //       //   },
  //       // );
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return PropertyResultDialog(responseData['Conductivity'],
  //               responseData['Elongation'], responseData['UTS']);
  //         },
  //       );
  //     } else {
  //       // Handle error
  //       log('Error: ${response.body}');
  //       _showErrorDialog(
  //           'Failed to send data. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     // Handle exception
  //     print('Exception: $error');
  //     _showErrorDialog('An error occurred: $error');
  //   }
  // }

  void sendNewRequest() async {
   var responseData= await Api.getProperties(
        EMUL_OIL_L_TEMP: emulOilTemp,
        STAND_OIL_L_TEMP_PV: standOilTemp,
        GEAR_OIL_L_TEMP_PV: gearOilTemp,
        EMUL_OIL_L_PR_VAL0: emulOilPr,
        QUENCH_CW_FLOW_EXIT: quenchCWFlowExit,
        CAST_WHEEL_RPM_VAL0: castWheelRPM,
        BAR_TEMP_VAL0: barTemp,
        GEAR_OIL_L_PR_VAL0: gearOilTemp,
        STANDS_OIL_L_PR_VAL0: standOilTemp,
        TUNDISH_TEMP_VAL0: tundishTemp,
        RM_MOTOR_COOL_WATER__VAL0: rmMotorCoolWater,
        ROLL_MILL_AMPS_VAL0: rollMillAmps,
        RM_COOL_WATER_FLOW_VAL0: rmCoolWaterFlow,
        QUENCH_CW_FLOW_ENTRY_VAL0: quenchCWFlowEntry,
        EMULSION_LEVEL_ANALO_VAL0: emulsionLevelAnalo,
        Furnace_Temperature: furnaceTemperature, Si: siPercent, Fe: fePercent, Ti: tiPercent, V: vPercent, al: alPercent);
    //showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return AlertDialog(
          //       title: const Text('Success'),
          //       content: const Text('Data sent successfully.'),
          //       actions: [
          //         TextButton(
          //           child: const Text('OK'),
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //         ),
          //       ],
          //     );
          //   },
          // );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ForwardOutput(responseData['Conductivity'],
                  responseData['Elongation'], responseData['UTS']);
            },
          );
  }

// Helper method to show error dialogs
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Input Parameters',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            )),
        backgroundColor: Color(0xFF4318FF),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ... (keep your existing row and parameter rows)

              Row(
                children: const [
                  Expanded(
                      flex: 1,
                      child: Text('Sr.',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 3,
                      child: Text('Parameter',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 3,
                      child: Text('Graphical Value',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 2,
                      child: Text('Numeric Value',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              const Divider(),
              // Input Rows
              buildParameterRow(
                  sr: 1,
                  parameter: 'Emulsion Oil Temp',
                  value: emulOilTemp,
                  unit: '°C',
                  min: 40.18,
                  max: 61.10),
              buildParameterRow(
                  sr: 2,
                  parameter: 'Stand Oil Temp',
                  value: standOilTemp,
                  unit: '°C',
                  min: 39.58,
                  max: 57.50),
              buildParameterRow(
                  sr: 3,
                  parameter: 'Gear Oil Temp',
                  value: gearOilTemp,
                  unit: '°C',
                  min: 49.99,
                  max: 64.44),
              buildParameterRow(
                  sr: 4,
                  parameter: 'Emulsion Oil Pressure',
                  value: emulOilPr,
                  unit: 'atm',
                  min: 1.52,
                  max: 2.70),
              buildParameterRow(
                  sr: 5,
                  parameter: 'Quench CW Flow Exit',
                  value: quenchCWFlowExit,
                  unit: 'L/s',
                  min: -0.03,
                  max: 19.76),
              buildParameterRow(
                  sr: 6,
                  parameter: 'Cast Wheel RPM',
                  value: castWheelRPM,
                  unit: 'RPM',
                  min: 1.23,
                  max: 2.16),
              buildParameterRow(
                  sr: 7,
                  parameter: 'Bar Temp',
                  value: barTemp,
                  unit: '°C',
                  min: 206.23,
                  max: 600.01),
              buildParameterRow(
                  sr: 8,
                  parameter: 'Quench CW Flow Entry',
                  value: quenchCWFlowEntry,
                  unit: 'L/s',
                  min: -0.84,
                  max: 439.95),
              buildParameterRow(
                  sr: 9,
                  parameter: 'Gear Oil Pressure',
                  value: gearOilPr,
                  unit: 'atm',
                  min: 1.75,
                  max: 2.21),
              buildParameterRow(
                  sr: 10,
                  parameter: 'Stand Oil Pressure',
                  value: standOilPr,
                  unit: 'atm',
                  min: 1.39,
                  max: 2.17),
              buildParameterRow(
                  sr: 11,
                  parameter: 'Tundish Temp',
                  value: tundishTemp,
                  unit: '°C',
                  min: -15.74,
                  max: 1070.33),
              buildParameterRow(
                  sr: 12,
                  parameter: 'RM Motor Cool Water',
                  value: rmMotorCoolWater,
                  unit: 'L/s',
                  min: 1.07,
                  max: 1.50),
              buildParameterRow(
                  sr: 13,
                  parameter: 'Roll Mill Amps',
                  value: rollMillAmps,
                  unit: 'A',
                  min: 220.61,
                  max: 744.34),
              buildParameterRow(
                  sr: 14,
                  parameter: 'RM Cool Water Flow',
                  value: rmCoolWaterFlow,
                  unit: 'L/s',
                  min: 193.92,
                  max: 221.55),
              buildParameterRow(
                  sr: 15,
                  parameter: 'Emulsion Level',
                  value: emulsionLevelAnalo,
                  unit: '',
                  min: 806.48,
                  max: 1380.93),
              buildParameterRow(
                  sr: 16,
                  parameter: 'Si %',
                  value: siPercent,
                  unit: '%',
                  min: 0.06,
                  max: 0.13),
              buildParameterRow(
                  sr: 17,
                  parameter: 'Fe %',
                  value: fePercent,
                  unit: '%',
                  min: 0.14,
                  max: 0.26),
              buildParameterRow(
                  sr: 18,
                  parameter: 'Ti %',
                  value: tiPercent,
                  unit: '%',
                  min: 0.001,
                  max: 0.007),
              buildParameterRow(
                  sr: 19,
                  parameter: 'V %',
                  value: vPercent,
                  unit: '%',
                  min: 0.001,
                  max: 0.015),
              buildParameterRow(
                  sr: 20,
                  parameter: 'Al %',
                  value: alPercent,
                  unit: '%',
                  min: 99.62,
                  max: 99.75),
              buildParameterRow(
                  sr: 21,
                  parameter: 'Furnace Temp',
                  value: furnaceTemperature,
                  unit: '°C',
                  min: 345.84,
                  max: 1115.69),

              const SizedBox(height: 20),
              // Modified Button
              ElevatedButton(
                onPressed: () {
                  // Show the properties dialog
                  sendNewRequest();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
                child: const Text('Predict',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (keep your existing buildParameterRow method)

  Widget buildParameterRow({
    required int sr,
    required String parameter,
    required double value,
    required String unit,
    required double min,
    required double max,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 1, child: Text('$sr')),
            Expanded(flex: 3, child: Text(parameter)),
            Expanded(
              flex: 3,
              child: Slider(
                value: value,
                min: min,
                max: max,
                onChanged: (newValue) {
                  // This line was the problem - you need to use a method that can modify the state
                  setState(() {
                    switch (parameter) {
                      case 'Emulsion Oil Temp':
                        emulOilTemp = newValue;
                        break;
                      case 'Stand Oil Temp':
                        standOilTemp = newValue;
                        break;
                      case 'Gear Oil Temp':
                        gearOilTemp = newValue;
                        break;
                      case 'Emulsion Oil Pressure':
                        emulOilPr = newValue;
                        break;
                      case 'Quench CW Flow Exit':
                        quenchCWFlowExit = newValue;
                        break;
                      case 'Cast Wheel RPM':
                        castWheelRPM = newValue;
                        break;
                      case 'Bar Temp':
                        barTemp = newValue;
                        break;
                      case 'Quench CW Flow Entry':
                        quenchCWFlowEntry = newValue;
                        break;
                      case 'Gear Oil Pressure':
                        gearOilPr = newValue;
                        break;
                      case 'Stand Oil Pressure':
                        standOilPr = newValue;
                        break;
                      case 'Tundish Temp':
                        tundishTemp = newValue;
                        break;
                      case 'RM Motor Cool Water':
                        rmMotorCoolWater = newValue;
                        break;
                      case 'Roll Mill Amps':
                        rollMillAmps = newValue;
                        break;
                      case 'RM Cool Water Flow':
                        rmCoolWaterFlow = newValue;
                        break;
                      case 'Emulsion Level':
                        emulsionLevelAnalo = newValue;
                        break;
                      case 'Si %':
                        siPercent = newValue;
                        break;
                      case 'Fe %':
                        fePercent = newValue;
                        break;
                      case 'Ti %':
                        tiPercent = newValue;
                        break;
                      case 'V %':
                        vPercent = newValue;
                        break;
                      case 'Al %':
                        alPercent = newValue;
                        break;
                      case 'Furnace Temp':
                        furnaceTemperature = newValue;
                        break;
                    }
                  });
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${value.toStringAsFixed(2)} $unit',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
