f = r'd:\all code\aa\Latex-TA-IF-ITERA-main\DIAGRAM-MISMATCH-REPORT.md'
with open(f, encoding='utf-8') as fh:
    content = fh.read()

d3_start = content.find('## D3.')
# Find the @enduml then closing ``` for D3
enduml_pos = content.find('@enduml', d3_start)
close_pos = content.find('```', enduml_pos) + 3
print('D3 start:', d3_start, 'close:', close_pos)
print('Old D3 header:', repr(content[d3_start:d3_start+100]))
print('Old D3 end:', repr(content[enduml_pos:close_pos+10]))
