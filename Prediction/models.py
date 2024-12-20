from django.db import models
from django.contrib.auth.hashers import make_password


class Prediction(models.Model):
    EMUL_OIL_L_TEMP_PV_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    STAND_OIL_L_TEMP_PV_REAL_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    GEAR_OIL_L_TEMP_PV_REAL_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    EMUL_OIL_L_PR_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    QUENCH_CW_FLOW_EXIT_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    CAST_WHEEL_RPM_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    BAR_TEMP_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    QUENCH_CW_FLOW_ENTRY_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    GEAR_OIL_L_PR_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    STANDS_OIL_L_PR_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    TUNDISH_TEMP_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    FURNACE_TEMPERATURE = models.DecimalField(max_digits=25, decimal_places=20)
    RM_MOTOR_COOL_WATER_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    ROLL_MILL_AMPS_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    RM_COOL_WATER_FLOW_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    EMULSION_LEVEL_ANALO_VAL0 = models.DecimalField(max_digits=25, decimal_places=20)
    UTS = models.DecimalField(max_digits=25, decimal_places=20,default=0)
    Elongation = models.DecimalField(max_digits=25, decimal_places=20,default=0)
    Conductivity = models.DecimalField(max_digits=25, decimal_places=20,default=0)
    Percent_SI = models.DecimalField(max_digits=25, decimal_places=20,default=0.001)
    Percent_FE = models.DecimalField(max_digits=25, decimal_places=20,default=0.001)
    Percent_TI = models.DecimalField(max_digits=25, decimal_places=20,default=0.001)
    Percent_V = models.DecimalField(max_digits=25, decimal_places=20,default=0.001)
    Percent_AL = models.DecimalField(max_digits=25, decimal_places=20,default=0.001)
    


class Employee(models.Model):
    employee_id = models.CharField(max_length=100, primary_key=True)
    password = models.CharField(max_length=100)

    def __str__(self):
        return self.employee_id
