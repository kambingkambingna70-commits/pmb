# Read the file
with open('d:\\all code\\aa\\tugasakhir\\src\\main\\resources\\static\\dashboard-admin-validasi.html', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Find the start and end indices
startIdx = -1
endIdx = -1

for i, line in enumerate(lines):
    if 'const reenrollmentId = reenrollRecord.id;' in line:
        startIdx = i
        print(f"Found start at line {i+1}: {line.strip()[:50]}")
    if startIdx >= 0 and '} catch (error) {' in line:
        # Find the closing brace of the catch block
        if i + 3 < len(lines):
            next_lines = lines[i:i+5]
            print(f"Found catch block at line {i+1}")
            for j, nl in enumerate(next_lines):
                print(f"  +{j}: {nl.rstrip()}")
            if lines[i+3].strip() == '}':
                endIdx = i + 3
                break

if startIdx >= 0 and endIdx >= 0:
    # Remove the lines
    new_lines = lines[:startIdx] + lines[endIdx+1:]
    with open('d:\\all code\\aa\\tugasakhir\\src\\main\\resources\\static\\dashboard-admin-validasi.html', 'w', encoding='utf-8') as f:
        f.writelines(new_lines)
    print(f"✅ Removed lines {startIdx+1} to {endIdx+1} ({endIdx-startIdx+1} lines deleted)")
else:
    print(f"❌ Could not find match. startIdx={startIdx+1 if startIdx >= 0 else 'NOT_FOUND'}, endIdx={endIdx+1 if endIdx >= 0 else 'NOT_FOUND'}")
