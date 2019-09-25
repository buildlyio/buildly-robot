import os


def get_file_path(file):
    """
        return the absolute path of a given file
    """
    absolute_path = os.path.abspath(file)
    return absolute_path
