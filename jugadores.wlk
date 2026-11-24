import wollok.game.*
import config.*

class Jugador {
  var property position
  var property puntos = 0
  const property limiteSuperior = 7
  const property limiteInferior = 1
  const property nombre
  const property direccionSaque

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

  method moverManualArriba() {
    self.subir()
  }

  method moverManualAbajo() {
    self.bajar()
  }

  method anotarPunto() {
    puntos += 1
  }

  method reiniciarPuntos() {
    puntos = 0
  }

  method gano() = puntos >= 5

  method actualizarEnTick(pelota) {}

  method colisionarConPelota(pelota) {
    game.sound("rebote.wav").play()
    pelota.rebotarHorizontal()
  }
}

class JugadorMaquina inherits Jugador {
  var tiempoDecision = 0

  override method actualizarEnTick(pelota) {
    if (pelota != null) {
      tiempoDecision += 50
      if (tiempoDecision >= 150) {
        tiempoDecision = 0
        if (pelota.position().y() > position.y()) {
          self.subir()
        } else if (pelota.position().y() < position.y()) {
          self.bajar()
        }
      }
    }
  }

  override method moverManualArriba() {}

  override method moverManualAbajo() {}
}

object jugador1 inherits Jugador(position = game.at(1, 4), nombre = "Jugador 1", direccionSaque = 1) {
  method image() = "paleta1.png"
}

object jugador2Humano inherits Jugador(position = game.at(11, 4), nombre = "Jugador 2", direccionSaque = -1) {
  method image() = "paleta3.png"
  method siguienteRival() = jugador2Bot
}

object jugador2Bot inherits JugadorMaquina(position = game.at(11, 4), nombre = "la Máquina", direccionSaque = -1) {
  method image() = "paleta3.png"
  method siguienteRival() = jugador2Humano
}

class Marcador {
  var property position
  const proveedorJugador

  method text() {
    const jugador = proveedorJugador.apply()
    return jugador.nombre() + ": " + jugador.puntos().toString()
  }

  method textColor() = "FFFFFFFF"
}

object marcadorJugador1 inherits Marcador(position = game.at(1, 8), proveedorJugador = { jugador1 }) {}

object marcadorJugador2 inherits Marcador(position = game.at(11, 8), proveedorJugador = { config.rival() }) {}