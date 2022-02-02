[![Publish API Packages](https://github.com/silohub/product-apis/actions/workflows/packages-publish.yml/badge.svg)](https://github.com/silohub/product-apis/actions/workflows/packages-publish.yml)

# Estructura de directorios
- **openapi**: tiene las fuentes de las APIs. Separadas en la estructura sugerida por OpenAPI.
  - __*.yaml__: la papa: acá están las APIs declaradas, que usan paths y components
  - **paths**: tiene la definición de las operaciones
  - **components**: tiene parámetros, requests, responses, etc... Asociadas a los paths.

**Una definición importante...**: los fuentes adentro de openapi funcionan directo, no hay que generar nada, se pueden ver y navegar sin problema. 
Las APIs en yaml no se tocan en el build. Se tocan por afuera con scripts, pero los yaml no cambian durante el build.

## Que generamos
- un openapi.yaml completo por cada API, que no depende de otros archivos, como están los originales
- una clase abstracta como server publicada como paquete en Github 
- una cliente javascript con Axios para el front. publicado como paquete en Github
- el sitio de documentación, por ahora subido a github pages

# Versionado de APIs
Las APIs no se versionan como el código, sino que nosotros decidimos cambiar la version. 

# Dependencias
Algunas de las cosas que usamos para publicar las APIs
- [RapiDoc](https://mrin9.github.io/RapiDoc/) esto sirva para mostrar la api Yaml en formato entendible... está muy buena!

# Customizar templates
- para extraer los templates de server: `pnpm exec openapi-generator-cli author template --generator-name java-micronaut-server --output .silohub/templates/server-packages/generator`
- para extraer los templates de api-files: `pnpm exec openapi-generator-cli author template --output build/templates/api-files --generator-name openapi-yaml`