import wollok.game.*

class CajaPowerUp {
  var property position

  method colisionarConPelota(pelota) {
    self.aplicarEfecto(pelota)
    self.reaparecer()
  }

  method aplicarEfecto(pelota)

  method reaparecer() {
    position = self.posicionAleatoria()
  }

  method posicionAleatoria() {
    const nuevoX = (3 .. 9).anyOne()
    const nuevoY = (1 .. 7).anyOne()
    return game.at(nuevoX, nuevoY)
  }
}

class CajaAceleradora inherits CajaPowerUp {
  const property incremento = 1

  method image() = "caja_acelerar.png"

  override method aplicarEfecto(pelota) {
    pelota.aumentarVelocidad(incremento)
  }
}

class CajaFreno inherits CajaPowerUp {
  const property decremento = 1

  method image() = "caja_freno.png"

  override method aplicarEfecto(pelota) {
    pelota.reducirVelocidad(decremento)
  }
}

class CajaInversora inherits CajaPowerUp {
  method image() = "caja_inversora.png"

  override method aplicarEfecto(pelota) {
    pelota.rebotarVertical()
  }
}
