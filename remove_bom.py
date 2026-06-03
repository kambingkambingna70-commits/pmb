import sys
file_path = r"d:\all code\aa\tugasakhir\src\main\java\com\uhn\pmb\controller\AdminController.java"
with open(file_path, 'rb') as f:
    data = f.read()
# Remove BOM if present
if data.startswith(b'\xef\xbb\xbf'):
    print("BOM found and removing...")
    data = data[3:]
    with open(file_path, 'wb') as f:
        f.write(data)
    print("BOM removed successfully")
else:
    print("No BOM found")
    print(f"First 10 bytes: {data[:10].hex()}")
