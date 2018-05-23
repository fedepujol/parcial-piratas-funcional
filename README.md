# Paradigmas de Programacion

## Parcial:
    - Fecha: 08/05/2018
    - Nombre: Piratas del Caribe
    - Paradigma: Funcional
    
## Consideraciones
Brach:
  - Master: resolucion del parcial.
  - Final: resolucion con errores corregidos.
  
## Codigo

En el branch master, se encuentra el error de usar la funcion zipWith con dos listas de distintos tamaños. La funcion zipWith acorta el resultado al tamaño de la lista mas corta. Ej:

```haskell
unaLista :: [Int]
unaLista = [1, 2, 3]

otraLista :: [Int]
otraLista = [4, 5]

funcionEjemplo :: [Int] -> [Int] -> [Int]
funcionEjemplo unaLista otraLista = zipWith (+) unaLista otraLista
 ```
 Resultado:
 ```haskell
[5, 7]
 ```
 
 [Enunciado](https://docs.google.com/document/d/1la_hR282Y7Jq4TpGLyQSczZTS4aT1uITi2DHUMGZDhE/edit)
