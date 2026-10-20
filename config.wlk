import wollok.game.*
import jugadores.*
import pelota.*
import cajas.*

object config {
  var property iniciado = false
  var property finalizado = false
  var property pelotaActual = null
  const property puntosParaGanar = 5
  const property jugadores = [jugador1, jugador2]
  const property cajas = [
    new CajaAceleradora(position = game.at(5, 7), incremento = 1),
    new CajaInversora(position = game.at(5, 3)),
    new CajaFreno(position = game.at(9, 2), decremento = 1)
  ]

  const cartelControles = object {
    var property position = game.at(3, 3)
    method text() = "J1: [W] [S]  |  J2: [Arriba] [Abajo]"
    method textColor() = "FFFFFFFF"
    method colisionarConPelota(pelota) {}
  }

  const botonJugar = object {
    var property position = game.at(2, 2)
    method text() = "Gana el primero a 5 pts | ESPACIO para jugar"
    method textColor() = "FFFF00FF"
    method colisionarConPelota(pelota) {}
  }

  const cartelFinDeJuego = object {
    var property position = game.at(2, 4)
    var property texto = ""
    method text() = texto
    method textColor() = "FFFF00FF"
    method colisionarConPelota(pelota) {}
  }

  method crearPelota(direccionInicial) {
    pelotaActual = new Pelota(
      position = game.at(6, 4),
      direccionX = direccionInicial,
      direccionY = [1, -1].anyOne()
    )
    game.addVisual(pelotaActual)

    game.onCollideDo(pelotaActual, { elemento =>
      elemento.colisionarConPelota(pelotaActual)
    })
  }

  method hayGanador() = jugadores.any({ j => j.esGanador(puntosParaGanar) })

  method ganador() = jugadores.find({ j => j.esGanador(puntosParaGanar) })

  method terminarPartida() {
    finalizado = true
    iniciado = false
    cartelFinDeJuego.texto("¡Gano " + self.ganador().nombre() + "! Presiona ESPACIO o R para reiniciar")
    game.addVisual(cartelFinDeJuego)
  }

  method reiniciarPartida() {
    jugadores.forEach({ j => j.reiniciarPuntos() })
    cajas.forEach({ c => c.reaparecer() })
    game.removeVisual(cartelFinDeJuego)
    finalizado = false
    self.crearPelota(1)
    iniciado = true
  }

  method anotarPunto(jugador, direccionSaque) {
    iniciado = false
    jugador.anotarPunto()
    pelotaActual.morir()

    if (self.hayGanador()) {
      self.terminarPartida()
    } else {
      self.crearPelota(direccionSaque)
      game.schedule(1500, {
        if (not finalizado) iniciado = true
      })
    }
  }

  method verificarGol() {
    if (pelotaActual.salioPorIzquierda()) {
      self.anotarPunto(jugador2, -1)
    } else if (pelotaActual.salioPorDerecha()) {
      self.anotarPunto(jugador1, 1)
    }
  }

  method configurar() {
    // Visuales estables
    game.addVisual(jugador1)
    game.addVisual(jugador2)
    game.addVisual(marcadorJugador1)
    game.addVisual(marcadorJugador2)
    game.addVisual(botonJugar)
    game.addVisual(cartelControles)
    game.addVisual(textovelocidad)

    // Cajas polimorficas
    cajas.forEach({ c => game.addVisual(c) })

    // Primera pelota
    self.crearPelota(1)

    // Controles de paletas
    keyboard.w().onPressDo({ if (iniciado and not finalizado) jugador1.subir() })
    keyboard.s().onPressDo({ if (iniciado and not finalizado) jugador1.bajar() })
    keyboard.up().onPressDo({ if (iniciado and not finalizado) jugador2.subir() })
    keyboard.down().onPressDo({ if (iniciado and not finalizado) jugador2.bajar() })

    // Control de inicio y reinicio (acepta ESPACIO o R)
    keyboard.space().onPressDo({
      if (finalizado) {
        self.reiniciarPartida()
      } else if (not iniciado) {
        iniciado = true
        game.removeVisual(botonJugar)
        game.removeVisual(cartelControles)
      }
    })

    keyboard.r().onPressDo({
      if (finalizado) self.reiniciarPartida()
    })

    // Bucle de juego: movimiento de pelota y chequeo de tantos sin if anidado procedural
    game.onTick(300, "moverPelota", {
      if (iniciado and not finalizado) {
        pelotaActual.mover()
        self.verificarGol()
      }
    })
  }
}
