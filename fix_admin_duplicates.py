import re

filepath = r'd:\all code\aa\tugasakhir\src\main\java\com\uhn\pmb\controller\AdminController.java'

with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

print(f"File loaded, length: {len(content)}")

# Find the getProgramStudiById method and surrounding duplicate block
idx_start = content.find('@GetMapping("/program-studi/{id}")')
if idx_start < 0:
    print("ERROR: @GetMapping('/program-studi/{id}') NOT FOUND")
    exit(1)

print(f"Found @GetMapping('/program-studi/{{id}}') at index {idx_start}")
print("Context before:", repr(content[idx_start-300:idx_start]))

# Find the section comment before it  
comment_marker = '==================== JENIS SELEKSI ENDPOINTS ===================='
idx_comment = content.rfind(comment_marker, 0, idx_start)
if idx_comment < 0:
    print("Comment marker not found, using method start directly")
    # find the /** before the method
    block_start = content.rfind('    /**', 0, idx_start)
else:
    # Go back to the /** that starts this comment
    block_start = content.rfind('    /**', 0, idx_comment)

print(f"Block start at index {block_start}: {repr(content[block_start:block_start+50])}")

# Find end of deleteProgramStudi method - look for closing brace after deleteProgramStudi
idx_delete = content.find('@DeleteMapping("/program-studi/{id}")')
if idx_delete < 0:
    print("ERROR: @DeleteMapping('/program-studi/{id}') NOT FOUND")
    exit(1)

# Find the closing brace of deleteProgramStudi
# After the method signature, find the next top-level closing brace sequence "    }\n\n"
idx_after_delete = idx_delete
# Find the method body end: look for '    }\n' followed by either blank line or next section
depth = 0
in_method = False
i = idx_delete
while i < len(content):
    c = content[i]
    if c == '{':
        depth += 1
        in_method = True
    elif c == '}':
        depth -= 1
        if in_method and depth == 0:
            block_end = i + 1
            # consume trailing newlines
            while block_end < len(content) and content[block_end] in ('\r', '\n'):
                block_end += 1
            break
    i += 1

print(f"Block end at index {block_end}: {repr(content[block_end:block_end+100])}")

old_block = content[block_start:block_end]
print(f"\nBlock to remove ({len(old_block)} chars):")
print("--- START ---")
print(old_block[:200])
print("...")
print(old_block[-200:])
print("--- END ---")

replacement = '''    /**
     * ==================== JENIS SELEKSI - PROGRAM STUDI RELATIONSHIP ====================
     * NOTE: GET /PUT/DELETE /admin/program-studi/{id} dipindahkan ke AdminProgramStudiController
     */\n'''

new_content = content[:block_start] + replacement + content[block_end:]

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(new_content)

print(f"\nDone! File written. New length: {len(new_content)}")
print(f"Removed {len(content) - len(new_content)} chars")
