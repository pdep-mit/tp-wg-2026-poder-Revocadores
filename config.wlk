import wollok.game.*
import jugadores.*
import pelota.*
import cajas.*
	
object config{
	//Estado del juego
	var property iniciado = false
	var property pelotaActual = null
	var property partidaTerminada = false
  	var property botonJugar = null
  	var property mensajeFinal = null

	
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

  	game.onCollideDo(pelotaActual, { elemento =>
    elemento.desaparecer()
	})
	}

	method terminarPartida() {
    iniciado = false
    partidaTerminada = true

    game.removeVisual(pelotaActual)

    mensajeFinal = object {
      var property position = game.at(6, 5)

      method text() =
        if (jugador1.puntos() >= 5)
          "¡Gano el Jugador 1! Presiona ESPACIO para jugar devuelta"
        else
          "¡Gano el Jugador 2! Presiona ESPACIO para jugar devuelta"

      method textColor() = "FFFFFF"
    }

    game.addVisual(mensajeFinal)
  	}

	method reiniciarPartida() {
    game.removeVisual(mensajeFinal)

    jugador1.reiniciarPuntos()
    jugador2.reiniciarPuntos()

    partidaTerminada = false
    
	self.crearPelota(1)
    game.schedule(2000, {
    if (not partidaTerminada) {
      iniciado = true
    }
  	})
  	}

	method configurar(){
		
    botonJugar = object {
        var property position = game.at(6, 2)
        method text() = "Presiona ESPACIO para jugar"

		method textColor() = "FFFFFFFF"
    }

	// Visuales de jugadores y pelota
	game.addVisual(jugador1)
	game.addVisual(jugador2)
	game.addVisual(marcadorJugador1)
	game.addVisual(marcadorJugador2)
	game.addVisual(botonJugar)
	self.crearPelota(1)

	// Cajas en cancha (polimorfismo con pelota)
	const cajaAceleradora = new CajaAceleradora(position = game.at(5, 7), incremento = 1)
	const cajaInversora = new CajaInversora(position = game.at(5, 3))
	const cajaFreno = new CajaFreno(position = game.at(9, 2), decremento = 1)
	game.addVisual(cajaAceleradora)
	game.addVisual(cajaInversora)
	game.addVisual(cajaFreno)
	game.addVisual(textovelocidad)

	// Controles
	keyboard.w().onPressDo({ if(iniciado) jugador1.subir() })
	keyboard.s().onPressDo({ if(iniciado) jugador1.bajar() })
	keyboard.up().onPressDo({ if(iniciado) jugador2.subir() })
	keyboard.down().onPressDo({ if(iniciado) jugador2.bajar() })

	keyboard.space().onPressDo({
  	if (partidaTerminada) {
    self.reiniciarPartida()
  	} else if (not iniciado) {
    iniciado = true
    game.removeVisual(botonJugar)
 	 }
	})

	// Bucle de juego: movimiento de pelota y chequeo de tantos
	 game.onTick(300, "moverPelota", {
      if (iniciado and not partidaTerminada) {
        pelotaActual.mover()

        if (pelotaActual.position().x() == 0 and
            pelotaActual.direccionX() < 0) {

          iniciado = false
          jugador2.anotarPunto()

          if (jugador2.puntos() >= 5) {
            self.terminarPartida()
          } else {
            game.removeVisual(pelotaActual)
            self.crearPelota(-1)

            game.schedule(1000, {
              if (not partidaTerminada) {
                iniciado = true
              }
            })
          }

        } else if (pelotaActual.position().x() == 12 and
                   pelotaActual.direccionX() > 0) {

          iniciado = false
          jugador1.anotarPunto()

          if (jugador1.puntos() >= 5) {
            self.terminarPartida()
          } else {
            game.removeVisual(pelotaActual)
            self.crearPelota(1)

            game.schedule(1000, {
              if (not partidaTerminada) {
                iniciado = true
              }
            })
          }
        }
      }
    })
  }
}

