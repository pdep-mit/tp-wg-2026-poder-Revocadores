import wollok.game.*

class CajaPowerUp {
  var property position

  method image() = "player.png"

  method aplicarEfecto(pelota)
}

class CajaAceleradora inherits CajaPowerUp {
  const property incremento = 1

  override method aplicarEfecto(pelota) {
    pelota.aumentarVelocidad(incremento)
  }
}

class CajaFreno inherits CajaPowerUp {
  const property decremento = 1

  override method aplicarEfecto(pelota) {
    pelota.reducirVelocidad(decremento)
  }
}

class CajaInversora inherits CajaPowerUp {
  override method aplicarEfecto(pelota) {
    pelota.rebotarVertical()
  }
}
