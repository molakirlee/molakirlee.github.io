import sys
import pandas as pd
import numpy as np
from sklearn.metrics import r2_score
from scipy.optimize import least_squares

def process_excel(file_path):
    try:
        # Load data from Excel
        df_A = pd.read_excel(file_path, sheet_name='Sheet1')
        df_b = pd.read_excel(file_path, sheet_name='Sheet2')
        df_x0 = pd.read_excel(file_path, sheet_name='Sheet3')

        # Convert dataframes to numpy arrays
        A = df_A.values  # Assuming A is your independent variables matrix
        b = df_b.values.flatten()  # Assuming b is your dependent variable vector and flatten it to 1D array
        x0 = df_x0.values.flatten()  # Assuming x0 is your initial guess for the solution and flatten it to 1D array

        # Define the objective function for least squares
        def objective_function(x, A, b):
            return np.dot(A, x) - b

        # Set bounds to ensure x >= 0
        bounds = (0, np.inf)

        # Use least_squares to solve the problem with non-negative constraints
        result = least_squares(objective_function, x0, args=(A, b), bounds=bounds)

        # Extract the solution (x)
        x = result.x

        # Calculate the new dependent variable values using the obtained x
        b_calculated = np.dot(A, x)

        # Calculate R2 value
        r2 = r2_score(b, b_calculated)

        # Print the original and calculated dependent variable values (for debugging)
        print("Original dependent variable values (b):\n", b)
        print("\nCalculated dependent variable values (Ax):\n", b_calculated)

        # Print the solution (x) and R2 score (for debugging)
        print("\nSolution (x):\n", x)
        print("\nR2 Score:", r2)

        # Save results to an Excel file (for debugging)
        results_df = pd.DataFrame({
            'Original b': b.flatten(),
            'Calculated b': b_calculated.flatten()
        })

        # Create ExcelWriter object
        with pd.ExcelWriter(file_path + '_results.xlsx') as writer:
            # Write results_df to Sheet1
            results_df.to_excel(writer, sheet_name='Sheet1-Obs-Calc', index=False)

            # Create DataFrame for x and save to Sheet2
            x_df = pd.DataFrame({'Solution (x)': x.flatten()})
            x_df.to_excel(writer, sheet_name='Sheet2-x', index=False)

            # Create DataFrame for r2 and save to Sheet3
            r2_df = pd.DataFrame({'R2 Score': [r2]})
            r2_df.to_excel(writer, sheet_name='Sheet3-R2', index=False)

        # Return the result or any useful information
        return f"Processed {file_path} successfully. Generated {file_path}_results.xlsx"

    except Exception as e:
        return f"Error processing {file_path}: {str(e)}"


if __name__ == "__main__":
    file_path = sys.argv[1]
    result = process_excel(file_path)
    print(result)