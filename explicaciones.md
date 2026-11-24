# Explicaciones teóricas

## Polimorfismo

En `administradorDePelotas`, al configurar las colisiones de cada pelota (`game.onCollideDo`), solo se le envía el mensaje `elemento.colisionarConPelota(pelota)`. Para el controlador del juego, tanto una paleta como cualquier tipo de caja o límite son tratados de forma igual: todos entienden el mensaje `colisionarConPelota`, pero cada uno reacciona de acuerdo a su propia lógica (el jugador hace rebotar la pelota horizontalmente y las cajas aplican su poder y desaparecen).

Además, se aplica polimorfismo sin efectos (*null object / no-op*) para evitar chequeos de tipo o estado innecesarios: `Pelota` implementa `colisionarConPelota(otraPelota) {}` vacío para ignorar choques entre pelotas, y `Jugador` implementa `actualizarEnTick(pelota) {}` vacío para que el jugador humano no haga nada en cada tick mientras `JugadorMaquina` lo sobrescribe con su lógica de seguimiento.

## Herencia

La clase `CajaPowerUp` utiliza el patrón *Template Method* en `colisionarConPelota(pelota)`. Este método define la estructura general del comportamiento cuando la pelota choca con una caja: invoca al método abstracto `self.aplicarEfecto(pelota)`, elimina el objeto visual de la pantalla y programa `self.reaparecer()`, que a su vez delega la instanciación en `self.crearEn(self.posicionAleatoria())`. Por su parte, las subclases (`CajaAceleradora`, `CajaFreno`, `CajaInversora`, `CajaDuplicadora`) sobrescriben únicamente `aplicarEfecto(pelota)` y `crearEn(posicion)` para definir su efecto específico y su propia instanciación, reutilizando toda la lógica común sin repetir código.

## Colecciones y Rangos

Se utilizan listas para definir movimientos aleatorios, por ejemplo, al inicializar el vector de movimiento vertical de la pelota mediante direccionY = [1, -1].anyOne(). Además, se emplean rangos numéricos como colecciones para calcular las coordenadas aleatorias de reaparición de las cajas dentro de los márgenes del tablero en posicionAleatoria(): const nuevoX = (2 .. game.width() - 3).anyOne()

# Diagramas

*Incluír al menos un diagrama para comunicar su solución*