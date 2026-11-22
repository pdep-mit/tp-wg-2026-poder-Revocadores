import wollok.game.*
import config.*


class Pelota {
  var property position
  var property direccionX
  var property direccionY
  var property velocidad

  method image() = "pelota.png"

  method mover() {
    const proximoX = position.x() + (direccionX * velocidad)
    const proximoY = position.y() + (direccionY * velocidad)

    if (proximoY >= 7 or proximoY <= 1) {
      self.rebotarVertical()
    }
    position = game.at(
      proximoX.max(0).min(12),
      proximoY.max(1).min(7)
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
}

  object textovelocidad{
    var property position = game.at(6, 0)

    method text() = "Velocidad Pelota: " + config.pelotaActual().velocidad().toString()

    method textColor() = "FFFFFFFF"
  }