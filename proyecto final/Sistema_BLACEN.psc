Algoritmo Sistema_BLACEN
	
	// --- Seguridad de acceso ---
	Definir usuarioIngresado, contrasenaIngresada Como Cadena
	Definir intentos Como Entero
	intentos <- 0
	
	// Usuario y contraseña predefinidos
	Definir usuarioCorrecto, contrasenaCorrecta Como Cadena
	usuarioCorrecto <- "admin"
	contrasenaCorrecta <- "BLACEN"
	
	Repetir
		Escribir "======= ACCESO AL SISTEMA BLACEN ======="
		Escribir "Ingrese usuario:"
		Leer usuarioIngresado
		Escribir "Ingrese contraseña:"
		Leer contrasenaIngresada
		
		Si usuarioIngresado = usuarioCorrecto Y contrasenaIngresada = contrasenaCorrecta Entonces
			Escribir "Acceso concedido. Bienvenido ", usuarioCorrecto, "."
		Sino
			intentos <- intentos + 1
			Escribir "Usuario o contraseña incorrectos. Intento ", intentos, " de 3."
		FinSi
	Hasta Que (usuarioIngresado = usuarioCorrecto Y contrasenaIngresada = contrasenaCorrecta) O intentos = 3
	
	Si intentos = 3 Entonces
		Escribir "Demasiados intentos fallidos. Acceso denegado."
	FinSi
	
	
	// Declaraciones
	Dimension productos[100]
	Dimension categorias[100]
	Dimension cantidades[100]
	Dimension precios[100]
	
	Dimension facturaProducto[50]
	Dimension facturaCantidad[50]
	Dimension facturaPrecio[50]
	Dimension facturaTotal[50]
	
	// Definición de variables generales
	Definir totalProductos, opcion, i, indiceProducto, cantidadVenta, productoEncontrado Como Entero
	Definir subtotal, iva, descuento, granTotal, precioUnitario, porcentajeDescuento Como Real
	Definir numFacturaItems Como Entero
	Definir cliente, ruc, fecha, respuesta Como Cadena
	Definir prodNuevo, catNueva Como Cadena
	Definir cantNueva Como Entero
	Definir precioNuevo Como Real
	
	// Inicializar productos (13 productos base)
	totalProductos <- 13
	
	productos[1] <- "Aceite Castrol"
	categorias[1] <- "Aceites y Lubricantes"
	cantidades[1] <- 10
	precios[1] <- 400
	
	productos[2] <- "Aceite Axiom"
	categorias[2] <- "Aceites y Lubricantes"
	cantidades[2] <- 10
	precios[2] <- 450
	
	productos[3] <- "Neumático 3.25-17 GB Boy"
	categorias[3] <- "Neumáticos y Llantas"
	cantidades[3] <- 10
	precios[3] <- 700
	
	productos[4] <- "Neumático 4.00-17 GB Boy"
	categorias[4] <- "Neumáticos y Llantas"
	cantidades[4] <- 10
	precios[4] <- 800
	
	productos[5] <- "Neumático 3.00-17"
	categorias[5] <- "Neumáticos y Llantas"
	cantidades[5] <- 10
	precios[5] <- 900
	
	productos[6] <- "Cable clutch"
	categorias[6] <- "Partes de transmisión y frenos"
	cantidades[6] <- 10
	precios[6] <- 550
	
	productos[7] <- "Manigueta clutch"
	categorias[7] <- "Partes de transmisión y frenos"
	cantidades[7] <- 10
	precios[7] <- 600
	
	productos[8] <- "CDI CRF200"
	categorias[8] <- "Eléctricos y electrónicos"
	cantidades[8] <- 10
	precios[8] <- 450
	
	productos[9] <- "Bobina bajo 8M3 C6150-8"
	categorias[9] <- "Eléctricos y electrónicos"
	cantidades[9] <- 10
	precios[9] <- 350
	
	productos[10] <- "Chispero D8"
	categorias[10] <- "Eléctricos y electrónicos"
	cantidades[10] <- 10
	precios[10] <- 900
	
	productos[11] <- "Protector pedal cambio azul"
	categorias[11] <- "Accesorios y varios"
	cantidades[11] <- 10
	precios[11] <- 500
	
	productos[12] <- "Spray negro brillante"
	categorias[12] <- "Accesorios y varios"
	cantidades[12] <- 10
	precios[12] <- 250
	
	productos[13] <- "Boya shop has 8001"
	categorias[13] <- "Accesorios y varios"
	cantidades[13] <- 10
	precios[13] <- 600
	
	// Menú principal
	Repetir
		Escribir "========= SISTEMA BLACEN ========="
		Escribir "1. Realizar venta"
		Escribir "2. Agregar producto nuevo"
		Escribir "3. Ver inventario"
		Escribir "4. Salir"
		Escribir "Seleccione una opción:"
		Leer opcion
		
		Segun opcion Hacer
			
			Caso 1:
				subtotal <- 0
				numFacturaItems <- 0
				
				Escribir "Ingrese nombre del cliente:"
				Leer cliente
				Escribir "Ingrese RUC (opcional):"
				Leer ruc
				Escribir "Ingrese fecha:"
				Leer fecha
				
				Repetir
					Escribir "------- INVENTARIO BLACEN -------"
					Para i <- 1 Hasta totalProductos Con Paso 1
						Escribir i, ". ", productos[i], " (", categorias[i], ") - Cantidad: ", cantidades[i], " - Precio: C$", precios[i]
					FinPara
					
					Escribir "Ingrese el número del producto a vender:"
					Leer indiceProducto
					
					Si indiceProducto >= 1 Y indiceProducto <= totalProductos Entonces
						Escribir "Cantidad disponible: ", cantidades[indiceProducto]
						Escribir "Ingrese cantidad a vender:"
						Leer cantidadVenta
						
						Si cantidades[indiceProducto] >= cantidadVenta Entonces
							precioUnitario <- precios[indiceProducto]
							subtotal <- subtotal + (precioUnitario * cantidadVenta)
							cantidades[indiceProducto] <- cantidades[indiceProducto] - cantidadVenta
							
							numFacturaItems <- numFacturaItems + 1
							facturaProducto[numFacturaItems] <- indiceProducto
							facturaCantidad[numFacturaItems] <- cantidadVenta
							facturaPrecio[numFacturaItems] <- precioUnitario
							facturaTotal[numFacturaItems] <- precioUnitario * cantidadVenta
						Sino
							Escribir "No hay suficiente inventario."
						FinSi
					Sino
						Escribir "Número inválido."
					FinSi
					
					Escribir "¿Desea agregar otro producto a la factura? (SI/NO):"
					Leer respuesta
				Hasta Que Mayusculas(respuesta) = "NO"
				
				iva <- subtotal * 0.15
				descuento <- 0
				
				Escribir "¿Aplicar descuento por temporada? (SI/NO):"
				Leer respuesta
				Si Mayusculas(respuesta) = "SI" Entonces
					Escribir "Ingrese porcentaje de descuento:"
					Leer porcentajeDescuento
					descuento <- subtotal * (porcentajeDescuento / 100)
				FinSi
				
				granTotal <- subtotal + iva - descuento
				
				Escribir "========== FACTURA BLACEN =========="
				Escribir "Cliente: ", cliente
				Si ruc <> "" Entonces
					Escribir "RUC: ", ruc
				FinSi
				Escribir "Fecha: ", fecha
				Escribir "      Detalle de productos:"
				Escribir "Producto | Cant | Precio | Total"
				
				Para i <- 1 Hasta numFacturaItems Con Paso 1
					indiceProducto <- facturaProducto[i]
					Escribir productos[indiceProducto], " | ", facturaCantidad[i], " | C$", facturaPrecio[i], " | C$", facturaTotal[i]
				FinPara
				
				Escribir "Subtotal: C$", subtotal
				Escribir "IVA 15%: C$", iva
				Escribir "Descuento: C$", descuento
				Escribir "TOTAL A PAGAR: C$", granTotal
				Escribir "====================================="
				
			Caso 2:
				totalProductos <- totalProductos + 1
				Escribir "Ingrese nombre del nuevo producto:"
				Leer prodNuevo
				productos[totalProductos] <- prodNuevo
				Escribir "Ingrese categoría:"
				Leer catNueva
				categorias[totalProductos] <- catNueva
				Escribir "Ingrese cantidad:"
				Leer cantNueva
				cantidades[totalProductos] <- cantNueva
				Escribir "Ingrese precio:"
				Leer precioNuevo
				precios[totalProductos] <- precioNuevo
				Escribir "Producto agregado correctamente."
				
			Caso 3:
				Escribir "------- INVENTARIO ACTUAL -------"
				Para i <- 1 Hasta totalProductos Con Paso 1
					Escribir i, ". ", productos[i], " - ", categorias[i], " - Cantidad: ", cantidades[i], " - Precio: C$", precios[i]
				FinPara
				
			Caso 4:
				Escribir "Gracias por usar el sistema BLACEN. Hasta pronto."
				
			De Otro Modo:
				Escribir "Opción inválida. Intente de nuevo."
				
		FinSegun
		
	Hasta Que opcion = 4

FinAlgoritmo
