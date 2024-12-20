from rest_framework import serializers
from .models import Prediction
from rest_framework import serializers

class EmployeeLoginSerializer(serializers.Serializer):
    employee_id = serializers.CharField(max_length=50)
    password = serializers.CharField(max_length=255, write_only=True)


class PredictionSerializer(serializers.ModelSerializer):
    EMUL_OIL_L_TEMP_PV_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    STAND_OIL_L_TEMP_PV_REAL_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    GEAR_OIL_L_TEMP_PV_REAL_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    EMUL_OIL_L_PR_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    QUENCH_CW_FLOW_EXIT_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    CAST_WHEEL_RPM_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    BAR_TEMP_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    QUENCH_CW_FLOW_ENTRY_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    GEAR_OIL_L_PR_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    STANDS_OIL_L_PR_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    TUNDISH_TEMP_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    FURNACE_TEMPERATURE = serializers.DecimalField(max_digits=25, decimal_places=20)
    RM_MOTOR_COOL_WATER_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    ROLL_MILL_AMPS_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    RM_COOL_WATER_FLOW_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    EMULSION_LEVEL_ANALO_VAL0 = serializers.DecimalField(max_digits=25, decimal_places=20)
    UTS = serializers.DecimalField(max_digits=25, decimal_places=20,default=0)
    Elongation = serializers.DecimalField(max_digits=25, decimal_places=20,default=0)
    Conductivity = serializers.DecimalField(max_digits=25, decimal_places=20,default=0)
    Percent_SI = serializers.DecimalField(max_digits=25, decimal_places=20)
    Percent_FE = serializers.DecimalField(max_digits=25, decimal_places=20)
    Percent_TI = serializers.DecimalField(max_digits=25, decimal_places=20)
    Percent_V = serializers.DecimalField(max_digits=25, decimal_places=20)
    Percent_AL = serializers.DecimalField(max_digits=25, decimal_places=20)

    class Meta:
        model = Prediction
        fields = [
            'EMUL_OIL_L_TEMP_PV_VAL0',
            'STAND_OIL_L_TEMP_PV_REAL_VAL0',
            'GEAR_OIL_L_TEMP_PV_REAL_VAL0',
            'EMUL_OIL_L_PR_VAL0',
            'QUENCH_CW_FLOW_EXIT_VAL0',
            'CAST_WHEEL_RPM_VAL0',
            'BAR_TEMP_VAL0',
            'QUENCH_CW_FLOW_ENTRY_VAL0',
            'GEAR_OIL_L_PR_VAL0',
            'STANDS_OIL_L_PR_VAL0',
            'TUNDISH_TEMP_VAL0',
            'FURNACE_TEMPERATURE',
            'RM_MOTOR_COOL_WATER_VAL0',
            'ROLL_MILL_AMPS_VAL0',
            'RM_COOL_WATER_FLOW_VAL0',
            'EMULSION_LEVEL_ANALO_VAL0',
            'UTS',
            'Elongation',
            'Conductivity',
            'Percent_SI',
            'Percent_FE',
            'Percent_TI',
            'Percent_V',
            'Percent_AL',
        ]
