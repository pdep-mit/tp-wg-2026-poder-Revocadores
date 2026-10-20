import wollok.game.*

class CajaPowerUp {
  var property position
}

class CajaAceleradora inherits CajaPowerUp {
  const property incremento = 1

  method image() = "caja_acelerar.png"

  method colisionarConPelota(pelota) {
    pelota.aumentarVelocidad(incremento)
  }
}

class CajaFreno inherits CajaPowerUp {
  const property decremento = 1

  method image() = "caja_freno.png"

  method colisionarConPelota(pelota) {
    pelota.reducirVelocidad(decremento)
  }
}

class CajaInversora inherits CajaPowerUp {
  method image() = "caja_inversora.png"

  method colisionarConPelota(pelota) {
    pelota.rebotarVertical()
  }
}
