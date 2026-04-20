//   PARTE 1 - REFERENCIAS
// ====================================== PERSONAJES ==========================================
object rolando {
const mochila = #{}


method encontroElArtefacto(artefacto) {
    self.sePuedeAgregar(artefacto)
    mochila.add(artefacto)
}

method sePuedeAgregar(artefacto) {
    if (mochila.size() >= 3){
        self.error("No hay espacio suficiente en la mochila.")
    }
}

method inventario() {
  return mochila
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