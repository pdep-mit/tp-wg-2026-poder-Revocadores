import pelota.*
import wollok.game.*

class CajaPowerUp {
  var property position

  method colisionarConPelota(pelota) {
    game.sound("powerup.wav").play()
    self.aplicarEfecto(pelota)
    game.removeVisual(self)
    game.schedule(3000, {
      self.reaparecer()
    })
  }

  method reaparecer() {
    game.addVisual(self.crearEn(self.posicionAleatoria()))
  }

  method posicionAleatoria() {
    const nuevoX = (2 .. game.width() - 3).anyOne()
    const nuevoY = (1 .. game.height() - 2).anyOne()
    return game.at(nuevoX, nuevoY)
  }

  method aplicarEfecto(pelota)
  method crearEn(posicion)
}

class CajaAceleradora inherits CajaPowerUp {
  const property incremento = 1

  method image() = "caja_acelerar.png"

  override method aplicarEfecto(pelota) {
    pelota.aumentarVelocidad(incremento)
  }

  override method crearEn(posicion) = new CajaAceleradora(position = posicion, incremento = incremento)
}

class CajaFreno inherits CajaPowerUp {
  const property decremento = 1

  method image() = "caja_freno.png"

  override method aplicarEfecto(pelota) {
    pelota.reducirVelocidad(decremento)
  }

  override method crearEn(posicion) = new CajaFreno(position = posicion, decremento = decremento)
}

class CajaInversora inherits CajaPowerUp {
  method image() = "caja_inversora.png"

  override method aplicarEfecto(pelota) {
    pelota.rebotarVertical()
  }

  override method crearEn(posicion) = new CajaInversora(position = posicion)
}

class CajaDuplicadora inherits CajaPowerUp {
  method image() = "caja_duplicadora.png"

  override method aplicarEfecto(pelota) {
    administradorDePelotas.duplicar(pelota)
  }

  override method crearEn(posicion) = new CajaDuplicadora(position = posicion)
}