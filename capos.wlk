//   PARTE 1 - REFERENCIAS
// ====================================== PERSONAJES ==========================================
object rolando {
  var mochila = 2
  const inventario = #{}


  method mochila(tamaño) {
    mochila = tamaño
  }

  method encontroElArtefacto(artefacto) {
    self.sePuedeAgregar(artefacto)
    inventario.add(artefacto)
  }

  method sePuedeAgregar(artefacto) {
    if (inventario.size() == mochila){
        self.error("No hay espacio suficiente en la mochila.")
    }
  }

  method inventario() {
    return inventario
  }

  // cosas agregadas del ej 1.2
  method llegarAlCastillo() {
    //castillo.depositar(inventario)     ---> así no funciona
    inventario.forEach({ artefacto => castillo.depositar(artefacto) })
    inventario.clear()
  }

  // cosas agregadas del 1.3
  method todasLasPosesiones() {
    return inventario.addAll(castillo.almacen())      // const resultado = inventario.union(castillo.almacen())          ??
  }

  method tieneElArtefacto(artefactoBuscado) {
    return self.todasLasPosesiones().any({artefacto => artefacto == artefactoBuscado})
  }

  // cosas agregadas del 1.4
  method historia() {
    return inventario.addAll(castillo.almacen())   // faltan las cosas que te encontraste en el camino y no pudiste meter en la mochila...
  }
}

// ======================================== ARTEFACTOS =============================================
object espadaDelDestino {
  method espada() {
    return "Espada del Destino"
  }
}

object libroDeHechizos {
  method libro() {
    return "Libro de Hechizos"
  }
}

object collarDivino {
  method collar() {
    return "Collar Divino"
  }
}

object armaduraDeAceroValyrio {
  method armadura() {
    return "Armadura de Acero Valyrio"
  }
}

// ============================================= CASTILLO ================================================
object castillo {
  const almacen = #{}


  method almacen() {
    return almacen
  } 

  method depositar(artefacto) {
    almacen.add(artefacto)
  }
}