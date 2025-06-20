class Personajes{

  const property fuerza
  const inteligencia
  var property rol

method cambiarRolA(unRol) {
  rol = unRol
}

method potencialDe() = 
    fuerza * 10 + rol.fuerzaAniadida()

method esGroso(){
  return rol.esGrosoEnSuRol(self) || self.esInteligente()
}

method esInteligente()

}

class Orco inherits Personajes  {
  
  override method esInteligente(){
    return false
  }

  override method potencialDe(){
    return super() + (super() * 0.10)
  }

}

class Humano inherits Personajes{

    override method esGroso(){
    return rol.esGrosoEnSuRol(self) || self.esInteligente() 
  }

  override method esInteligente(){
    return inteligencia > 50
  }
}

object guerrero {
  method fuerzaAniadida() {
    return 100
  }

  method esGrosoEnSuRol(unPersonaje){
    return unPersonaje.fuerza() > 50
  }

}

class Cazador {
  
  const mascota

  /*
  method cambiarMascotaA(unaMascota) {
    mascota = unaMascota
  }
*/

  method fuerzaAniadida() {
    return mascota.fuerzaAniadidaPorMascota()
  }

  method esGrosoEnSuRol(unPersonaje){
    return mascota.esLongeva()
  }
}


object brujo {
  
  method fuerzaAniadida(){
    return 0
  }

  method esGrosoEnSuRol(unPersonaje){
    return true
  }
}

class Mascota {
  const edad
  const fuerza 
  const tieneGarras    


  method fuerzaAniadidaPorMascota() = if(tieneGarras) fuerza *2 else fuerza

  method esLongeva(){
    return edad > 10
  }
}


class Localidad{
  
  var  ejercito

  method poderDefensivo(){
    return ejercito.poderOfensivo()
  }

  method serOcupada(unEjercito){

    ejercito = unEjercito

  }

}

class Aldea inherits Localidad{

  const maximaTropa


  method initualize() {
    if( maximaTropa< 10){
      self.error("la poblacion debe ser mayor a 10")
    }
  }

  override method serOcupada(unEjercito) {
    if(maximaTropa < unEjercito.tamaño()){
        ejercito = new Ejercito(tropa=unEjercito.losMasPoderosos())
        ejercito.quitarLosMasFuertes()
    }
    
  }

}

class Ciudad inherits Localidad{

  override method poderDefensivo(){ 
    return super() + 300
  }


}

class Ejercito{

  const tropa = []

  method poderOfensivo(){
    return tropa.sum({t => t.potencialDe()})
  }

  method invadir(unaLocalidad){
    if(self.puedeInvadir(unaLocalidad)){
      unaLocalidad.serOcupada(self)
    }
  }

  method puedeInvadir(unaLocalidad){
    return self.poderOfensivo() > unaLocalidad.poderDefensivo()
  }


  method tamaño() = tropa.size() 

  method losMasPoderosos(){
    return self.ordenadosLosMasPoderosos().take(10)
  }

  method ordenadosLosMasPoderosos(){
    return tropa.sortBy({t1,t2 => t1.potencialDe() > t2.potencialDe()})
  }

  method quitarLosMasFuertes(){
  tropa.removeAll(self.losMasPoderosos())
  }

}

