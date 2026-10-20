import wollok.game.*
import config.*


class Pelota {
  var property position = game.at(6, 4)
  var property direccionX = 1
  var property direccionY = 1
  var property velocidad = 1

  method image() = "pelota.png"

  method mover() {
    const proximoY = position.y() + direccionY
    if (proximoY > 7 or proximoY < 1) {
      self.rebotarVertical()
    }
    position = game.at(
      (position.x() + direccionX).max(0).min(12),
      (position.y() + direccionY).max(0).min(8)
    )
  }

  method rebotarHorizontal() {
    direccionX = -direccionX
  }

  method rebotarVertical() {
    direccionY = -direccionY
  }

  method aumentarVelocidad(cantidad) {
    velocidad += cantidad
  }

  method reducirVelocidad(cantidad) {
    velocidad = (velocidad - cantidad).max(1)
  }

  method direccionAleatoria() = [1, -1].anyOne()

  method morir() {
    game.removeVisual(self)
  }

  method salioPorIzquierda() = position.x() <= 0 and direccionX < 0

  method salioPorDerecha() = position.x() >= 12 and direccionX > 0
}

object textovelocidad {
  var property position = game.at(6, 0)

  method text() = if (config.pelotaActual() != null) "Velocidad Pelota: " + config.pelotaActual().velocidad().toString() else ""

  method textColor() = "FFFFFFFF"

  method colisionarConPelota(pelota) {}
}