//   PARTE 1 - REFERENCIAS
// ====================================== PERSONAJES ==========================================
object rolando {
  var morada = castillo
  var capacidadMaxDeLaMochila = 2
  const mochila = #{}
  var poderDePelea = 5         // agregado del punto 2
  var yaPeleo = false


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
    return mochila.addAll(castillo.almacen())      // const resultado = inventario.union(castillo.almacen())          ??
  }

  method tieneElArtefacto(artefactoBuscado) {
    return self.todasLasPosesiones().any({artefacto => artefacto == artefactoBuscado})
  }

  // cosas agregadas del 1.4
  method historia() {
    return mochila.addAll(castillo.almacen())   // faltan las cosas que te encontraste en el camino y no pudiste meter en la mochila...
  }

  // cosas del punto 2
  method poder() {
    return poderDePelea
  }

  method poderCalculado() {
    //poderDePelea = poderDePelea + self.mochila().map()
    if (not yaPeleo) {
      poderDePelea = poderDePelea + (mochila.map({artefacto => artefacto.poder()})).sum()     // el poder base cuando se pelea por primera vez
    } else {
        poderDePelea = (poderDePelea + 1) + (mochila.map({artefacto => artefacto.poderCalculado()})).sum()     // el poder calculado de cada artefacto después de la 1° pelea
        yaPeleo = true
    }
  }
}

// ======================================== ARTEFACTOS =============================================
object espadaDelDestino {
  var poderQueBrinda = rolando.poder()


  method espada() {
    return "Espada del Destino"
  }

  method poder() {
    return poderQueBrinda
  }

  method poderCalculado() {
    poderQueBrinda = (poderQueBrinda * 50) / 100
  }
}

object libroDeHechizos {
  method libro() {
    return "Libro de Hechizos"
  }
}

object collarDivino {
  var poderQueBrinda = 3


  method collar() {
    return "Collar Divino"
  }

  method poderCalculado(personaje) {               // ?????????
    if (not (personaje.poder() > 6)){
      // poderQueBrinda + 1 punto por c/ batalla
      poderQueBrinda + 1
    } else {
      poderQueBrinda
    }
  }

  method poder() {
    return poderQueBrinda 
  }
}

object armaduraDeAceroValyrio {
  const poderQueBrinda = 6


  method armadura() {
    return "Armadura de Acero Valyrio"
  }

  method poderCalculado() {      // nombre que no va
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
