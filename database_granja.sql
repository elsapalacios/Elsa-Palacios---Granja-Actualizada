-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-06-2025 a las 04:57:40
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `granja`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alertas`
--

CREATE TABLE `alertas` (
  `id_alerta` int(11) NOT NULL,
  `categoria` varchar(20) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
PARTITION BY LIST COLUMNS(`categoria`)
(
PARTITION p_animal VALUES IN ('animal') ENGINE=InnoDB,
PARTITION p_planta VALUES IN ('planta') ENGINE=InnoDB,
PARTITION p_venta VALUES IN ('venta') ENGINE=InnoDB,
PARTITION p_empleado VALUES IN ('empleado') ENGINE=InnoDB,
PARTITION p_usuario VALUES IN ('usuario') ENGINE=InnoDB,
PARTITION p_inventario VALUES IN ('inventario') ENGINE=InnoDB,
PARTITION p_inicio_sesion VALUES IN ('inicio_sesion') ENGINE=InnoDB,
PARTITION p_salud VALUES IN ('salud') ENGINE=InnoDB,
PARTITION p_vacunas VALUES IN ('vacunas') ENGINE=InnoDB,
PARTITION p_vacunacion VALUES IN ('vacunacion') ENGINE=InnoDB,
PARTITION p_otro VALUES IN ('otro') ENGINE=InnoDB
);

--
-- Volcado de datos para la tabla `alertas`
--

INSERT INTO `alertas` (`id_alerta`, `categoria`, `mensaje`, `fecha`) VALUES
(1, 'animal', 'Nuevo animal registrado: Vaca Holstein (ID: 5). Especie: Ganado. Estado: Sano.', '2025-05-01 08:00:00'),
(2, 'planta', 'Nueva planta registrada: Maíz (ID: 3). Ubicación: Campo Norte. Estado: Sano.', '2025-05-01 08:15:00'),
(3, 'venta', 'Nueva venta registrada: $120000.00 por 50.00 de Leche. Comprador: Lácteos del Valle.', '2025-05-02 09:30:00'),
(4, 'empleado', 'Nuevo empleado registrado: Carlos Méndez. Cargo: Veterinario. Salario: $3800000.00.', '2025-05-02 10:45:00'),
(5, 'usuario', 'Nuevo usuario registrado: Ana López. Tipo: Administrador. Correo: ana.lopez@email.com.', '2025-05-03 11:20:00'),
(6, 'inventario', 'Nuevo producto en inventario: Antibióticos para bovinos. Cantidad: 50.00 Dósis. Proveedor: FarmAnimal.', '2025-05-03 14:00:00'),
(7, 'salud', 'El estado de salud ha cambiado para el ID 5 de Sano a Enfermo.', '2025-05-04 08:30:00'),
(8, 'vacunas', 'Alerta: La vacuna Fiebre Aftosa está baja en stock (4 restantes).', '2025-05-04 10:15:00'),
(9, 'vacunacion', 'Recordatorio: El animal con ID 5 debe recibir la vacuna 1 el 2025-11-01.', '2025-05-04 14:45:00'),
(10, 'animal', 'Cambio de estado en animal ID 5: Enfermo → Recuperación. Nombre: Vaca Holstein.', '2025-05-05 09:00:00'),
(11, 'planta', 'Cambio de estado en planta ID 3: Sano → Enfermo. Nombre: Maíz.', '2025-05-05 11:30:00'),
(12, 'inventario', 'Producto con bajo stock: "Huevos orgánicos" (ID: 14) - Cantidad restante: 3 - Categoría: Huevos - Precio: $15000.00 COP', '2025-05-06 10:00:00'),
(13, 'venta', 'Nuevo pedido #1 - Cliente: María González (maria.gonzalez@email.com) - Productos: Leche entera (5 x $3500.00), Queso fresco (2 x $12000.00) - Total: $41500.00 COP - Método de pago: tarjeta', '2025-05-06 15:20:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alimentacion`
--

CREATE TABLE `alimentacion` (
  `id_alimentacion` int(11) NOT NULL,
  `id_especie` int(11) NOT NULL,
  `tipo_alimento` varchar(100) NOT NULL,
  `comidas_por_dia` int(11) NOT NULL,
  `cantidad_gramos` decimal(10,2) NOT NULL,
  `fecha_ultima_alimentacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alimentacion`
--

INSERT INTO `alimentacion` (`id_alimentacion`, `id_especie`, `tipo_alimento`, `comidas_por_dia`, `cantidad_gramos`, `fecha_ultima_alimentacion`) VALUES
(1, 1, 'Maíz molido', 2, 60.00, '2025-05-01'),
(2, 1, 'Sorgo', 2, 50.00, '2025-05-02'),
(3, 2, 'Pasto fresco', 3, 120.00, '2025-05-01'),
(4, 2, 'Heno de alfalfa', 2, 90.00, '2025-05-03'),
(5, 3, 'Balanceado para peces', 2, 40.00, '2025-05-02'),
(6, 4, 'Maíz entero', 3, 80.00, '2025-05-03'),
(7, 4, 'Soya', 2, 70.00, '2025-05-01'),
(8, 1, 'Trigo', 2, 55.00, '2025-05-04'),
(9, 2, 'Pasto seco', 3, 110.00, '2025-05-04'),
(10, 3, 'Algas', 2, 30.00, '2025-05-03'),
(11, 4, 'Harina de pescado', 3, 75.00, '2025-05-02'),
(12, 1, 'Avena', 2, 45.00, '2025-05-05'),
(13, 2, 'Pasto de corte', 3, 100.00, '2025-05-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `animales`
--

CREATE TABLE `animales` (
  `id_animal` int(11) NOT NULL,
  `id_especie` int(11) NOT NULL,
  `nombre_cientifico` varchar(100) NOT NULL,
  `nombre_comun` varchar(100) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `estado` enum('Sano','Enfermo','Recuperación') DEFAULT 'Sano',
  `descripcion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `animales`
--

INSERT INTO `animales` (`id_animal`, `id_especie`, `nombre_cientifico`, `nombre_comun`, `edad`, `ubicacion`, `estado`, `descripcion`, `fecha_registro`) VALUES
(1, 1, 'Gallus gallus domesticus', 'Gallina Rhode Island', 2, 'Galpón A', 'Sano', 'Gallina ponedora de huevos marrones', '2025-04-15 08:00:00'),
(2, 1, 'Gallus gallus domesticus', 'Gallina Leghorn', 1, 'Galpón B', 'Sano', 'Gallina ponedora de huevos blancos', '2025-04-16 09:15:00'),
(3, 2, 'Bos taurus', 'Vaca Holstein', 4, 'Establo 1', 'Recuperación', 'Vaca lechera en producción', '2025-04-17 10:30:00'),
(4, 2, 'Bos taurus', 'Toro Angus', 3, 'Establo 2', 'Sano', 'Toro para reproducción', '2025-04-18 11:45:00'),
(5, 3, 'Oreochromis niloticus', 'Tilapia del Nilo', 2, 'Estanque 1', 'Sano', 'Peces en etapa de crecimiento', '2025-04-19 13:00:00'),
(6, 4, 'Sus scrofa domesticus', 'Cerdo Yorkshire', 1, 'Corral 1', 'Sano', 'Cerdo en etapa de engorde', '2025-04-20 14:15:00'),
(7, 4, 'Sus scrofa domesticus', 'Cerda Landrace', 2, 'Corral 2', 'Sano', 'Cerda reproductora', '2025-04-21 15:30:00'),
(8, 1, 'Gallus gallus domesticus', 'Gallo Plymouth Rock', 3, 'Galpón C', 'Sano', 'Gallo para reproducción', '2025-04-22 16:45:00'),
(9, 2, 'Bos taurus', 'Vaca Jersey', 5, 'Establo 3', 'Sano', 'Vaca lechera alta producción', '2025-04-23 18:00:00'),
(10, 3, 'Pangasius hypophthalmus', 'Bagre vietnamita', 1, 'Estanque 2', 'Sano', 'Peces en etapa inicial', '2025-04-24 19:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bloqueo_usuarios`
--

CREATE TABLE `bloqueo_usuarios` (
  `id_bloqueo` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `intentos_fallidos` int(11) NOT NULL DEFAULT 0,
  `bloqueado_desde` datetime DEFAULT NULL,
  `bloqueado_hasta` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bloqueo_usuarios`
--

INSERT INTO `bloqueo_usuarios` (`id_bloqueo`, `id_usuario`, `intentos_fallidos`, `bloqueado_desde`, `bloqueado_hasta`) VALUES
(1, 3, 0, NULL, NULL),
(2, 5, 2, NULL, NULL),
(3, 7, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito_compras`
--

CREATE TABLE `carrito_compras` (
  `id_item` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `fecha_agregado` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito_compras`
--

INSERT INTO `carrito_compras` (`id_item`, `id_cliente`, `id_producto`, `cantidad`, `fecha_agregado`) VALUES
(1, 1, 3, 2, '2025-05-06 14:30:00'),
(2, 1, 7, 1, '2025-05-06 14:32:00'),
(3, 2, 5, 3, '2025-05-06 15:45:00'),
(4, 3, 2, 4, '2025-05-06 16:20:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `email`, `telefono`, `direccion`, `password`, `fecha_registro`) VALUES
(1, 'María González', 'maria.gonzalez@email.com', '3101234567', 'Calle 123 #45-67, Bogotá', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a', '2025-04-25 10:00:00'),
(2, 'Carlos Rodríguez', 'carlos.rodriguez@email.com', '3202345678', 'Carrera 56 #78-90, Medellín', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a', '2025-04-26 11:15:00'),
(3, 'Ana Martínez', 'ana.martinez@email.com', '3153456789', 'Avenida 12 #34-56, Cali', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a', '2025-04-27 12:30:00'),
(4, 'Luis Sánchez', 'luis.sanchez@email.com', '3184567890', 'Diagonal 78 #90-12, Barranquilla', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a', '2025-04-28 13:45:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `costos`
--

CREATE TABLE `costos` (
  `id_costo` int(11) NOT NULL,
  `tipo_costo` enum('Alimentación','Salud','Mantenimiento','Salarios','Otro') NOT NULL,
  `descripcion` text NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha` date NOT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `id_especie` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `costos`
--

INSERT INTO `costos` (`id_costo`, `tipo_costo`, `descripcion`, `monto`, `fecha`, `id_empleado`, `id_animal`, `id_especie`) VALUES
(1, 'Alimentación', 'Compra de maíz para gallinas', 500000.00, '2025-04-01', NULL, NULL, 1),
(2, 'Salud', 'Vacunas para ganado', 1200000.00, '2025-04-05', 1, NULL, 2),
(3, 'Mantenimiento', 'Reparación de cercas', 850000.00, '2025-04-10', NULL, NULL, NULL),
(4, 'Salarios', 'Pago de nómina abril', 15000000.00, '2025-04-15', NULL, NULL, NULL),
(5, 'Otro', 'Compra de herramientas', 350000.00, '2025-04-20', NULL, NULL, NULL),
(6, 'Alimentación', 'Compra de balanceado para cerdos', 750000.00, '2025-04-25', NULL, NULL, 4),
(7, 'Salud', 'Tratamiento para tilapias', 450000.00, '2025-04-28', 2, 5, NULL),
(8, 'Mantenimiento', 'Reparación de sistema de riego', 600000.00, '2025-05-01', NULL, NULL, NULL),
(9, 'Salarios', 'Pago de horas extras', 2500000.00, '2025-05-05', NULL, NULL, NULL),
(10, 'Otro', 'Compra de uniformes', 280000.00, '2025-05-06', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_pedido`
--

CREATE TABLE `detalles_pedido` (
  `id_detalle` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_pedido`
--

INSERT INTO `detalles_pedido` (`id_detalle`, `id_pedido`, `id_producto`, `cantidad`, `precio_unitario`) VALUES
(1, 1, 2, 5, 3500.00),
(2, 1, 7, 2, 12000.00),
(3, 2, 3, 1, 25000.00),
(4, 3, 5, 3, 5000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_contratacion` date NOT NULL,
  `salario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id_empleado`, `nombre`, `rol`, `telefono`, `fecha_contratacion`, `salario`) VALUES
(1, 'Carlos Méndez', 'Veterinario', '3101112233', '2024-01-15', 3800000.00),
(2, 'Laura Gómez', 'Administradora', '3112223344', '2023-05-20', 4500000.00),
(3, 'Pedro Ramírez', 'Encargado de ganado', '3123334455', '2024-03-10', 2800000.00),
(4, 'Ana López', 'Encargada de aves', '3134445566', '2023-11-05', 2700000.00),
(5, 'Jorge Castro', 'Encargado de piscicultura', '3145556677', '2024-02-15', 2900000.00),
(6, 'Sofía Ruiz', 'Encargada de porcicultura', '3156667788', '2023-09-12', 2750000.00),
(7, 'Miguel Ángel Torres', 'Técnico agrícola', '3167778899', '2024-01-20', 3200000.00),
(8, 'Diana García', 'Asistente administrativa', '3178889900', '2023-07-08', 2500000.00),
(9, 'Fernando Herrera', 'Mantenimiento', '3189990011', '2024-04-01', 2600000.00),
(10, 'Patricia Vargas', 'Supervisora de producción', '3190001122', '2023-12-15', 4000000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especies`
--

CREATE TABLE `especies` (
  `id_especie` int(11) NOT NULL,
  `nombre_especie` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especies`
--

INSERT INTO `especies` (`id_especie`, `nombre_especie`, `descripcion`) VALUES
(1, 'Aves de corral', 'Gallinas, pollos y otras aves de granja'),
(2, 'Ganado bovino', 'Vacas, toros y bueyes'),
(3, 'Peces', 'Especies acuícolas para consumo'),
(4, 'Porcinos', 'Cerdos para producción de carne');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_estado_salud`
--

CREATE TABLE `historial_estado_salud` (
  `id_historial` int(11) NOT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `id_planta` int(11) DEFAULT NULL,
  `estado_anterior` enum('Sano','Enfermo','Recuperación') NOT NULL,
  `estado_nuevo` enum('Sano','Enfermo','Recuperación') NOT NULL,
  `fecha_cambio` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_estado_salud`
--

INSERT INTO `historial_estado_salud` (`id_historial`, `id_animal`, `id_planta`, `estado_anterior`, `estado_nuevo`, `fecha_cambio`) VALUES
(1, 3, NULL, 'Sano', 'Enfermo', '2025-04-20 08:00:00'),
(2, 3, NULL, 'Enfermo', 'Recuperación', '2025-04-25 09:15:00'),
(3, NULL, 3, 'Sano', 'Enfermo', '2025-04-22 10:30:00'),
(4, 5, NULL, 'Sano', 'Enfermo', '2025-04-23 11:45:00'),
(5, 5, NULL, 'Enfermo', 'Recuperación', '2025-04-28 13:00:00'),
(6, NULL, 5, 'Enfermo', 'Sano', '2025-04-26 14:15:00'),
(7, 7, NULL, 'Sano', 'Enfermo', '2025-04-27 15:30:00'),
(8, 7, NULL, 'Enfermo', 'Recuperación', '2025-05-01 16:45:00'),
(9, NULL, 7, 'Sano', 'Enfermo', '2025-04-29 18:00:00'),
(10, NULL, 7, 'Enfermo', 'Recuperación', '2025-05-03 19:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(100) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `unidad_medida` varchar(20) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `id_proveedor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_producto`, `nombre_producto`, `cantidad`, `unidad_medida`, `fecha_ingreso`, `id_proveedor`) VALUES
(1, 'Maíz amarillo', 500.00, 'kg', '2025-04-01', 1),
(2, 'Heno de alfalfa', 300.00, 'kg', '2025-04-05', 2),
(3, 'Balanceado para aves', 400.00, 'kg', '2025-04-10', 1),
(4, 'Vacuna aftosa', 50.00, 'dosis', '2025-04-15', 3),
(5, 'Antibióticos para bovinos', 30.00, 'frascos', '2025-04-20', 3),
(6, 'Herramientas de poda', 10.00, 'unidades', '2025-04-25', 4),
(7, 'Semillas de maíz', 200.00, 'kg', '2025-04-28', 5),
(8, 'Fertilizante NPK', 150.00, 'kg', '2025-05-01', 5),
(9, 'Bebederos automáticos', 15.00, 'unidades', '2025-05-05', 4),
(10, 'Desinfectante veterinario', 40.00, 'litros', '2025-05-06', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_productos`
--

CREATE TABLE `inventario_productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 0,
  `categoria` enum('Leche','Huevos','Carne','Pollo','Frutas','Verduras') NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario_productos`
--

INSERT INTO `inventario_productos` (`id_producto`, `nombre`, `descripcion`, `precio`, `cantidad`, `categoria`, `disponible`, `fecha_creacion`) VALUES
(1, 'Huevos de gallina', 'Huevos frescos de gallinas criadas en libertad', 12000.00, 150, 'Huevos', 1, '2025-04-01 08:00:00'),
(2, 'Leche entera', 'Leche fresca pasteurizada', 3500.00, 80, 'Leche', 1, '2025-04-02 09:15:00'),
(3, 'Carne de res', 'Cortes premium de carne de res', 25000.00, 50, 'Carne', 1, '2025-04-03 10:30:00'),
(4, 'Pollo entero', 'Pollo fresco criado sin hormonas', 15000.00, 60, 'Pollo', 1, '2025-04-04 11:45:00'),
(5, 'Manzanas', 'Manzanas rojas del huerto', 5000.00, 120, 'Frutas', 1, '2025-04-05 13:00:00'),
(6, 'Zanahorias', 'Zanahorias orgánicas recién cosechadas', 3000.00, 90, 'Verduras', 1, '2025-04-06 14:15:00'),
(7, 'Queso fresco', 'Queso fresco de leche entera', 12000.00, 40, 'Leche', 1, '2025-04-07 15:30:00'),
(8, 'Huevos de codorniz', 'Huevos pequeños de codorniz', 15000.00, 100, 'Huevos', 1, '2025-04-08 16:45:00'),
(9, 'Lomo de cerdo', 'Corte premium de cerdo', 22000.00, 30, 'Carne', 1, '2025-04-09 18:00:00'),
(10, 'Pechuga de pollo', 'Pechuga deshuesada y sin piel', 18000.00, 45, 'Pollo', 1, '2025-04-10 19:15:00'),
(11, 'Plátanos', 'Plátanos maduros de excelente calidad', 4000.00, 70, 'Frutas', 1, '2025-04-11 20:30:00'),
(12, 'Tomates', 'Tomates rojos jugosos', 4500.00, 85, 'Verduras', 1, '2025-04-12 21:45:00'),
(13, 'Yogur natural', 'Yogur natural sin azúcar añadida', 6000.00, 60, 'Leche', 1, '2025-04-13 22:00:00'),
(14, 'Huevos orgánicos', 'Huevos de gallinas alimentadas orgánicamente', 15000.00, 3, 'Huevos', 1, '2025-04-14 23:15:00'),
(15, 'Costilla de res', 'Costilla para asar o guisar', 28000.00, 25, 'Carne', 1, '2025-04-15 00:30:00'),
(16, 'Muslos de pollo', 'Muslos con piel y hueso', 12000.00, 55, 'Pollo', 1, '2025-04-16 01:45:00'),
(17, 'Fresas', 'Fresas frescas y dulces', 8000.00, 40, 'Frutas', 1, '2025-04-17 03:00:00'),
(18, 'Lechuga', 'Lechuga crespa orgánica', 3500.00, 65, 'Verduras', 1, '2025-04-18 04:15:00'),
(19, 'Mantequilla', 'Mantequilla de leche entera', 7000.00, 35, 'Leche', 1, '2025-04-19 05:30:00'),
(20, 'Huevos jumbo', 'Huevos tamaño jumbo', 13000.00, 90, 'Huevos', 1, '2025-04-20 06:45:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_accesos`
--

CREATE TABLE `log_accesos` (
  `id_log` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `fecha_intento` timestamp NOT NULL DEFAULT current_timestamp(),
  `exito` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `log_accesos`
--

INSERT INTO `log_accesos` (`id_log`, `id_usuario`, `fecha_intento`, `exito`) VALUES
(1, 1, '2025-05-01 08:00:00', 1),
(2, 2, '2025-05-01 09:15:00', 1),
(3, 3, '2025-05-01 10:30:00', 0),
(4, 3, '2025-05-01 10:32:00', 0),
(5, 3, '2025-05-01 10:35:00', 1),
(6, 4, '2025-05-02 11:45:00', 1),
(7, 5, '2025-05-02 13:00:00', 0),
(8, 5, '2025-05-02 13:02:00', 0),
(9, 5, '2025-05-02 13:05:00', 0),
(10, 6, '2025-05-03 14:15:00', 1),
(11, 7, '2025-05-03 15:30:00', 1),
(12, 8, '2025-05-04 16:45:00', 1),
(13, 9, '2025-05-04 18:00:00', 0),
(14, 9, '2025-05-04 18:02:00', 1),
(15, 10, '2025-05-05 19:15:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_accesos_clientes`
--

CREATE TABLE `log_accesos_clientes` (
  `id_log` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `fecha_intento` timestamp NOT NULL DEFAULT current_timestamp(),
  `exito` tinyint(1) DEFAULT NULL,
  `direccion_ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `log_accesos_clientes`
--

INSERT INTO `log_accesos_clientes` (`id_log`, `id_cliente`, `fecha_intento`, `exito`, `direccion_ip`, `user_agent`) VALUES
(1, 1, '2025-05-01 10:00:00', 1, '190.25.123.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'),
(2, 2, '2025-05-02 11:15:00', 1, '201.189.67.89', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)'),
(3, 3, '2025-05-03 12:30:00', 0, '186.75.34.21', 'Mozilla/5.0 (Linux; Android 10; SM-G975F)'),
(4, 3, '2025-05-03 12:32:00', 1, '186.75.34.21', 'Mozilla/5.0 (Linux; Android 10; SM-G975F)'),
(5, 4, '2025-05-04 13:45:00', 1, '200.105.78.90', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X)');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `fecha_pedido` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','procesando','enviado','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
  `direccion_envio` varchar(255) DEFAULT NULL,
  `metodo_pago` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id_pedido`, `id_cliente`, `fecha_pedido`, `total`, `estado`, `direccion_envio`, `metodo_pago`) VALUES
(1, 1, '2025-05-06 15:20:00', 41500.00, 'entregado', 'Calle 123 #45-67, Bogotá', 'tarjeta'),
(2, 2, '2025-05-06 16:45:00', 25000.00, 'procesando', 'Carrera 56 #78-90, Medellín', 'efectivo'),
(3, 3, '2025-05-06 17:30:00', 15000.00, 'pendiente', 'Avenida 12 #34-56, Cali', 'transferencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plantas`
--

CREATE TABLE `plantas` (
  `id_planta` int(11) NOT NULL,
  `nombre_cientifico` varchar(100) NOT NULL,
  `nombre_comun` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `estado` enum('Sano','Enfermo','Recuperación') DEFAULT 'Sano',
  `descripcion` text DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `plantas`
--

INSERT INTO `plantas` (`id_planta`, `nombre_cientifico`, `nombre_comun`, `ubicacion`, `estado`, `descripcion`, `fecha_registro`) VALUES
(1, 'Zea mays', 'Maíz', 'Campo Norte', 'Sano', 'Cultivo de maíz en etapa de crecimiento', '2025-04-15 08:00:00'),
(2, 'Solanum tuberosum', 'Papa', 'Campo Sur', 'Sano', 'Cultivo de papa en etapa de floración', '2025-04-16 09:15:00'),
(3, 'Coffea arabica', 'Café', 'Lote 1', 'Enfermo', 'Plantas de café con síntomas de roya', '2025-04-17 10:30:00'),
(4, 'Theobroma cacao', 'Cacao', 'Lote 2', 'Sano', 'Árboles de cacao en producción', '2025-04-18 11:45:00'),
(5, 'Oryza sativa', 'Arroz', 'Campo Este', 'Recuperación', 'Cultivo de arroz en tratamiento por plagas', '2025-04-19 13:00:00'),
(6, 'Citrus sinensis', 'Naranjo', 'Huerto 1', 'Sano', 'Árboles de naranja en producción', '2025-04-20 14:15:00'),
(7, 'Mangifera indica', 'Mango', 'Huerto 2', 'Recuperación', 'Árboles de mango en tratamiento por hongos', '2025-04-21 15:30:00'),
(8, 'Persea americana', 'Aguacate', 'Huerto 3', 'Sano', 'Árboles de aguacate en crecimiento', '2025-04-22 16:45:00'),
(9, 'Capsicum annuum', 'Ají', 'Invernadero 1', 'Sano', 'Plantas de ají en producción', '2025-04-23 18:00:00'),
(10, 'Phaseolus vulgaris', 'Frijol', 'Campo Oeste', 'Sano', 'Cultivo de frijol en etapa de floración', '2025-04-24 19:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `produccion`
--

CREATE TABLE `produccion` (
  `id_produccion` int(11) NOT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `tipo_produccion` enum('Leche','Huevos','Carne','Otro') NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `fecha_recoleccion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `produccion`
--

INSERT INTO `produccion` (`id_produccion`, `id_animal`, `tipo_produccion`, `cantidad`, `fecha_recoleccion`) VALUES
(1, 1, 'Huevos', 30.00, '2025-04-20'),
(2, 2, 'Huevos', 25.00, '2025-04-21'),
(3, 3, 'Leche', 15.00, '2025-04-22'),
(4, 4, 'Leche', 12.00, '2025-04-23'),
(5, 5, 'Carne', 50.00, '2025-04-24'),
(6, 6, 'Carne', 45.00, '2025-04-25'),
(7, 7, 'Carne', 40.00, '2025-04-26'),
(8, 8, 'Huevos', 20.00, '2025-04-27'),
(9, 9, 'Leche', 18.00, '2025-04-28'),
(10, 10, 'Carne', 35.00, '2025-04-29'),
(11, 1, 'Huevos', 28.00, '2025-05-01'),
(12, 2, 'Huevos', 22.00, '2025-05-02'),
(13, 3, 'Leche', 14.00, '2025-05-03'),
(14, 4, 'Leche', 11.00, '2025-05-04'),
(15, 5, 'Carne', 48.00, '2025-05-05'),
(16, 6, 'Carne', 42.00, '2025-05-06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `tipo_producto` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `telefono`, `direccion`, `tipo_producto`) VALUES
(1, 'Agroinsumos del Valle', '6021234567', 'Calle 10 #25-30, Cali', 'Alimentos balanceados'),
(2, 'Forrajes y Henos S.A.', '6042345678', 'Carrera 15 #40-50, Medellín', 'Pasto y heno'),
(3, 'FarmAnimal', '6013456789', 'Avenida 68 #25-45, Bogotá', 'Medicinas veterinarias'),
(4, 'Herramientas Agropecuarias', '6054567890', 'Calle 20 #35-60, Pereira', 'Herramientas y equipamiento'),
(5, 'Semillas y Fertilizantes', '6075678901', 'Diagonal 25 #30-40, Armenia', 'Semillas y fertilizantes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `id_reporte` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_planta` int(11) DEFAULT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `tipo` enum('Planta','Animal') NOT NULL,
  `diagnostico` text NOT NULL,
  `fecha_reporte` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reportes`
--

INSERT INTO `reportes` (`id_reporte`, `id_usuario`, `id_planta`, `id_animal`, `tipo`, `diagnostico`, `fecha_reporte`) VALUES
(1, 1, 3, NULL, 'Planta', 'Presencia de roya en hojas de café', '2025-04-20 08:00:00'),
(2, 2, 5, NULL, 'Planta', 'Ataque de insectos en cultivo de arroz', '2025-04-21 09:15:00'),
(3, 3, 7, NULL, 'Planta', 'Hongos en árboles de mango', '2025-04-22 10:30:00'),
(4, 1, NULL, 3, 'Animal', 'Fiebre y pérdida de apetito en vaca Holstein', '2025-04-23 11:45:00'),
(5, 2, NULL, 5, 'Animal', 'Parásitos en tilapias', '2025-04-24 13:00:00'),
(6, 3, NULL, 7, 'Animal', 'Problemas respiratorios en cerda Landrace', '2025-04-25 14:15:00'),
(7, 1, 1, NULL, 'Planta', 'Deficiencia de nutrientes en maíz', '2025-04-26 15:30:00'),
(8, 2, 2, NULL, 'Planta', 'Exceso de humedad en cultivo de papa', '2025-04-27 16:45:00'),
(9, 3, NULL, 9, 'Animal', 'Mastitis en vaca Jersey', '2025-04-28 18:00:00'),
(10, 1, NULL, 10, 'Animal', 'Hongo en aletas de bagres', '2025-04-29 19:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamientos`
--

CREATE TABLE `tratamientos` (
  `id_tratamiento` int(11) NOT NULL,
  `id_reporte` int(11) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `resultado` enum('Exitoso','En Proceso','Fallido') DEFAULT 'En Proceso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tratamientos`
--

INSERT INTO `tratamientos` (`id_tratamiento`, `id_reporte`, `descripcion`, `fecha_inicio`, `fecha_fin`, `resultado`) VALUES
(1, 1, 'Aplicación de fungicida para roya', '2025-04-21', '2025-04-28', 'Exitoso'),
(2, 2, 'Aplicación de insecticida orgánico', '2025-04-22', '2025-04-29', 'Exitoso'),
(3, 3, 'Tratamiento con fungicida sistémico', '2025-04-23', '2025-04-30', 'En Proceso'),
(4, 4, 'Administración de antibióticos y antipiréticos', '2025-04-24', '2025-05-01', 'Exitoso'),
(5, 5, 'Baño con solución antiparasitaria', '2025-04-25', '2025-05-02', 'Exitoso'),
(6, 6, 'Tratamiento con antibióticos y antiinflamatorios', '2025-04-26', '2025-05-03', 'En Proceso'),
(7, 7, 'Aplicación de fertilizante balanceado', '2025-04-27', NULL, 'En Proceso'),
(8, 8, 'Mejoramiento de drenaje y aplicación de fungicida', '2025-04-28', NULL, 'En Proceso'),
(9, 9, 'Tratamiento con antibióticos intramamarios', '2025-04-29', '2025-05-06', 'En Proceso'),
(10, 10, 'Baño con solución antifúngica', '2025-04-30', '2025-05-07', 'En Proceso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion_georreferenciada`
--

CREATE TABLE `ubicacion_georreferenciada` (
  `id_ubicacion` int(11) NOT NULL,
  `id_animal` int(11) DEFAULT NULL,
  `id_planta` int(11) DEFAULT NULL,
  `latitud` decimal(10,6) NOT NULL,
  `longitud` decimal(10,6) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubicacion_georreferenciada`
--

INSERT INTO `ubicacion_georreferenciada` (`id_ubicacion`, `id_animal`, `id_planta`, `latitud`, `longitud`, `fecha_registro`) VALUES
(1, 1, NULL, 4.609710, -74.081750, '2025-04-15 08:00:00'),
(2, 2, NULL, 4.609720, -74.081760, '2025-04-16 09:15:00'),
(3, NULL, 1, 4.609730, -74.081770, '2025-04-17 10:30:00'),
(4, NULL, 2, 4.609740, -74.081780, '2025-04-18 11:45:00'),
(5, 3, NULL, 4.609750, -74.081790, '2025-04-19 13:00:00'),
(6, NULL, 3, 4.609760, -74.081800, '2025-04-20 14:15:00'),
(7, 4, NULL, 4.609770, -74.081810, '2025-04-21 15:30:00'),
(8, NULL, 4, 4.609780, -74.081820, '2025-04-22 16:45:00'),
(9, 5, NULL, 4.609790, -74.081830, '2025-04-23 18:00:00'),
(10, NULL, 5, 4.609800, -74.081840, '2025-04-24 19:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `tipo_usuario` enum('Investigador','Veterinario','Botánico','Administrador') NOT NULL,
  `clave` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `correo`, `telefono`, `tipo_usuario`, `clave`) VALUES
(1, 'Carlos Méndez', 'carlos.mendez@email.com', '3101112233', 'Veterinario', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a'),
(2, 'Laura Gómez', 'laura.gomez@email.com', '3112223344', 'Administrador', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a'),
(3, 'Pedro Ramírez', 'pedro.ramirez@email.com', '3123334455', 'Veterinario', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a'),
(4, 'Ana López', 'ana.lopez@email.com', '3134445566', 'Administrador', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a'),
(5, 'Jorge Castro', 'jorge.castro@email.com', '3145556677', 'Investigador', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a'),
(6, 'Sofía Ruiz', 'sofia.ruiz@email.com', '3156667788', 'Botánico', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a'),
(7, 'Miguel Ángel Torres', 'miguel.torres@email.com', '3167778899', 'Investigador', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a'),
(8, 'Diana García', 'diana.garcia@email.com', '3178889900', 'Botánico', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a'),
(9, 'Fernando Herrera', 'fernando.herrera@email.com', '3189990011', 'Veterinario', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a'),
(10, 'Patricia Vargas', 'patricia.vargas@email.com', '3190001122', 'Administrador', '$2y$10$CNbVbheq5HD4Z0vPWDKEhOsAp/c.yNoWu1SD4U7PVL3hdF83DmA3a');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vacunacion`
--

CREATE TABLE `vacunacion` (
  `id_vacunacion` int(11) NOT NULL,
  `id_animal` int(11) NOT NULL,
  `id_vacuna` int(11) NOT NULL,
  `fecha_aplicacion` date NOT NULL,
  `proxima_dosis` date DEFAULT NULL,
  `dosis` varchar(50) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vacunacion`
--

INSERT INTO `vacunacion` (`id_vacunacion`, `id_animal`, `id_vacuna`, `fecha_aplicacion`, `proxima_dosis`, `dosis`, `id_empleado`, `observaciones`) VALUES
(1, 1, 1, '2025-04-01', '2025-10-01', '0.5 ml', 1, 'Sin reacciones adversas'),
(2, 2, 1, '2025-04-02', '2025-10-02', '0.5 ml', 1, 'Leve inflamación en el sitio de aplicación'),
(3, 3, 2, '2025-04-03', '2025-10-03', '2 ml', 1, 'Animal tranquilo durante la aplicación'),
(4, 4, 2, '2025-04-04', '2025-10-04', '2 ml', 1, 'Sin complicaciones'),
(5, 5, 3, '2025-04-05', '2025-10-05', '1 ml', 1, 'Buena respuesta inmunitaria'),
(6, 6, 4, '2025-04-06', '2025-10-06', '0.3 ml', 1, 'Aplicación exitosa'),
(7, 7, 4, '2025-04-07', '2025-10-07', '0.3 ml', 1, 'Sin efectos secundarios'),
(8, 8, 1, '2025-04-08', '2025-10-08', '0.5 ml', 1, 'Animal en buenas condiciones'),
(9, 9, 2, '2025-04-09', '2025-10-09', '2 ml', 1, 'Monitorización normal'),
(10, 10, 3, '2025-04-10', '2025-10-10', '1 ml', 1, 'Vacuna administrada correctamente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vacunas`
--

CREATE TABLE `vacunas` (
  `id_vacuna` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `fabricante` varchar(100) NOT NULL,
  `temperatura_almacenamiento` varchar(50) NOT NULL,
  `vida_util` varchar(50) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vacunas`
--

INSERT INTO `vacunas` (`id_vacuna`, `nombre`, `descripcion`, `fabricante`, `temperatura_almacenamiento`, `vida_util`, `cantidad`) VALUES
(1, 'Fiebre Aftosa', 'Protege contra la fiebre aftosa en bovinos', 'Zoetis', '2-8°C', '2 años', 20),
(2, 'Brucelosis', 'Protección contra brucelosis bovina', 'Boehringer', '2-8°C', '18 meses', 15),
(3, 'Newcastle', 'Protección contra enfermedad de Newcastle en aves', 'Ceva', '2-8°C', '1 año', 25),
(4, 'Rabia', 'Protección contra rabia en mamíferos', 'Merial', '2-8°C', '2 años', 30),
(5, 'Leptospirosis', 'Protección contra leptospirosis en porcinos', 'Pfizer', '2-8°C', '18 meses', 18),
(6, 'Erisipela', 'Protección contra erisipela porcina', 'Hipra', '2-8°C', '1 año', 22),
(7, 'Influenza Aviar', 'Protección contra influenza aviar', 'Merial', '2-8°C', '1 año', 28),
(8, 'Parvovirus', 'Protección contra parvovirus porcino', 'Boehringer', '2-8°C', '2 años', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `precio_total` decimal(10,2) NOT NULL,
  `fecha_venta` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_cliente` int(11) DEFAULT NULL,
  `metodo_pago` varchar(50) DEFAULT NULL,
  `estado` enum('pendiente','completada','cancelada') NOT NULL DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `id_pedido`, `id_producto`, `cantidad`, `precio_unitario`, `precio_total`, `fecha_venta`, `id_cliente`, `metodo_pago`, `estado`) VALUES
(1, 1, 2, 5, 3500.00, 17500.00, '2025-05-06 15:20:00', 1, 'tarjeta', 'completada'),
(2, 1, 7, 2, 12000.00, 24000.00, '2025-05-06 15:20:00', 1, 'tarjeta', 'completada'),
(3, 2, 3, 1, 25000.00, 25000.00, '2025-05-06 16:45:00', 2, 'efectivo', 'completada'),
(4, 3, 5, 3, 5000.00, 15000.00, '2025-05-06 17:30:00', 3, 'transferencia', 'pendiente');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alertas`
--
ALTER TABLE `alertas`
  ADD PRIMARY KEY (`id_alerta`,`categoria`);

--
-- Indices de la tabla `alimentacion`
--
ALTER TABLE `alimentacion`
  ADD PRIMARY KEY (`id_alimentacion`),
  ADD KEY `id_especie` (`id_especie`);

--
-- Indices de la tabla `animales`
--
ALTER TABLE `animales`
  ADD PRIMARY KEY (`id_animal`),
  ADD KEY `id_especie` (`id_especie`),
  ADD KEY `idx_animales_estado` (`estado`);

--
-- Indices de la tabla `bloqueo_usuarios`
--
ALTER TABLE `bloqueo_usuarios`
  ADD PRIMARY KEY (`id_bloqueo`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  ADD PRIMARY KEY (`id_item`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `costos`
--
ALTER TABLE `costos`
  ADD PRIMARY KEY (`id_costo`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_animal` (`id_animal`),
  ADD KEY `id_especie` (`id_especie`);

--
-- Indices de la tabla `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id_empleado`);

--
-- Indices de la tabla `especies`
--
ALTER TABLE `especies`
  ADD PRIMARY KEY (`id_especie`);

--
-- Indices de la tabla `historial_estado_salud`
--
ALTER TABLE `historial_estado_salud`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_animal` (`id_animal`),
  ADD KEY `id_planta` (`id_planta`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `inventario_productos`
--
ALTER TABLE `inventario_productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `idx_categoria` (`categoria`),
  ADD KEY `idx_disponible` (`disponible`);

--
-- Indices de la tabla `log_accesos`
--
ALTER TABLE `log_accesos`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `log_accesos_clientes`
--
ALTER TABLE `log_accesos_clientes`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_usuario` (`id_cliente`);

--
-- Indices de la tabla `plantas`
--
ALTER TABLE `plantas`
  ADD PRIMARY KEY (`id_planta`),
  ADD KEY `idx_plantas_ubicacion` (`ubicacion`);

--
-- Indices de la tabla `produccion`
--
ALTER TABLE `produccion`
  ADD PRIMARY KEY (`id_produccion`),
  ADD KEY `id_animal` (`id_animal`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id_reporte`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_planta` (`id_planta`),
  ADD KEY `id_animal` (`id_animal`);

--
-- Indices de la tabla `tratamientos`
--
ALTER TABLE `tratamientos`
  ADD PRIMARY KEY (`id_tratamiento`),
  ADD KEY `id_reporte` (`id_reporte`);

--
-- Indices de la tabla `ubicacion_georreferenciada`
--
ALTER TABLE `ubicacion_georreferenciada`
  ADD PRIMARY KEY (`id_ubicacion`),
  ADD KEY `id_animal` (`id_animal`),
  ADD KEY `id_planta` (`id_planta`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `idx_usuarios_correo` (`correo`);

--
-- Indices de la tabla `vacunacion`
--
ALTER TABLE `vacunacion`
  ADD PRIMARY KEY (`id_vacunacion`),
  ADD KEY `id_animal` (`id_animal`),
  ADD KEY `id_vacuna` (`id_vacuna`),
  ADD KEY `id_empleado` (`id_empleado`);

--
-- Indices de la tabla `vacunas`
--
ALTER TABLE `vacunas`
  ADD PRIMARY KEY (`id_vacuna`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alertas`
--
ALTER TABLE `alertas`
  MODIFY `id_alerta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `alimentacion`
--
ALTER