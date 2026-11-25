import wollok.game.*
import config.*
object gestorPantallas {
    method limpiar() {
      game.clear()
      config.configurarTeclas()
      game.boardGround("cancha.png")
  }

  method mostrarInicio(rival) {
    self.limpiar()

    const imagenInicio = if (rival.nombre() == "Jugador 2") {
      "PantallaInicioJVSJ.jpg"
    } else {
      "PantallaInicioJVSBot.jpg"
    }

    const fondoInicio = object {
      method position() = game.at(0, 0)
      method image() = imagenInicio
    }

    game.addVisual(fondoInicio)
  }

  method mostrarVictoria(ganador) {
    self.limpiar()
    
    const imagenGanador = if (ganador.nombre() == "Jugador 1") {
      "GanoJ1.jpg"
    } else if(ganador.nombre() == "Jugador 2"){
      "GanoJ2.jpg"
    }
    else{
        "Perder.jpg"
    }

    const fondoVictoria = object {
      method position() = game.at(0, 0)
      method image() = imagenGanador
    }

    game.addVisual(fondoVictoria)
  }
}