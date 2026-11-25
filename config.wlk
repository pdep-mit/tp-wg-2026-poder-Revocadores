import limites.*
import wollok.game.*
import jugadores.*
import pelota.*
import cajas.*
import pantallas.*

object config {
  //Estado del juego
  var property iniciado = false
  var property partidaTerminada = false
  var property botonJugar = null
  var property mensajeFinal = null
  var property rival = jugador2Humano

  method mostrarPantallaInicio(){
    self.pausarJuego()
    administradorDePelotas.eliminarTodas()
    administradorDeCajas.eliminarCajas()
    
    iniciado = false
    partidaTerminada = false

    gestorPantallas.mostrarInicio(rival)


    if (game.hasVisual(rival)) {
      game.removeVisual(rival)
    }
  }

  method iniciarJuego(direccionInicial) {
    game.removeTickEvent("moverPelota")
    
    iniciado = true
    partidaTerminada = false

    gestorPantallas.mostrarCancha()

    // Visuales de jugadores, marcadores y elementos de juego
    game.addVisual(jugador1)
    game.addVisual(rival)
    game.addVisual(marcadorJugador1)
    game.addVisual(marcadorJugador2)
    game.addVisual(textovelocidad)

    self.crearLimites()
    
    administradorDePelotas.eliminarTodas()
    self.crearPelota(direccionInicial)
    self.configurarCajas()

    game.onTick(50, "moverPelota", {
      self.actualizarJuego()
    })
  }

  method configurarCajas() {
    administradorDeCajas.eliminarCajas()
    
    // Cajas en cancha
    const cajaAceleradora = new CajaAceleradora(position = game.at(8, 2), incremento = 1)
    const cajaInversora = new CajaInversora(position = game.at(5, 3))
    const cajaFreno = new CajaFreno(position = game.at(7, 7), decremento = 1)
    const cajaDuplicadora = new CajaDuplicadora(position = game.at(4, 6))
    
    administradorDeCajas.agregar(cajaAceleradora)
    administradorDeCajas.agregar(cajaInversora)
    administradorDeCajas.agregar(cajaFreno)
    administradorDeCajas.agregar(cajaDuplicadora)
  }

  method configurarTeclas() {
    keyboard.w().onPressDo({ if (iniciado) jugador1.subir() })
    keyboard.s().onPressDo({ if (iniciado) jugador1.bajar() })
    keyboard.up().onPressDo({ if (iniciado) rival.moverManualArriba() })
    keyboard.down().onPressDo({ if (iniciado) rival.moverManualAbajo() })
    keyboard.m().onPressDo({ self.alternarModo() })
    keyboard.space().onPressDo({
      if (partidaTerminada) {
        jugador1.reiniciarPuntos()
        rival.reiniciarPuntos()
        self.mostrarPantallaInicio()
      } else if (not iniciado) {
        self.iniciarJuego(1)
      }
    })
  }

  method actualizarJuego() {
    administradorDePelotas.moverTodas()
    administradorDePelotas.verificarColisiones(administradorDeCajas)
    rival.actualizarEnTick(administradorDePelotas.pelotaPrincipal())
  }

  method pausarJuego() {
    iniciado = false
    game.removeTickEvent("moverPelota")
  }

  method chequearPuntos(jugadorAnotador) {
    if (iniciado) {
      self.pausarJuego()
    }

    if (jugadorAnotador.gano()) {
      self.terminarPartida(jugadorAnotador)
    } else {
      game.sound("punto.wav").play()
      administradorDePelotas.eliminarTodas()
      const direccionInicial = jugadorAnotador.direccionSaque()
      game.schedule(1000, {
        if (not partidaTerminada) {
          self.iniciarJuego(direccionInicial)
        }
      })
    }
  }

  method crearLimites() {
    (0..9).forEach { y =>
      game.addVisual(new LimiteIzquierdo(position = game.at(0, y)))
      game.addVisual(new LimiteDerecho(position = game.at(12, y)))
    }
  }

  method crearPelota(direccionInicial) {
    administradorDePelotas.agregar(fabricanteDePelotas.crearPelota(direccionInicial))
  }

  method terminarPartida(ganador) {
    iniciado = false
    partidaTerminada = true
    self.pausarJuego()
    game.removeTickEvent("moverPelota")
    administradorDePelotas.eliminarTodas()
    administradorDeCajas.eliminarCajas()
    game.sound("victoria.wav").play()

    gestorPantallas.mostrarVictoria(ganador)
  }

  method reiniciarPartida() {
    game.removeVisual(mensajeFinal)
    jugador1.reiniciarPuntos()
    rival.reiniciarPuntos()
    administradorDePelotas.eliminarTodas()
    game.schedule(2000, {
      self.iniciarJuego(1)
    })
  }

  method alternarModo() {
    if (not iniciado and not partidaTerminada) {
      rival = rival.siguienteRival()
      gestorPantallas.mostrarInicio(rival)
    }
  }

  method configurar() {
    botonJugar = object {
      var property position = game.at(6, 2)
      method text() = "Presiona ESPACIO para jugar| M: cambiar modo"
      method textColor() = "FFFFFF"
    }

    // Visuales de jugadores y pelota
    game.addVisual(jugador1)
    game.addVisual(rival)
    game.addVisual(marcadorJugador1)
    game.addVisual(marcadorJugador2)
    game.addVisual(botonJugar)
    self.crearPelota(1)

    // Cajas en cancha (polimorfismo con pelota)
    const cajaAceleradora = new CajaAceleradora(position = game.at(8, 2), incremento = 1)
    const cajaInversora = new CajaInversora(position = game.at(5, 3))
    const cajaFreno = new CajaFreno(position = game.at(7, 7), decremento = 1)
    const cajaDuplicadora = new CajaDuplicadora(position = game.at(4, 6))
    administradorDeCajas.agregar(cajaAceleradora)
    administradorDeCajas.agregar(cajaInversora)
    administradorDeCajas.agregar(cajaFreno)
    administradorDeCajas.agregar(cajaDuplicadora)
    game.addVisual(textovelocidad)

    // Controles
    keyboard.w().onPressDo({ if (iniciado) jugador1.subir() })
    keyboard.s().onPressDo({ if (iniciado) jugador1.bajar() })
    keyboard.m().onPressDo({ self.alternarModo() })
    keyboard.up().onPressDo({ if (iniciado) rival.moverManualArriba() })
    keyboard.down().onPressDo({ if (iniciado) rival.moverManualAbajo() })

    self.crearLimites()

    keyboard.space().onPressDo({
      if (partidaTerminada) {
        self.reiniciarPartida()
      } else if (not iniciado) {
        self.iniciarJuego(1)
        game.removeVisual(botonJugar)
      }
    })
  }
}