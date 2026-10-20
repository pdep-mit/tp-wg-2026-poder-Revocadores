import wollok.game.*

class Jugador {
  var property position
  var property puntos = 0
  const property limiteSuperior = 7
  const property limiteInferior = 1

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

  method desaparecer(){}
}

object jugador1 inherits Jugador(position = game.at(1, 4)) {
  method image() = "paleta1.png"
}

object jugador2 inherits Jugador(position = game.at(11, 4)) {
  method image() = "paleta3.png"
}

object marcadorJugador1 {
  var property position = game.at(1, 8)

  method text() = "Puntos J1: " + jugador1.puntos().toString()

  method textColor() = "FFFFFFFF"

}

object marcadorJugador2 {
  var property position = game.at(11, 8)

  method text() = "Puntos J2: " + jugador2.puntos().toString()

  method textColor() = "FFFFFFFF"
  
}