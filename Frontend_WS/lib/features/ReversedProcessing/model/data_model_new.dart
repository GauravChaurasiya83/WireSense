import 'dart:convert';

class MeasurementData {
  String al;
  String fe;
  String si;
  String ti;
  String v;
  String barTemp;
  String castWheelRpm;
  String conductivity;
  String emulsionLevel;
  String emulOilPr;
  String emulOilTemp;
  String elongation;
  String furnaceTemp;
  String gearOilPr;
  String gearOilTemp;
  String quenchFlowEntry;
  String quenchFlowExit;
  String rmCoolWaterFlow;
  String rmMotorCoolWater;
  String rollMillAmps;
  String standsOilPr;
  String standOilTemp;
  String tundishTemp;
  String uts;

  MeasurementData({
    required this.al,
    required this.fe,
    required this.si,
    required this.ti,
    required this.v,
    required this.barTemp,
    required this.castWheelRpm,
    required this.conductivity,
    required this.emulsionLevel,
    required this.emulOilPr,
    required this.emulOilTemp,
    required this.elongation,
    required this.furnaceTemp,
    required this.gearOilPr,
    required this.gearOilTemp,
    required this.quenchFlowEntry,
    required this.quenchFlowExit,
    required this.rmCoolWaterFlow,
    required this.rmMotorCoolWater,
    required this.rollMillAmps,
    required this.standsOilPr,
    required this.standOilTemp,
    required this.tundishTemp,
    required this.uts,
  });

  // From JSON (Deserialization)
  factory MeasurementData.fromJson(Map<String, dynamic> json) {
    return MeasurementData(
      al: json['%AL'] ?? '',
      fe: json['%FE'] ?? '',
      si: json['%SI'] ?? '',
      ti: json['%TI'] ?? '',
      v: json['%V'] ?? '',
      barTemp: json['BAR_TEMP_VAL0'] ?? '',
      castWheelRpm: json['CAST_WHEEL_RPM_VAL0'] ?? '',
      conductivity: json['Conductivity'] ?? '',
      emulsionLevel: json['EMULSION_LEVEL_ANALO_VAL0'] ?? '',
      emulOilPr: json['EMUL_OIL_L_PR_VAL0'] ?? '',
      emulOilTemp: json['EMUL_OIL_L_TEMP_PV_VAL0'] ?? '',
      elongation: json['Elongation'] ?? '',
      furnaceTemp: json['Furnace_Temperature'] ?? '',
      gearOilPr: json['GEAR_OIL_L_PR_VAL0'] ?? '',
      gearOilTemp: json['GEAR_OIL_L_TEMP_PV_REAL_VAL0'] ?? '',
      quenchFlowEntry: json['QUENCH_CW_FLOW_ENTRY_VAL0'] ?? '',
      quenchFlowExit: json['QUENCH_CW_FLOW_EXIT_VAL0'] ?? '',
      rmCoolWaterFlow: json['RM_COOL_WATER_FLOW_VAL0'] ?? '',
      rmMotorCoolWater: json['RM_MOTOR_COOL_WATER__VAL0'] ?? '',
      rollMillAmps: json['ROLL_MILL_AMPS_VAL0'] ?? '',
      standsOilPr: json['STANDS_OIL_L_PR_VAL0'] ?? '',
      standOilTemp: json['STAND_OIL_L_TEMP_PV_REAL_VAL0'] ?? '',
      tundishTemp: json['TUNDISH_TEMP_VAL0'] ?? '',
      uts: json['UTS'] ?? '',
    );
  }

  // To JSON (Serialization)
  Map<String, dynamic> toJson() {
    return {
      '%AL': al,
      '%FE': fe,
      '%SI': si,
      '%TI': ti,
      '%V': v,
      'BAR_TEMP_VAL0': barTemp,
      'CAST_WHEEL_RPM_VAL0': castWheelRpm,
      'Conductivity': conductivity,
      'EMULSION_LEVEL_ANALO_VAL0': emulsionLevel,
      'EMUL_OIL_L_PR_VAL0': emulOilPr,
      'EMUL_OIL_L_TEMP_PV_VAL0': emulOilTemp,
      'Elongation': elongation,
      'Furnace_Temperature': furnaceTemp,
      'GEAR_OIL_L_PR_VAL0': gearOilPr,
      'GEAR_OIL_L_TEMP_PV_REAL_VAL0': gearOilTemp,
      'QUENCH_CW_FLOW_ENTRY_VAL0': quenchFlowEntry,
      'QUENCH_CW_FLOW_EXIT_VAL0': quenchFlowExit,
      'RM_COOL_WATER_FLOW_VAL0': rmCoolWaterFlow,
      'RM_MOTOR_COOL_WATER__VAL0': rmMotorCoolWater,
      'ROLL_MILL_AMPS_VAL0': rollMillAmps,
      'STANDS_OIL_L_PR_VAL0': standsOilPr,
      'STAND_OIL_L_TEMP_PV_REAL_VAL0': standOilTemp,
      'TUNDISH_TEMP_VAL0': tundishTemp,
      'UTS': uts,
    };
  }
}
