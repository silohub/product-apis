Paths
=====

Se organizan las definiciones de servicios en esta carpeta. Se referencian estos archivos principales `api-*.yaml` y `bff-*.yaml`.

Los subdirectorios agrupan por negocio y tienen un archivo por cada path principal

### Ejemplos

Algunos ejemplos de como está estructurado
```yaml
paths:
  /bff/retailers/v0/{retailerCode}/countries:
    $ref: paths/retailers/core/SearchCountries.yaml
```

#### ¡Ojo con los dos puntos!!

Como hay un montón de sub-carpetas, y se referencian en forma relativa dentro de los archivos,
hay que tener cuidado con los paths relativos...

Ejemplo
```
file: /paths/retailers/core/SearchCountries.yaml

# extracto del archivo
  parameters:
    - $ref: ../../../components/parameters/common/RetailerCode.yaml

```
Ven que hay `../../../` en la ref, ojo con eso... Están avisados. 
