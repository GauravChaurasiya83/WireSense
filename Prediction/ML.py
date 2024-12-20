import torch
import pandas as pd
df = pd.read_csv('/content/drive/MyDrive/Final_Anomaly_Removed_Data.csv')

def reverse_predict(first_row):
  # Convert first_row to a 2D tensor
  first_row_tensor = torch.tensor(first_row.values, dtype=torch.float32).unsqueeze(0).to(Config.DEVICE)

  # Pass the reshaped tensor to the model
  predictions_output = gen_input(first_row_tensor)

  # Denormalize each column of the tensor
  denormalized_tensor = torch.zeros_like(predictions_output)

  # Apply inverse normalization for each column using the original min/max values
  for i, column in enumerate(predictions_output[0]):
      column_name = other_columns[i]  # Get the column name (assuming df contains the original data)
      min_val = df[column_name].min()  # Get the min value for the column
      max_val = df[column_name].max()  # Get the max value for the column
      # denormalized_tensor[0, i] = inverse_normalize_column(column, min_val, max_val)
      print(f"{column_name}: ", inverse_normalize_column(column, min_val, max_val).item())