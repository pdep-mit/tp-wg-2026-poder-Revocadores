# Explicaciones teóricas

## Polimorfismo

En el objeto config, al configurar las colisiones de la pelota (game.onCollideDo), solo se le envía el mensaje elemento.colisionarConPelota(pelotaActual). Para el controlador del juego, tanto una paleta como cualquier tipo de caja son tratados de forma totalmente igual: ambos entienden el mensaje colisionarConPelota, pero cada uno reacciona de acuerdo a su propia lógica (el jugador hace rebotar la pelota horizontalmente y las cajas aplican su poder y desaparecen).

## Herencia

La clase CajaPowerUp define el método colisionarConPelota(pelota). Este método establece la "plantilla" general del comportamiento cuando la pelota choca con una caja: elimina el objeto visual de la pantalla y programa la reaparición de una nueva caja. Por su parte, las subclases (CajaAceleradora, CajaFreno, CajaInversora) redefinen dicho método para aplicar un efecto específico sobre la pelota (aumentarVelocidad, reducirVelocidad, rebotarVertical) y luego invoca a super(pelota) para ejecutar la lógica genérica de desaparición y reaparición sin repetirla.   

## Colecciones y Rangos

Se utilizan listas para definir movimientos aleatorios, por ejemplo, al inicializar el vector de movimiento vertical de la pelota mediante direccionY = [1, -1].anyOne(). Además, se emplean rangos numéricos como colecciones para calcular las coordenadas aleatorias de reaparición de las cajas dentro de los márgenes del tablero en posicionAleatoria(): const nuevoX = (2 .. game.width() - 3).anyOne()

# Diagramas

*Incluír al menos un diagrama para comunicar su solución*