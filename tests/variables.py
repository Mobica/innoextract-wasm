import os

home_page_path = 'http://localhost:8000'
browser = 'firefox'

input_test_files_path = f'{os.getcwd()}/src/test_files/'
output_dir = './output/'

TestFiles = {
    'file_4mb': {
         'name': 'file_4MB.exe',
         'archive_size_bytes': 4722512,
         'archive_name': 'smol11',
         'files_in_archive': 2,
         'extraction_time': '60s',
         'path': input_test_files_path + 'file_4MB.exe'
    },
    'file_10k': {
         'name': '10k_files.exe',
         'archive_size_bytes': 42537871,
         'archive_name': '10000 koni wielkości kaczki',
         'files_in_archive': 10001,
         'extraction_time': '180s',
         'path': input_test_files_path + '10k_files.exe'
    },
    'file_4MB-copy': {
         'name': 'file_4MB-copy.exe',
         'archive_size_bytes': 4722512,
         'archive_name': 'smol11',
         'files_in_archive': 2,
         'extraction_time': '60s',
         'path': input_test_files_path + 'file_4MB-copy.exe'
    },
    'test_file_4.exe': {
         'name': 'test_file_4.exe',
         'archive_size_bytes': 78643380,
         'archive_name': 'test_file_4',
         'files_in_archive': 8,
         'extraction_time': '60s',
         'path': input_test_files_path + 'test_file_4.exe'
    }
}

Corrupted_file= {
    'name': 'file_4MB_corrupt.exe',
    'archive_size_bytes': 4722512,
    'archive_name': 'smol11',
    'files_in_archive': 2,
    'extraction_time': '60s',
    'path': input_test_files_path + 'file_4MB_corrupt.exe'
}

test_setup = {
    'name': 'test_setup',
    'archive_size_bytes': 33824,
    'archive_name': 'MyProgramme',
    'files_in_archive': 2,
    'extraction_time': '60s',
    'path': input_test_files_path + 'test_setup.exe'
}

Multi_Part_4MB = {
    'name': 'multi_part_4MB',
    'archive_size_bytes': '4722512',
    'archive_name': 'smol2',
    'files_in_archive': 4,
    'parts': 4,
    'extraction_time': '60s',
    'path': input_test_files_path + 'multi_part_4MB'
}

extraction_filter = {
    'name': 'extraction_filter.exe',
    'archive_size_bytes': 34338,
    'archive_name': 'MyAppName',
    'files_in_archive': 3,
    'extraction_time': '60s',
    'path': input_test_files_path + 'extraction_filter.exe'
}