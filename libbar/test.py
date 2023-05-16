import os
import pefile

dlllib = pefile.PE("bar.dll")
import_table = dlllib.DIRECTORY_ENTRY_IMPORT

for entry in import_table:
    print(entry.dll)
    if entry.dll.decode("utf-8") == "foo.dll":
        print(">>> X", dlllib.get_string_at_rva(entry.struct.Name))
        dlllib.set_bytes_at_rva(entry.struct.Name, b"foo-renamed.dll\0")
dlllib.merge_modified_section_data()

# Aggiorna il campo SizeOfImage nell'header PE
#dlllib.OPTIONAL_HEADER.SizeOfImage = sum(section.Misc_VirtualSize for section in dlllib.sections)

try:
    os.unlink("bar2.dll")
except:
    pass
dlllib.write("bar2.dll")

#print(">> RELOAD")
#dlllib2 = pefile.PE("bar.dll")
#for entry in dlllib2.DIRECTORY_ENTRY_IMPORT:
#    print(entry.dll)
#    if entry.dll.decode("utf-8").startswith("foo"):
#        print('\n'.join(entry.struct.dump()))
#print(dlllib2.dump_info())