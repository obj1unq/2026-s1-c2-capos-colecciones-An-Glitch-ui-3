//   PARTE 1 - REFERENCIAS
// ====================================== PERSONAJES ==========================================
object rolando {
  var capacidadMaxDeLaMochila = 2
  const mochila = #{}
  const poderBase = 5         // agregado del punto 2
  //var poderPelea = poderBase      // agregado del punto 2


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

  // cosas agregadas del ej 1.2
  method llegarA() {
    //mochila.forEach({ artefacto => morada.depositar(artefacto) })        // con el setter la morada cambiaría...
    castillo.depositar(mochila)
    mochila.clear()
  }

  // cosas agregadas del 1.3
  method todasLasPosesiones() {
    return mochila.addAll(castillo.almacen())      // const resultado = inventario.union(castillo.almacen())          ??
  }

  method tieneElArtefacto(artefactoBuscado) {
    return self.todasLasPosesiones().any {artefacto => artefacto == artefactoBuscado}
  }

  // cosas agregadas del 1.4
  method historia() {
    return mochila.addAll(castillo.almacen())   // faltan las cosas que te encontraste en el camino y no pudiste meter en la mochila...
  }

  // cosas del punto 2
  method poderBase() {
    return poderBase
  }

  method poderPelea() {    //---------------------------> poder de pelea
    return poderBase + (mochila.map({artefacto => artefacto.poder()})).sum()     // el poder base cuando se pelea por primera vez
  }

  // ????????????
  method pelearBatalla() {
    (poderBase + 1) + (mochila.map({artefacto => artefacto.poder()})).sum() 
    //return self.poderPelea() + (poderBase + 1) + (mochila.map({artefacto => artefacto.poderCalculado()})).sum() 
  }
}
          //  method artefactoMasPoderosoDeLaMorada { return morada.artefactoaMasPoderoso(self) }
          //  method artefactoMasPoderoso(personaje) { return artefacto.max({a = a.poder(personaje)}) }
// ======================================== ARTEFACTOS =============================================
object espadaDelDestino {
  var yaFueUsado = false


  method espada() {
    return "Espada del Destino"
  }

  method poder() {
    return if (not yaFueUsado) {
      rolando.poderBase()
  } else {
    rolando.poderBase() / 2
    yaFueUsado = true
  }
  }
}

object collarDivino {
  const poderQueBrinda = 3
  var cantDeUsos = 0


  method collar() {
    return "Collar Divino"
  }

  method poder() {               // ?????????
    return if (rolando.poderBase() > 6){
      poderQueBrinda + cantDeUsos
      //cantDeUsos = 1 + cantDeUsos
    } else {
        poderQueBrinda
      }
  }

  method usos() {
    cantDeUsos = cantDeUsos + 1
  }
}

object armaduraDeAceroValyrio {
  const poderQueBrinda = 6


  method armadura() {
    return "Armadura de Acero Valyrio"
  }

  method poder() { 
    return poderQueBrinda
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
}

// Parte 2  -  Mensajes con Bloques
object bendicion {
  method poder(){ 
    return 4 
  } 
}

object invisibilidad { 
  method poder(personaje){ 
    return personaje.poderBase() 
  } 
}

object invocacion { 
  method poder(personaje){ 
    return personaje.morada().artefactoMasPoderoso(personaje).poder()    // morada = castillo
  } 
}


//===============================
object libroDeHechizos {
  var poderQueBrinda = 0
  const hechizos = []


  method libro() {
    return "Libro de Hechizos"
  }
}
//===============================
