import wollok.game.*

class Jugador {
  var property position
  var property puntos = 0
  const property limiteSuperior = 9
  const property limiteInferior = 0

  method subir() {
    if (position.y() < limiteSuperior) {
      position = position.up(1)
    }
  }

  method bajar() {
    if (position.y() > limiteInferior) {
      position = position.down(1)
    }
  }

  method anotarPunto() {
    puntos += 1
  }

  method reiniciarPuntos() {
    puntos = 0
  }

  method colisionarConPelota(pelota) {
    pelota.rebotarHorizontal()
  }

  method image() = "player.png"
}

object jugador1 inherits Jugador(position = game.at(0, 4)) {
  override method image() = "paleta1.png"
}

object jugador2 inherits Jugador(position = game.at(9, 4)) {
  override method image() = "paleta2.png"
}
