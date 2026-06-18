import logging
import sys

def setuo_logger(name=__name__,log_file='etl.log',level=logging.DEBUG):
    # 1. Definir el formato estándar para todos los mensajes
    log_format = logging.Formatter(
        '%(asctime)s - %(name)s - [%(levelname)s] - %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    
    # 2. Configurar el manejador para el archivo
    file_handler = logging.FileHandler(f"app/logs/{log_file}", mode='a',encoding='utf-8')
    file_handler.setFormatter(log_format)
    file_handler.setLevel(level)
    
    # 3. Configurar el manejador para la consola (salida estándar)
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(log_format)
    console_handler.setLevel(level)
    
    # 4. Crear el logger específico para el módulo que lo solicita
    logger = logging.getLogger(name)
    logger.setLevel(level)
    
    # Evitar duplicar logs si el logger ya tiene manejadores asignados
    if not logger.handlers:
        logger.addHandler(file_handler)
        logger.addHandler(console_handler)
        
    return logger