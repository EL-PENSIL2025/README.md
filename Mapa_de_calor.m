% -------------------------------------------------------------------------
% MAPA DE COBERTURA WIFI (2.4 GHz) 
% Lo que hago aquí: a partir de 12 mediciones puntuales de RSSI (dBm),
% estimo la señal en toda un área mediante interpolación y la visualizo
% como un mapa de calor fácil de interpretar.
% -------------------------------------------------------------------------

clc
clear
close all

%% 1. Mis mediciones reales (lo que sí medí)
% Ubico el router en el origen del plano: aquí "nace" la señal.
router_x = 0;
router_y = 0;

% Elijo cuatro diagonales (NE, NW, SW, SE) para muestrear de forma simétrica.
theta = [45 135 225 315]; % grados

% Distancias (en metros) a las que tomé las mediciones desde el router.
d1 = 1;
d5 = 5;
d10 = 10;

% Convierto esas posiciones polares (distancia, ángulo) a coordenadas (x, y).
[x1,y1]   = pol2cart(deg2rad(theta), d1);
[x5,y5]   = pol2cart(deg2rad(theta), d5);
[x10,y10] = pol2cart(deg2rad(theta), d10);

% Mis valores de RSSI en dBm. Cada vector corresponde a una distancia fija.
% Nota: valores más cercanos a 0 implican mejor señal (menos negativos).
rssi1  = [-66 -69 -59 -53];  % 1 metro
rssi5  = [-68 -68 -71 -71];  % 5 metros
rssi10 = [-64 -61 -75 -75];  % 10 metros

% Junto todo en vectores únicos para facilitar la interpolación.
x    = [x1 x5 x10];
y    = [y1 y5 y10];
rssi = [rssi1 rssi5 rssi10];

%% 2. Interpolación: estimo la señal donde no medí
% Creo una malla (grid) fina que cubre un área de 20x20 m alrededor del router.
% Mientras más fina, más suave y detallado el mapa (con más costo de cómputo).
[xq,yq] = meshgrid(-10:0.05:10, -10:0.05:10);

% Interpolo usando 'natural' porque suele respetar bien variaciones locales
% sin introducir oscilaciones exageradas (útil con pocos puntos).
vq = griddata(x, y, rssi, xq, yq, 'natural');

%% 3. Visualizo el mapa de cobertura (lo que se ve)
% Creo la figura con un tamaño cómodo para lectura.
figure('Position',[100 100 900 800])

% Dibujo el mapa de calor. Cada color representa un nivel de RSSI estimado.
contourf(xq, yq, vq, 100, 'LineColor', 'none')
colormap(turbo)   % Paleta con buen contraste para diferencias sutiles.
colorbar          % Escala de referencia en dBm.

% Ajusto el rango de colores para abarcar ligeramente más que mis mediciones.
caxis([min(rssi)-2 max(rssi)+2])

hold on  % Sostengo el lienzo para agregar marcas y etiquetas.

%% 4. Agrego contexto: marco el router y mis puntos reales
% Marco el router (el origen de la señal).
scatter(router_x, router_y, 250, 'w', 'filled', 'MarkerEdgeColor', 'k')
text(router_x+0.5, router_y+0.5, 'Router', 'FontSize', 12, ...
     'FontWeight', 'bold', 'Color', 'w')

% Dibujo los puntos donde sí medí y escribo el valor de RSSI medido.
scatter(x, y, 150, 'k', 'filled')
for i = 1:length(rssi)
    text(x(i)+0.4, y(i), strcat(num2str(rssi(i)),' dBm'), ...
        'FontSize', 9, 'FontWeight', 'bold', 'Color', 'k')
end

%% 5. Toques finales para que se lea fácil
title('Mapa de Cobertura WiFi - 2.4 GHz', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('Posición X (m)', 'FontSize', 12)
ylabel('Posición Y (m)', 'FontSize', 12)
axis equal   % Mis ejes en metros, con la misma escala en X y Y.
xlim([-11 11])
ylim([-11 11])
grid on
``
