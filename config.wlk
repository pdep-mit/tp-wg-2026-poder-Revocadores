import wollok.game.*
import jugadores.*
import pelota.*
import cajas.*
	
object config{
	//Estado del juego
	var property iniciado = false

	method configurar(){
		
    const botonJugar = object {
        var property position = game.at(6, 2)
        method text() = "Presiona ESPACIO para jugar"

		method textColor() = "FFFFFFFF"
    }

	// Visuales de jugadores y pelota
	game.addVisual(jugador1)
	game.addVisual(jugador2)
	game.addVisual(pelota)
	game.addVisual(marcadorJugador1)
	game.addVisual(marcadorJugador2)
	game.addVisual(botonJugar)

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
        if (not iniciado) {
            iniciado = true
            game.removeVisual(botonJugar)
        }
    })

	// Colisiones polimorficas: cualquier elemento que choca con la pelota entiende colisionarConPelota
	game.onCollideDo(pelota, { elemento =>
		elemento.colisionarConPelota(pelota)
	})

	game.onCollideDo(pelota, { elemento => elemento.desaparecer()})

	// Bucle de juego: movimiento de pelota y chequeo de tantos
	game.onTick(300, "moverPelota", {
 	if (iniciado) {
    pelota.mover()

    if (pelota.position().x() == 0 and pelota.direccionX() < 0) {
      iniciado = false
      jugador2.anotarPunto()

      pelota.reiniciar2(game.at(6, 4))

      game.schedule(2000, {
        iniciado = true
      })

    } else if (pelota.position().x() == 12 and pelota.direccionX() > 0) {
      iniciado = false
      jugador1.anotarPunto()

      pelota.reiniciar1(game.at(6, 4))

      game.schedule(500, {
        iniciado = true
      })
    }
  }
								})
	}
}
