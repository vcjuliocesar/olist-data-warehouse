class EtlError(Exception):
    """Error base del pipeline ETL."""
    def __init__(self, message:str = "Etl error") -> None:
        self.message = message
        super().__init__(self.message)


class ExtractionError(EtlError):
    """Error durante la extracción."""
    pass


class StagingLoadError(EtlError):
    """Error al cargar datos en staging."""
    pass


class TransformationError(EtlError):
    """Error durante una transformación SQL."""
    pass


class DataQualityError(EtlError):
    """Una validación crítica de calidad falló."""
    pass


class ConfigurationError(EtlError):
    """Configuración ausente o inválida."""
    pass