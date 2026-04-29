//   PARTE 1 - REFERENCIAS
// ====================================== PERSONAJE ==========================================
object rolando {
  var capacidadMaxDeLaMochila = 2
  const mochila = #{}
  var morada = castillo
  var poderBase = 5         // agregado del punto 2
  //var poderPelea = poderBase      // agregado del punto 2
  const enemigos = [caterina, archibaldo, astra]


  method capacidad(tamaño) {
    capacidadMaxDeLaMochila = tamaño
  }

  method encontroElArtefacto(artefacto) {
    self.sePuedeAgregar(artefacto)
    mochila.add(artefacto)
  }

  method sePuedeAgregar(artefacto) {
    if (capacidadMaxDeLaMochila == mochila.size()){
    // if (capacidadMaxDeLaMochila.capacidad()){
        //idem abajo
    //}
        self.error("No hay espacio suficiente en la mochila.")
    }
  }

  method mochila() {
    return mochila
  }

  method morada(lugar) {
    morada = lugar
  }

  // cosas agregadas del ej 1.2
  method llegarA() {
    //mochila.forEach({ artefacto => morada.depositar(artefacto) })        // con el setter la morada cambiaría...
    morada.depositar(mochila)
    mochila.clear()
  }

  // cosas agregadas del 1.3
  method todasLasPosesiones() {
    return mochila.addAll(morada.almacen())      // const resultado = inventario.union(morada.almacen())          ??
  }

  method tieneElArtefacto(artefactoBuscado) {
    return self.todasLasPosesiones().any {artefacto => artefacto == artefactoBuscado}
  }

  // cosas agregadas del 1.4
  method historia() {
    return mochila.addAll(morada.almacen())   // faltan las cosas que te encontraste en el camino y no pudiste meter en la mochila...
  }

  // cosas del punto 2
  method poderBase() {
    return poderBase
  }

  method poderPelea() {    //---------------------------> poder de pelea
    return poderBase + (mochila.map({artefacto => artefacto.poderPara(self)})).sum()     // el poder base cuando se pelea por primera vez
  }

  method pelearBatalla() {
    mochila.forEach({ artefacto => artefacto.usarse() })
    poderBase = poderBase + 1
  }

  // cosas agregadas del 2.3
  method enemigosPuedeVencer() {
    return enemigos.filter({pj => self.poderPelea() > pj.poderPelea()})
  }

  method moradasConquistables() {
    return self.enemigosPuedeVencer().map({pj => pj.viveEn()})
  }

  // cosas agregadas del 2.4
  method esPoderoso() {
    return self.enemigosPuedeVencer().size() == 3
  }

  // cosas agregadas del 2.5
  method artefactoFatal(enemigo) {
    return mochila.findOrElse(
      { art => (self.poderBase() + art.poderPara(self)) > enemigo.poderPelea() },
      { self.error("Rolando no cuenta con un artefacto fatal :( ") }
    )
  }
}

// ======================================== ARTEFACTOS =============================================
object espadaDelDestino {
  var yaFueUsado = false


  method poderPara(personaje) {
    return if (not yaFueUsado) {
      personaje.poderBase()
  } else {
    personaje.poderBase() / 2
    //yaFueUsado = true
    }
  }

  method usarse() {
    yaFueUsado = true
  }
}

object collarDivino {
  const poderQueBrinda = 3
  var cantDeUsos = 0


  method poderPara(personaje) {
    return if (personaje.poderBase() > 6){
      poderQueBrinda + cantDeUsos
      //cantDeUsos = 1 + cantDeUsos
    } else {
        poderQueBrinda
      }
  }

  method usarse() {
    cantDeUsos = cantDeUsos + 1
  }
}

object armaduraDeAceroValyrio {
  const poderQueBrinda = 6


  method poderPara(personaje) {
    return poderQueBrinda
  }

  method usarse() {
    // nada, no sé qué tan feo es hacer un método vacío 
  }
}

object libroDeHechizos {
  //var poderQueBrinda = 0
  const hechizos = []


  method poderPara(personaje) {
    //return hechizos.size()
    return if (hechizos.size() >= 1){
      hechizos.first()
    } else {
      0
    }
  }

  method agregarH(hechizo) {
    hechizos.add(hechizo)
  }

  method usarse() {
    hechizos.remove(hechizos.first())
  }
}

// ============================================= CASTILLO ================================================
object castillo {
  const almacen = #{}


  method almacen() {
    return almacen
  } 

  method depositar(artefactos) {
    almacen.add(artefactos)
  }

  method artefactoMasPoderoso(personaje) {
    return almacen.max({ artefacto => artefacto.poderPara(personaje) })
  }
}

// Parte 2  -  Mensajes con Bloques
// ========================================== HECHIZOS ================================================
object bendicion {
  method poderPara(personaje){ 
    return 4 
  } 
}

object invisibilidad { 
  method poderPara(personaje){ 
    return personaje.poderBase() 
  } 
}

object invocacion { 
  method poderPara(personaje){ 
    //return personaje.morada().artefactoMasPoderoso(personaje).poder()      // morada = castillo
    return (castillo.artefactoMasPoderoso(personaje)).poderPara(personaje)
  } 
}

          //  method artefactoMasPoderosoDeLaMorada { return morada.artefactoMasPoderoso(self) }
          //  method artefactoMasPoderoso(personaje) { return artefacto.max({a = a.poder(personaje)}) }

// ==================================== ENEMIGOS ======================================
object caterina {

  method poderPelea() {
    return 28
  }

  method viveEn() {
    return fortalezaDeAcero
  } 
}
object archibaldo {

  method poderPelea() {
    return 16
  }

  method viveEn() {
    return palacioDeMarmol
  } 
}
object astra {

  method poderPelea() {
    return 14
  }

  method viveEn() {
    return torreDeMarfil
  } 
}

// ========================= VIVIENDAS ========================
object fortalezaDeAcero {
  var dueñx = caterina


  method acaVive() {
    return dueñx
  }

  method propietario(unDueñx) {
    dueñx = unDueñx
  }
}

object palacioDeMarmol {
  var dueñx = archibaldo


  method acaVive() {
    return dueñx
  }

  method propietario(unDueñx) {
    dueñx = unDueñx
  }
}

object torreDeMarfil {
  var dueñx = astra


  method acaVive() {
    return dueñx
  }

  method propietario(unDueñx) {
    dueñx = unDueñx
  }
}