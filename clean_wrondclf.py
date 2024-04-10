import os
import tkinter as tk
from tkinter import filedialog

def delete_subdirectory_contents(directory):
    # Iterate over all files in the specified directory
    for root, dirs, files in os.walk(directory):
        # Delete all files in the current directory
        for file in files:
            file_path = os.path.join(root, file)
            os.remove(file_path)

root = tk.Tk()
root.withdraw() 

# Prompt the user to select a directory
directory_to_clean = filedialog.askdirectory(title="Select a directory to clean")

if directory_to_clean:
    # Call the function to delete the contents of the subdirectories
    delete_subdirectory_contents(directory_to_clean)
    print("Contents of subdirectories cleaned successfully!")
else:
    print("No directory selected.")

root.destroy()