*** Settings ***
Documentation       Test files data

Variables           variables.py


*** Variables ***
&{file_4mb}  name=file_4MB.exe  path=${input_test_files_path}file_4MB.exe  archive_size_bytes=${4722512}  archive_name=smol11  files_in_archive=2
&{10k_files}  name=10k_files.exe  path=${input_test_files_path}10k_files.exe  archive_size_bytes=${42537871}  archive_name=10000 koni wielkości kaczki  files_in_archive=10001
&{multi_part_4mb}  name=multi_part_4MB  path=${input_test_files_path}multi_part_4MB  archive_size_bytes=${4722512}  archive_name=smol2  files_in_archive=2  parts=4      
