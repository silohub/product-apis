## La carpeta `openapi`

Esta carpeta tiene los puntos de entrada de las apis (`api-*.yaml` y `bff-*.yaml`).

Estos archivos tienen referencias a otros archivos en los subdirectorios `components` y `paths` que definen los métodos de la api.

En las definiciones hay que prestarle atención a:

* La sección **info** es bastante común a todas las apis, tiene info de links, documentación, contacto, etc.
* En **externalDocs** está un link a confluence, pero ya me imagino que lo vieron
* En **servers** vale la pena mencionar que ahí está definido la API server que es donde puedes probar la API  
* **tags**: acá agrupamos los métodos de la api para que luego se generen juntos. A nivel definición es solo informativo.
* [components](components/README.md) Solo para mencionar el subdirectorio donde están todas las definiciones de tipos, respuestas, etc.   
  * **securitySchemes** acá referenciamos a la configuración de autenticación con OAuth con keycloak
* [paths](paths/README.md): Cada path representa una URL con los métodos que soporta. Está separado por negocio, más o menos
