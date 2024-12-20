import numpy as np
import pandas as pd
import pickle
import json

def optimize_parameters(target_index, initial_output, final_output, input_parameters_json, model_paths, min_max_values):
    """
    Optimize input parameters to achieve a target output for a given model.

    Args:
        target_index (int): The target property index (0: UTS, 1: Elongation, 2: Conductivity).
        initial_output (float): The initial output value.
        final_output (float): The desired final output value.
        input_parameters_json (str): JSON string containing 16 input parameters with their values.
        model_paths (dict): Dictionary containing paths to the models.
        min_max_values (dict): Dictionary containing min and max values for normalization of all parameters.

    Returns:
        str: JSON string containing the optimized input parameters.
    """
    # Map target index to property name
    # target_index = input_parameters_json['variable']
    # initial_output = input_parameters_json['old_value']
    # final_output = input_parameters_json['new_value']

    # input_parameters_json = input_parameters_json['values']
    target_map = {0: '   UTS', 1: 'Elongation', 2: 'Conductivity'}
    target = target_map[target_index]

    # Parse input parameters
    input_parameters = json.loads(input_parameters_json)
    X_instance = pd.Series(input_parameters)

    # Normalize function
    def normalize_column(value, min_val, max_val):
        return (value - min_val) / (max_val - min_val)

    def inverse_normalize_column(norm_value, min_val, max_val):
        return norm_value * (max_val - min_val) + min_val

    # Normalize input parameters
    for feature in X_instance.index:
        min_val, max_val = min_max_values[feature]
        X_instance[feature] = normalize_column(X_instance[feature], min_val, max_val)

    # Load the model based on the target
    def load_model(path):
        with open(path, 'rb') as f:
            return pickle.load(f)

    model = load_model(model_paths[target])

    # Normalize target outputs
    target_min, target_max = min_max_values[target]
    initial_output_norm = normalize_column(initial_output, target_min, target_max)
    final_output_norm = normalize_column(final_output, target_min, target_max)

    # Gradient Descent Optimization
    def gradient_descent_optimize_all_features(model, X_instance, target_output, features_to_optimize,
                                               learning_rate=0.01, max_iter=300, tolerance=0.001):
        current_instance = X_instance.copy()

        for iteration in range(max_iter):
            current_output = model_predict(model, current_instance)[0]
            error = target_output - current_output

            if abs(error) <= tolerance:
                break

            gradients = {}

            for feature in features_to_optimize:
                perturbed_instance_plus = current_instance.copy()
                perturbed_instance_minus = current_instance.copy()

                perturbed_instance_plus[feature] += 0.1
                perturbed_instance_minus[feature] -= 0.1

                perturbed_output_plus = model_predict(model, perturbed_instance_plus)[0]
                perturbed_output_minus = model_predict(model, perturbed_instance_minus)[0]

                gradient = (perturbed_output_plus - perturbed_output_minus) / 0.2
                gradients[feature] = gradient

            for feature, gradient in gradients.items():
                current_instance[feature] += learning_rate * gradient * error
                current_instance[feature] = np.clip(current_instance[feature], 0, 1)

        return current_instance

    # Predict function
    def model_predict(model, X):
        if isinstance(X, pd.Series):
            X = X.values.reshape(1, -1)
        elif isinstance(X, pd.DataFrame):
            X = X.to_numpy()
        return model.predict(X)

    # Features to optimize (select 3 from input parameters)
    top_features_global = [
        ['STANDS_OIL_L_PR_VAL0', 'QUENCH_CW_FLOW_EXIT_VAL0', 'QUENCH_CW_FLOW_ENTRY_VAL0'],
        ['STANDS_OIL_L_PR_VAL0', 'QUENCH_CW_FLOW_EXIT_VAL0', 'QUENCH_CW_FLOW_ENTRY_VAL0'],
        ['STANDS_OIL_L_PR_VAL0', 'QUENCH_CW_FLOW_EXIT_VAL0', 'EMULSION_LEVEL_ANALO_VAL0']
    ]
    
    top_features = top_features_global[target_index]
    
    # Optimize parameters
    optimized_instance = gradient_descent_optimize_all_features(
        model,
        X_instance=X_instance,
        target_output=final_output_norm,
        features_to_optimize=top_features
    )

    # Convert optimized parameters back to original scale
    optimized_parameters = optimized_instance.copy()
    for feature in optimized_parameters.index:
        feature_min, feature_max = min_max_values[feature]
        optimized_parameters[feature] = inverse_normalize_column(optimized_parameters[feature], feature_min, feature_max)

    # Return updated parameters as JSON
    return json.dumps(optimized_parameters.to_dict())

# Example usage
model_paths = {
    'Conductivity': '/kaggle/input/models/keras/default/1/xgboost_model_output_Conductivity.pkl',
    'Elongation': '/kaggle/input/models/keras/default/1/xgboost_model_output_Elongation.pkl',
    '   UTS': '/kaggle/input/models/keras/default/1/xgboost_model_output_   UTS.pkl'
}

# Initialize min_max_values as a dictionary instead of a list
min_max_values = {}

# Load data and calculate min-max values for normalization
df = pd.read_csv('D:/SIH_Project/Project/Prediction/suggestion_predicted_df.csv')
df_input = df[['EMUL_OIL_L_TEMP_PV_VAL0', 'STAND_OIL_L_TEMP_PV_REAL_VAL0',
       'GEAR_OIL_L_TEMP_PV_REAL_VAL0', 'EMUL_OIL_L_PR_VAL0',
       'QUENCH_CW_FLOW_EXIT_VAL0', 'CAST_WHEEL_RPM_VAL0', 'BAR_TEMP_VAL0',
       'QUENCH_CW_FLOW_ENTRY_VAL0', 'GEAR_OIL_L_PR_VAL0',
       'STANDS_OIL_L_PR_VAL0', 'TUNDISH_TEMP_VAL0',
       'RM_MOTOR_COOL_WATER__VAL0', 'ROLL_MILL_AMPS_VAL0',
       'RM_COOL_WATER_FLOW_VAL0', 'EMULSION_LEVEL_ANALO_VAL0','Furnace_Temperature']]

for cols in df.columns:
    min_v = df[cols].min()
    max_v = df[cols].max()
    min_max_values[cols] = [min_v,max_v]  # Store as a dictionary

# Note: Ensure that you provide appropriate values for target_index, initial_output, final_output, and input_parameters_json when calling optimize_parameters.