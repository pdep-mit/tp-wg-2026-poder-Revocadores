import wollok.game.*
import jugadores.*
import config.*

class Limite{
    var property position

    method colisionarConPelota(pelota){
        if (config.iniciado()) {
            config.pausarJuego()
            self.darPunto()
        }
    }

    method darPunto(){}
}
class LimiteIzquierdo inherits Limite{
    override method darPunto(){
        config.rival().anotarPunto()
        config.chequearPuntos(config.rival())
    }
}

class LimiteDerecho inherits Limite{
    override method darPunto(){
        jugador1.anotarPunto()
        config.chequearPuntos(jugador1)
    }
}