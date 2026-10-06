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

object jugador1 inherits Jugador(position = game.at(1, 4)) {
  override method image() = "paleta1.png"
}

object jugador2 inherits Jugador(position = game.at(8, 4)) {
  override method image() = "paleta2.png"
}

object marcadorJugador1 {
  var property position = game.at(1, 9)

  method text() = "Puntos J1: " + jugador1.puntos().toString()
}

object marcadorJugador2 {
  var property position = game.at(8, 9)

  method text() = "Puntos J2: " + jugador2.puntos().toString()
}