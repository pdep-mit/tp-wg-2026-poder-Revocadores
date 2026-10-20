import wollok.game.*

class CajaPowerUp {
  var property position

  method desaparecer(){
    game.removeVisual(self)
    self.instanciarCaja()
  }

  method posicionAleatoria(){
    const nuevoX = (1 .. game.width() - 2).anyOne()
    const nuevoY = (1 .. game.height() - 2).anyOne()
    return game.at(nuevoX, nuevoY)
  }

  method instanciarCaja(){}
}

class CajaAceleradora inherits CajaPowerUp {
  const property incremento = 1

  method image() = "caja_acelerar.png"

  method colisionarConPelota(pelota) {
    pelota.aumentarVelocidad(incremento)
  }

  override method instanciarCaja(){
    const cajaAceleradora = new CajaAceleradora(position = self.posicionAleatoria(), incremento = 1)
    game.addVisual(cajaAceleradora)
  }
}

class CajaFreno inherits CajaPowerUp {
  const property decremento = 1

  method image() = "caja_freno.png"

  method colisionarConPelota(pelota) {
    pelota.reducirVelocidad(decremento)
  }

  override method instanciarCaja(){
    const cajaFreno = new CajaFreno(position = self.posicionAleatoria(), decremento = 1)
    game.addVisual(cajaFreno)
  }
}

class CajaInversora inherits CajaPowerUp {
  method image() = "caja_inversora.png"

  method colisionarConPelota(pelota) {
    pelota.rebotarVertical()
  }

  override method instanciarCaja(){
    const cajaInversora = new CajaInversora(position = self.posicionAleatoria())
    game.addVisual(cajaInversora)
  }
}
