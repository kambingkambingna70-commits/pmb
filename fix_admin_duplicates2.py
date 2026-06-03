filepath = r'd:\all code\aa\tugasakhir\src\main\java\com\uhn\pmb\controller\AdminController.java'

with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

print(f"File loaded, length: {len(content)}")

# The file now has the stray remnant: '"\n)\n    @PreAuthorize...\n    public ResponseEntity<?> deleteProgramStudi...'
# Let's find and remove the stray fragment + deleteProgramStudi method

# Find the stray fragment left by the previous script
# It should be: '"\n)\n    @PreAuthorize...' right after our new comment block
stray_marker = '     */\n")\n    @PreAuthorize("hasRole(\'ADMIN_PUSAT\')")\n    public ResponseEntity<?> deleteProgramStudi('
idx = content.find(stray_marker)
if idx < 0:
    # try alternate
    stray_marker2 = '*/\n")\n    @PreAuthorize'
    idx = content.find(stray_marker2)
    if idx < 0:
        print("Stray fragment not found, checking file around deleteProgramStudi:")
        idx2 = content.find('deleteProgramStudi')
        if idx2 >= 0:
            print(repr(content[idx2-200:idx2+50]))
        else:
            print("deleteProgramStudi also not found!")
        exit(1)

print(f"Found stray at index {idx}")
print("Context:", repr(content[idx:idx+200]))

# Find start of stray (the stray begins right after the */ of our comment)
comment_end_marker = '     */\n'
comment_end_idx = content.rfind(comment_end_marker, 0, idx + 10)
block_start = comment_end_idx + len(comment_end_marker)
print(f"Stray block starts at {block_start}: {repr(content[block_start:block_start+100])}")

# Now find the end of deleteProgramStudi method by counting braces properly
# Start from the opening { of the method body (after the method signature)
# The method signature is: public ResponseEntity<?> deleteProgramStudi(@PathVariable Long id) {
sig_marker = 'public ResponseEntity<?> deleteProgramStudi(@PathVariable Long id) {'
idx_sig = content.find(sig_marker, block_start)
if idx_sig < 0:
    print("Method signature not found!")
    exit(1)

print(f"Method signature at {idx_sig}")

# Count braces from the opening { of the method body
depth = 0
i = idx_sig + len(sig_marker) - 1  # position of the opening {
while i < len(content):
    c = content[i]
    if c == '{':
        depth += 1
    elif c == '}':
        depth -= 1
        if depth == 0:
            block_end = i + 1
            # consume trailing newline
            while block_end < len(content) and content[block_end] in ('\r', '\n'):
                block_end += 1
            break
    i += 1

print(f"Method ends at {block_end}: {repr(content[block_end:block_end+100])}")

old_block = content[block_start:block_end]
print(f"\nBlock to remove ({len(old_block)} chars):")
print(repr(old_block[:300]))

new_content = content[:block_start] + content[block_end:]

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(new_content)

print(f"\nDone! File written. New length: {len(new_content)}")
print(f"Removed {len(content) - len(new_content)} chars")

# Verify
with open(filepath, 'r', encoding='utf-8') as f:
    verify = f.read()
if 'deleteProgramStudi' in verify:
    print("WARNING: deleteProgramStudi still present!")
else:
    print("OK: deleteProgramStudi removed successfully")
