--==============================================================================
-- ⚙️ PROGRAMACIÓN DE OBJETOS: PROCEDIMIENTOS ALMACENADOS
-- Autora: Angie Henriquez
--==============================================================================

DELIMITER //

CREATE PROCEDURE AgregarDepartamento(
    IN _nombre VARCHAR(255), 
    IN _ubicacion VARCHAR(255)
)
BEGIN
    -- Automatiza la inserción segura de nuevos departamentos administrativos
    INSERT INTO Departamentos (nombre, ubicacion) 
    VALUES (_nombre, _ubicacion);
END //

DELIMITER ;
