import pelota.*
import wollok.game.*

class CajaPowerUp {
  var property position

  method colisionarConPelota(pelota){

      self.aplicarEfecto(pelota)

    
    game.removeVisual(self)

    game.schedule(3000, {
    self.instanciarCaja()
    })
  }

  method posicionAleatoria(){
    const nuevoX = (2 .. game.width() - 3).anyOne()
    const nuevoY = (1 .. game.height() - 2).anyOne()
    return game.at(nuevoX, nuevoY)
  }
 method aplicarEfecto(pelota)
  method instanciarCaja()
}

object fabricaCajas {

  method crearAceleradora(posicion, incremento) {

    const nuevaCaja = new CajaAceleradora(
      position = posicion,
      incremento = incremento
    )

    game.addVisual(nuevaCaja)
  }


  method crearFreno(posicion, decremento) {

    const nuevaCaja = new CajaFreno(
      position = posicion,
      decremento = decremento
    )

    game.addVisual(nuevaCaja)
  }


  method crearInversora(posicion) {

    const nuevaCaja = new CajaInversora(
      position = posicion
    )

    game.addVisual(nuevaCaja)
  }


  // Nueva fábrica para la caja duplicadora.
  method crearDuplicadora(posicion) {

    const nuevaCaja = new CajaDuplicadora(
      position = posicion
    )

    game.addVisual(nuevaCaja)
  }
}


class CajaAceleradora inherits CajaPowerUp {
  const property incremento = 1

  method image() = "caja_acelerar.png"

   override method aplicarEfecto(pelota) {
    pelota.aumentarVelocidad(incremento)
  }

  override method instanciarCaja(){
     fabricaCajas.crearAceleradora(
      self.posicionAleatoria(),
      incremento
    )
  }
}

class CajaFreno inherits CajaPowerUp {
  const property decremento = 1

  method image() = "caja_freno.png"

    override method aplicarEfecto(pelota) {
    pelota.reducirVelocidad(decremento)
  }

  override method instanciarCaja(){
     fabricaCajas.crearFreno(
      self.posicionAleatoria(),
      decremento
    )
  }
}

class CajaInversora inherits CajaPowerUp {
  method image() = "caja_inversora.png"

  override method aplicarEfecto(pelota) {
    pelota.rebotarVertical()
  }

 override method instanciarCaja() {
  fabricaCajas.crearInversora(
    self.posicionAleatoria()
  )
}
}

class CajaDuplicadora inherits CajaPowerUp {

method image() = "caja_duplicadora.png"

  override method aplicarEfecto(pelota) {

    administradorDePelotas.duplicar(pelota)
  }


  override method instanciarCaja() {

    fabricaCajas.crearDuplicadora(
      self.posicionAleatoria()
    )
  }

}