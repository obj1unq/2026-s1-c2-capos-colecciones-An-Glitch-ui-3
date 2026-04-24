//   PARTE 1 - REFERENCIAS
// ====================================== PERSONAJE ==========================================
object rolando {
  var capacidadMaxDeLaMochila = 2
  const mochila = #{}
  var morada = castillo
  var poderBase = 5         // agregado del punto 2
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
}

// ======================================== ARTEFACTOS =============================================
object espadaDelDestino {
  var yaFueUsado = false


  method espada() {
    return "Espada del Destino"
  }

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


  method collar() {
    return "Collar Divino"
  }

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


  method armadura() {
    return "Armadura de Acero Valyrio"
  }

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


  method libro() {
    return "Libro de Hechizos"
  }

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

  method bendicion() {
    return "Hechizo de Bendición"
  }
}

object invisibilidad { 
  method poderPara(personaje){ 
    return personaje.poderBase() 
  } 

  method invisibilidad() {
    return "Hechizo de Invisibilidad"
  }
}

object invocacion { 
  method poderPara(personaje){ 
    //return personaje.morada().artefactoMasPoderoso(personaje).poder()      // morada = castillo
    return (castillo.artefactoMasPoderoso(personaje)).poderPara(personaje)
  } 

  method invocacion() {
    return "Hechizo de Invocación"
  }
}

          //  method artefactoMasPoderosoDeLaMorada { return morada.artefactoMasPoderoso(self) }
          //  method artefactoMasPoderoso(personaje) { return artefacto.max({a = a.poder(personaje)}) }

// ==================================== ENEMIGOS ======================================
object caterina {
  method poder() {
    return 28
  }

  method viveEn() {
    return "Fortaleza de Acero"
  } 
}

object archibaldo {
  method poder() {
    return 16
  }

  method viveEn() {
    return "Palacio de Mármol"
  } 
}

object astra {
  method poder() {
    return 14
  }

  method viveEn() {
    return "Torre de Marfil"
  } 
}