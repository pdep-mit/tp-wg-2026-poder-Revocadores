import wollok.game.*

object pelota {
  var property position = game.at(5, 5)
  var property direccionX = 1
  var property direccionY = 1
  var property velocidad = 1

  method image() = "pelota.png"

  method mover() {
    const proximoY = position.y() + direccionY
    if (proximoY > 9 or proximoY < 0) {
      self.rebotarVertical()
    }
    position = game.at(
      (position.x() + direccionX).max(0).min(9),
      (position.y() + direccionY).max(0).min(9)
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

  method reiniciar(posicionInicial) {
    position = posicionInicial
    velocidad = 1
    direccionX = 1
    direccionY = 1
  }
}
