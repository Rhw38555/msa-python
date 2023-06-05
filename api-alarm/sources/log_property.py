import logging.handlers
import os
import pathlib

LOG_FORMAT = '%(asctime)s [%(levelname)5s] %(name)s: %(message)s'

# set 'WARNING' to 'WARN' for readability
logging.addLevelName(30, 'WARN')

def configure_logger(logger, log_path, log_filename=None, log_level=logging.WARN):
    
    logger.setLevel(log_level)
    
    # add Console Handler
    _add_console_handler(logger, log_level)
    
    # add File Handler
    if log_filename:
        _add_file_handler(logger, log_path, log_filename, log_level)
    
    
def _add_console_handler(logger, log_level=logging.INFO):
    handler = logging.StreamHandler()
    handler.setLevel(log_level)
    handler.setFormatter(logging.Formatter(LOG_FORMAT))
    logger.addHandler(handler)


def _add_file_handler(logger, log_path, log_filename, log_level=logging.DEBUG):
    # create log dir
    pathlib.Path(log_path).mkdir(parents=True, exist_ok=True)

    handler = logging.handlers.TimedRotatingFileHandler(
        os.path.join(log_path, log_filename), when='d', interval=1, backupCount=30,
        encoding=None, delay=False, utc=False)
    handler.setLevel(log_level)
    handler.setFormatter(logging.Formatter(LOG_FORMAT))
    logger.addHandler(handler)
