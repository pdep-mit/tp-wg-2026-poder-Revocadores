import wollok.game.*
import config.*


class Pelota {
  var property position
  var property direccionX
  var property direccionY
  var property velocidad
  var tiempoAcumulado = 0 

  method image() = "pelota.png"

  method moverSegunVelocidad(){

  tiempoAcumulado += 100
  
    const intervaloMovimiento = 400 - (velocidad * 100)

    if (tiempoAcumulado >= intervaloMovimiento) {

      tiempoAcumulado = 0

      self.mover()
    }

  }

method mover() {

  const proximoX = position.x() + direccionX
  const proximoY = position.y() + direccionY

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
  velocidad = (velocidad + cantidad).min(3)
}

  method reducirVelocidad(cantidad) {
    velocidad = (velocidad - cantidad).max(1)
  }

  method direccionAleatoria() = [1, -1].anyOne()

  
  method salioPorIzquierda() {
    return position.x() <= 0
  }

  method salioPorDerecha() {
    return position.x() >= 12
  }
  method colisionarConPelota(otraPelota) {
  }
}

object fabricanteDePelotas {
 var ultimimaAltura = 4 

 method nuevaAltura() {

    const alturasDisponibles =
      (1 .. 7).filter { altura => altura != ultimimaAltura }

   ultimimaAltura= alturasDisponibles.anyOne()

    return ultimimaAltura
  }
 method crearPelota(direccionInicial) { // crea una nueva pelota

    return new Pelota(
      position = game.at(6, self.nuevaAltura()),
      direccionX = direccionInicial,
      direccionY = [1, -1].anyOne(),
      velocidad = 1
    )
}

 method duplicarPelota(pelotaOriginal) {

    return new Pelota(
      position = pelotaOriginal.position(),
      direccionX = pelotaOriginal.direccionX(),
      direccionY = -pelotaOriginal.direccionY(),
      velocidad = pelotaOriginal.velocidad()
    )
  }
 
}

object administradorDePelotas {
 const pelotas = []


  method agregar(pelota) {

    pelotas.add(pelota)

    game.addVisual(pelota)

    game.onCollideDo(pelota, { elemento =>
      elemento.colisionarConPelota(pelota)
    })
  }


  method moverTodas() {

    pelotas.forEach { pelota =>
      pelota.moverSegunVelocidad()
    }
  }


  method duplicar(pelotaOriginal) {

    const nuevaPelota =
      fabricanteDePelotas.duplicarPelota(pelotaOriginal)

    self.agregar(nuevaPelota)
  }


  method algunaSalioPorIzquierda() {
    return pelotas.any { pelota =>
      pelota.salioPorIzquierda()
    }
  }


  method algunaSalioPorDerecha() {
    return pelotas.any { pelota =>
      pelota.salioPorDerecha()
    }
  }


  method eliminarTodas() {

    pelotas.forEach { pelota =>
      game.removeVisual(pelota)
    }

    pelotas.clear()
  }

}
  object textovelocidad{
    var property position = game.at(6, 0)

    method text() = "Velocidad Pelota: " + config.pelotaActual().velocidad().toString()

    method textColor() = "FFFFFFFF"
  }