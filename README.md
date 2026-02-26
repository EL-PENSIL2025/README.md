# README.md
Mapa de cobertura WiFi en MATLAB. Convierte mediciones de RSSI en un mapa de calor usando interpolación. Muestra visualmente la fuerza de la señal en un área, marcando el router y los puntos medidos.

¿Qué hace este script?

Este script en MATLAB es mi forma de convertir mediciones puntuales de señal WiFi (RSSI) en un mapa de calor que se entiende a primera vista. Yo parto de algunos puntos donde medí la intensidad de la señal y, a partir de ellos, estimo cómo se comporta la cobertura en toda el área, incluso en lugares donde no alcancé a medir. Así obtengo una visualización completa y útil para evaluar la cobertura de un router.

¿Cómo lo construí?
Dividí el proceso en 4 pasos lógicos:


Definición de las mediciones reales

Ubico el router en el centro del plano (0,0), como si estuviera en el corazón de una habitación. Tomo mediciones de RSSI (en dBm) a 1, 5 y 10 metros en cuatro diagonales (Oriente, Occidente, Norte y Sur). Con eso reúno 12 puntos que tienen coordenadas (x, y) y su respectivo valor de señal. Esta es mi base “real” y confiable.


Creación de un mapa continuo (interpolación)

Para no quedarme con 12 puntos aislados, genero una malla fina (una cuadrícula) que cubre un área de 20 x 20 metros. Luego uso interpolación para estimar el valor de la señal en cada punto de esa malla. En términos simples: “relleno” los espacios entre las mediciones, aprovechando los valores cercanos para aproximar lo que no medí directamente.


Visualización del mapa de calor

Con los valores interpolados, genero el mapa usando contourf. Cada color representa un nivel de intensidad de señal: los tonos cálidos (amarillos) sugieren mejor recepción; los fríos (azules/morados), menor intensidad. Es una forma rápida de “leer” el territorio de la señal.


Anotación y contexto

Marco la posición del router y señalo los 12 puntos donde tomé mediciones reales. De esta manera, cualquiera que vea el gráfico puede conectar el mapa estimado con los datos originales y entender la visualización con contexto.


[Ver el código de MATLAB aquí](./Mapa_de_calor.m).
