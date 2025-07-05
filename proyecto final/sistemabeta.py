import json
import os

# Archivo donde se guardará el inventario
inventario_file = "inventario.json"


#Función para limpiar la consola
def limpiar():
    os.system('cls' if os.name == 'nt' else 'clear')


# Si existe archivo, lo cargamos; si no, inicializamos con los datos
def cargar_inventario():
    if os.path.exists(inventario_file):
        with open(inventario_file, "r") as f:
            return json.load(f)
    else:
        # Inventario inicial
        return [
            {"nombre": "Aceite Castrol", "categoria": "Aceites y Lubricantes", "cantidad": 10, "precio": 400},
            {"nombre": "Aceite Axiom", "categoria": "Aceites y Lubricantes", "cantidad": 10, "precio": 450},
            {"nombre": "Neumático 3.25-17 GB Boy", "categoria": "Neumáticos y Llantas", "cantidad": 10, "precio": 700},
            {"nombre": "Neumático 4.00-17 GB Boy", "categoria": "Neumáticos y Llantas", "cantidad": 10, "precio": 800},
            {"nombre": "Neumático 3.00-17", "categoria": "Neumáticos y Llantas", "cantidad": 10, "precio": 900},
            {"nombre": "Cable clutch", "categoria": "Partes de transmisión y frenos", "cantidad": 10, "precio": 550},
            {"nombre": "Manigueta clutch", "categoria": "Partes de transmisión y frenos", "cantidad": 10, "precio": 600},
            {"nombre": "CDI CRF200", "categoria": "Eléctricos y electrónicos", "cantidad": 10, "precio": 450},
            {"nombre": "Bobina bajo 8M3 C6150-8", "categoria": "Eléctricos y electrónicos", "cantidad": 10, "precio": 350},
            {"nombre": "Chispero D8", "categoria": "Eléctricos y electrónicos", "cantidad": 10, "precio": 900},
            {"nombre": "Protector pedal cambio azul", "categoria": "Accesorios y varios", "cantidad": 10, "precio": 500},
            {"nombre": "Spray negro brillante", "categoria": "Accesorios y varios", "cantidad": 10, "precio": 250},
            {"nombre": "Boya shop has 8001", "categoria": "Accesorios y varios", "cantidad": 10, "precio": 600}
        ]

#Funcion para guardar el inventario
def guardar_inventario(productos):
    with open(inventario_file, "w") as f:
        json.dump(productos, f, indent=4)
        
#Funcion para cargar usuarios
def cargar_usuarios():
    usuarios={}
    if os.path.exists("users.txt"):
        with open("users.txt", "r") as archivo:
            for linea in archivo:
                usuario, contrasena=linea.strip().split(",")
                usuarios[usuario] = contrasena
    return usuarios
                
import pwinput

#Funcion para la validación del inicio de sesión, máximo 3 intentos
def login():
    print("=== INICIO DE SESIÓN ===")
    usuarios= cargar_usuarios()
    
    intentos = 3
    while intentos > 0:
        usuario = input("Usuario: ")
        contrasena_ingresada = pwinput.pwinput("Contraseña: ", mask='*')
    
        if usuario in usuarios and usuarios[usuario] == contrasena_ingresada:
            print("¡Acceso concedido!\n")
            return True
        else:
            print("Credenciales incorrectas.")
            intentos -= 1
    print("Demasiados intentos fallidos.")
    return False

#Definición de la función para mostrar el inventario
def mostrar_inventario(productos):
    print("\n-------------------------------------------- INVENTARIO ACTUAL ---------------------------------------------------")
    print(f"{'No.':<7}{'Producto':<40}{'Categoría':<50}{'Cant':<6}{'Precio (C$)':<10}")
    print("-" * 115)
    for i, p in enumerate(productos, 1):
        print(f"{i:<7}{p['nombre']:<40}{p['categoria']:<50}{p['cantidad']:<6}{p['precio']:<10.2f}")
    print()

def agregar_producto(productos):
    nombre = input("Nombre del producto: ")
    categoria = input("Categoría: ")
    try:
        cantidad = int(input("Cantidad: "))
        precio = float(input("Precio: "))
        productos.append({"nombre": nombre, "categoria": categoria, "cantidad": cantidad, "precio": precio})
        guardar_inventario(productos)
        print("Producto agregado correctamente.\n")
    except:
        print("Datos inválidos. No se agregó el producto.\n")

def guardar_cliente(nombre, ruc):
    with open("clientes_frecuentes.txt", "a") as archivo:
        archivo.write(f"{nombre} - RUC: {ruc}\n")

def guardar_factura(cliente, ruc, fecha, items, subtotal, iva, descuento, total):
    with open("factura.txt", "a") as f:
        f.write("========== FACTURA ==========\n")
        f.write(f"Cliente: {cliente}\n")
        if ruc != "":
            f.write(f"RUC: {ruc}\n")
        f.write(f"Fecha: {fecha}\n")
        f.write("Producto\tCant\tPrecio\tTotal\n")
        for item in items:
            f.write(f"{item['nombre']}\t{item['cantidad']}\tC${item['precio']}\tC${item['total']}\n")
        f.write(f"\nSubtotal: C${subtotal:.2f}\n")
        f.write(f"IVA (15%): C${iva:.2f}\n")
        f.write(f"Descuento: C${descuento:.2f}\n")
        f.write(f"TOTAL A PAGAR: C${total:.2f}\n")
        f.write("=============================\n\n")

def realizar_venta(productos):
    cliente = input("Nombre del cliente: ")
    ruc = input("RUC (opcional): ")
    fecha = input("Fecha: ")
    items = []
    subtotal = 0

    while True:
        mostrar_inventario(productos)
        try:
            indice = int(input("Ingrese número del producto a vender: ")) - 1
            if 0 <= indice < len(productos):
                prod = productos[indice]
                cantidad = int(input(f"Ingrese cantidad a vender (Disponible: {prod['cantidad']}): "))
                if 0 < cantidad <= prod["cantidad"]:
                    total_item = cantidad * prod["precio"]
                    items.append({
                        "nombre": prod["nombre"],
                        "cantidad": cantidad,
                        "precio": prod["precio"],
                        "total": total_item
                    })
                    subtotal += total_item
                    productos[indice]["cantidad"] -= cantidad
                    guardar_inventario(productos)
                else:
                    print("Cantidad inválida.")
            else:
                print("Producto no encontrado.")
        except:
            print("Entrada inválida.")

        otro = input("¿Agregar otro producto? (si/no): ").lower()
        if otro != "si":
            break

    iva = subtotal * 0.15
    descuento = 0
    aplicar_desc = input("¿Aplicar descuento por temporada? (si/no): ").lower()
    if aplicar_desc == "si":
        try:
            porcentaje = float(input("Porcentaje de descuento (%): "))
            descuento = subtotal * (porcentaje / 100)
        except:
            print("Porcentaje inválido. No se aplicó descuento.")
    total = subtotal + iva - descuento

    print("\n========= FACTURA =========")
    print(f"Cliente: {cliente}")
    print(f"Fecha: {fecha}")
    print("Producto\tCant\tPrecio\tTotal")
    for item in items:
        print(f"{item['nombre']}\t{item['cantidad']}\tC${item['precio']}\tC${item['total']}")
    print(f"\nSubtotal: C${subtotal:.2f}")
    print(f"IVA (15%): C${iva:.2f}")
    print(f"Descuento: C${descuento:.2f}")
    print(f"TOTAL A PAGAR: C${total:.2f}")
    print("============================\n")

    guardar_factura(cliente, ruc, fecha, items, subtotal, iva, descuento, total)
    guardar_cliente(cliente, ruc)

# --------- PROGRAMA PRINCIPAL ---------

if login():
    productos = cargar_inventario()
    while True:
        limpiar()
        print("=== MENÚ BLACEN ===")
        print("1. Realizar venta")
        print("2. Agregar producto nuevo")
        print("3. Ver inventario")
        print("4. Salir")
        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            realizar_venta(productos)
        elif opcion == "2":
            agregar_producto(productos)
        elif opcion == "3":
            mostrar_inventario(productos)
        elif opcion == "4":
            print("Gracias por usar el sistema BLACEN.")
            break
        else:
            print("Opción inválida.\n")
        input("Presione Enter para continuar...")  # Espera al usuario para continuar

