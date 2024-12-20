import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/image_res.dart';

class ReverseOutput extends ConsumerStatefulWidget {
  const ReverseOutput({
    super.key,
    required this.uts,
    required this.conductivity,
    required this.elongation,
  });

  final double? uts;
  final double? conductivity;
  final double? elongation;

  @override
  ReverseOutputState createState() => ReverseOutputState();
}

class ReverseOutputState extends ConsumerState<ReverseOutput> {


  // Example data for parameters
  final List<Map<String, dynamic>> editableParameters = [
    {
      'name': 'Conductivity',
      'value': 50,
      'icon': Icons.bolt,
      'color': Colors.blue
    },
    {
      'name': 'Elongation',
      'value': 75,
      'icon': Icons.straighten,
      'color': Colors.green
    },
    {'name': 'UTS', 'value': 90, 'icon': Icons.speed, 'color': Colors.red},
  ];

  bool isEditing = false;

  void updateValues() {
    // Simulate recalculating values based on changes
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    // give values here..
    double? emulOilTemp = 0.0;
    double? standOilTemp = 0;
    double? gearOilTemp = 0;
    double? emulOilPr = 0;
    double? quenchCWFlowExit = 0;
    double? castWheelRPM =0;
    double? barTemp ;
    double? quenchCWFlowEntry = 0;
    double? gearOilPr = 0;
    double? standOilPr = 0;
    double? tundishTemp = 0;
    double? rmMotorCoolWater = 0;
    double? rollMillAmps=0;
    double? rmCoolWaterFlow =0;
    double? emulsionLevelAnalo=0;
    double? furnaceTemperature = 0;

    List<Map<String, dynamic>> predictedParameters = [
      {
        'name': 'Emulsion Oil Temp',
        'value': emulOilTemp,
        'range': 25.0,
        'min': 40.0,
        'unit': '°C',
      },
      {
        'name': 'Stand Oil Temp',
        'value': standOilTemp,
        'range': 30.0,
        'min': 39.0,
        'unit': '°C',
      },
      {
        'name': 'Gear Oil Temp',
        'value': gearOilTemp,
        'range': 20.0,
        'min': 49.0,
        'unit': '°C',
      },
      {
        'name': 'Emulsion Oil Pressure',
        'value': emulOilPr,
        'range': 2.0,
        'min': 1.00,
        'unit': 'atm',
      },
      {
        'name': 'Quench CW Flow Exit',
        'value': quenchCWFlowExit,
        'range': 21.0,
        'min': -0.03,
        'unit': 'L/s',
      },
      {
        'name': 'Cast Wheel RPM',
        'value': castWheelRPM,
        'range': 3.0,
        'min': 1.00,
        'unit': 'RPM',
      },
      {
        'name': 'Bar Temp',
        'value': barTemp,
        'range': 500.0,
        'min': 200.0,
        'unit': '°C',
      },
      {
        'name': 'Quench CW Flow Entry',
        'value': quenchCWFlowEntry,
        'range': 500.0,
        'min': -0.1,
        'unit': 'L/s',
      },
      {
        'name': 'Gear Oil Pressure',
        'value': gearOilPr,
        'range': 3.0,
        'min': 1.00,
        'unit': 'atm',
      },
      {
        'name': 'Stands Oil Pressure',
        'value': standOilPr,
        'range': 3.0,
        'min': 1.00,
        'unit': 'atm',
      },
      {
        'name': 'Tundish Temp',
        'value': tundishTemp,
        'range': 1200.0,
        'min': -15.0,
        'unit': '°C',
      },
      {
        'name': 'RM Motor Cool Water',
        'value': rmMotorCoolWater,
        'range': 2.0,
        'min': 0.0,
        'unit': 'L/s',
      },
      {
        'name': 'Roll Mill Amps',
        'value': rollMillAmps,
        'range': 800.0,
        'min': 220.0,
        'unit': 'A',
      },
      {
        'name': 'RM Cool Water Flow',
        'value': rmCoolWaterFlow,
        'range': 50.0,
        'min': 190.0,
        'unit': 'L/s',
      },
      {
        'name': 'Emulsion Level Analo',
        'value': emulsionLevelAnalo,
        'range': 800.0,
        'min': 800.0,
        'unit': '',
      },
      {
        'name': 'Furnance Temp',
        'value': furnaceTemperature,
        'range': 1200.0,
        'min': 345.0,
        'unit': '°C',
      },
    ];
    return Scaffold(
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageRes.letterW,
                  height: screenHeight * 0.1,
                ),
                const Text(
                  "ireSense",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2074f2),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),

          // Editable Parameters Section
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.blueGrey[50],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: editableParameters.map((param) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(param['name']),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  param['icon'],
                                  color: param['color'],
                                  size: 28,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 80,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: param['value'].toString(),
                                    ),
                                    enabled: isEditing,
                                    onChanged: (value) {
                                      param['value'] =
                                          int.tryParse(value) ?? param['value'];
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Red color for Edit button
                      ),
                      onPressed: isEditing
                          ? null
                          : () {
                              setState(() {
                                isEditing = true;
                              });
                            },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green, // Green color for Confirm button
                      ),
                      onPressed: isEditing
                          ? () async {
                            //todo - we will have to again call the api from here
                            // await ref.read(metalProvider.notifier).fetchMetalParameters(uts: editableParameters[2]['value'], conductivity: editableParameters[0]['value'], elongation: editableParameters[1]['value']);
                            //   setState(() {
                            //     isEditing = false;
                            //   });
                            //   updateValues();
                              // Call API here to update server values
                            }
                          : null,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // Predicted Parameters
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3.5,
              ),
              itemCount: predictedParameters.length,
              itemBuilder: (context, index) {
                final param = predictedParameters[index];
                final progress =
                    (param['value'] - param['min']) / param['range'];

                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(param['name']),
                        ),
                        Expanded(
                          flex: 5,
                          child: Stack(
                            children: [
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: progress,
                                child: Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: progress < 0.4
                                        ? Colors.green
                                        : (progress < 0.7
                                            ? Colors.yellow
                                            : Colors.red),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('${param['value']}' '${param['unit']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//16 parameters
