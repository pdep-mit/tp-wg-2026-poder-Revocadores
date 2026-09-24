import wollok.game.*

object pelota {
  var property position = game.at(5, 5)
  var property direccionX = 1
  var property direccionY = 1
  var property velocidad = 1

  method image() = "player.png"

  method mover() {
    position = game.at(
      position.x() + (direccionX * velocidad),
      position.y() + (direccionY * velocidad)
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
