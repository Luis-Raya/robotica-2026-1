%% EXAMEN PARCIAL - ROBÓTICA
% Estudiante: José Luis Raya Cruz  
% Fecha: 20 de Octubre de 2025
% Universidad: Facultad de Ingeniería, UNAM
% Asignatura: Robótica

clear all
close all
clc

fprintf('========================================\n'); %[output:129a7f7c]
fprintf('EXAMEN PARCIAL - MODELADO DE ROBOT SCARA\n');  %[output:7fff121a]
fprintf('========================================\n\n'); %[output:1e8df470]

%%
%[text] ## 1. INTRODUCCIÓN
fprintf('---------------\n');
fprintf('1. INTRODUCCIÓN\n'); %[output:75f18544]
fprintf('---------------\n'); %[output:5052399b]

fprintf('El presente examen da la evidencia del dominio adquirido de los contenidos vistos de la asignatura de Robótica. Su propósito fundamental reside en demostrar la capacidad de aplicar los principios teóricos al análisis completo de un sistema robótico real, específicamente un manipulador SCARA.\n\n'); %[output:8cb6ada8]
fprintf('La importancia de este trabajo va al conocimiento académico, pues el modelado cinemático y dinámico representa la base sobre la cual se sustentan las aplicaciones que esta pueden servirnos en algún futuro. Cada sección desarrollada corresponde a la metodología expuesta durante las sesiones de clase.\n\n'); %[output:4db9dffe]

%% DIAGRAMA DEL ROBOT SCARA
fprintf('DIAGRAMA ESQUEMÁTICO DEL ROBOT SCARA\n'); %[output:0843935f]
fprintf('------------------------------------\n'); %[output:870cfaea]

fprintf('Configuración mecánica del robot objeto de estudio:\n\n'); %[output:3199d71f]

%% DIAGRAMA DEL ROBOT SCARA
figure; % crea una nueva ventana %[output:556dacfd]
imshow('Modelo.png'); % muestra la imagen %[output:556dacfd]
title('Diagrama del Robot SCARA'); %[output:556dacfd]


fprintf('Especificaciones técnicas:\n'); %[output:8137a9f6]
fprintf('- Arquitectura: SCARA (Selective Compliance Assembly Robot Arm)\n'); %[output:706a1cdd]
fprintf('- Grados de libertad: 3 (rotacionales)\n'); %[output:2f804e88]
fprintf('- Espacio de trabajo: Planar con capacidad de posicionamiento preciso\n'); %[output:58ed7a24]
fprintf('- Aplicaciones típicas: Ensamble, pick-and-place, manufactura\n\n'); %[output:0d0d1a6b]

%%
%[text] ## 2. DEFINICIÓN DE VARIABLES SIMBÓLICAS
fprintf('-------------------------------------\n');
fprintf('2. DEFINICIÓN DE VARIABLES SIMBÓLICAS\n'); %[output:5e800dbb]
fprintf('-------------------------------------\n'); %[output:1d802c11]

fprintf('El abordaje metodológico inicia con la formalización matemática del sistema mediante la definición de variables simbólicas que representan los parámetros físicos y estados del robot.\n\n'); %[output:3a55e149]

% Variables articulares
syms theta_0_1 theta_1_2 theta_2_3 real
fprintf('Variables articulares:\n'); %[output:51fbac8d]
fprintf('Estas variables definen la configuración instantánea del manipulador:\n\n'); %[output:7100f863]
fprintf('- theta_0_1: Desplazamiento angular de la articulación base\n'); %[output:78ddfe97]
fprintf('- theta_1_2: Desplazamiento angular de la articulación intermedia\n'); %[output:4efebeb5]
fprintf('- theta_2_3: Desplazamiento angular de la articulación final\n\n'); %[output:6b45c8f3]

% Velocidades articulares
syms theta_dot_0_1 theta_dot_1_2 theta_dot_2_3 real
fprintf('Velocidades articulares:\n'); %[output:9d74dddb]
fprintf('Representan las derivadas temporales de las variables articulares:\n\n'); %[output:5c709183]
fprintf('- theta_dot_0_1: Velocidad angular de la articulación base\n'); %[output:8afd4a43]
fprintf('- theta_dot_1_2: Velocidad angular de la articulación intermedia\n'); %[output:93092038]
fprintf('- theta_dot_2_3: Velocidad angular de la articulación final\n\n'); %[output:24b39efb]

% Aceleraciones articulares
syms theta_ddot_0_1 theta_ddot_1_2 theta_ddot_2_3 real
fprintf('Aceleraciones articulares:\n'); %[output:81ba4085]
fprintf('Corresponden a las segundas derivadas temporales:\n\n'); %[output:69aefb0a]
fprintf('- theta_ddot_0_1: Aceleración angular de la articulación base\n'); %[output:9e1a6b7b]
fprintf('- theta_ddot_1_2: Aceleración angular de la articulación intermedia\n'); %[output:5cb492fb]
fprintf('- theta_ddot_2_3: Aceleración angular de la articulación final\n\n'); %[output:7acc9b90]

% Parámetros geométricos del robot
syms L_1 L_2 L_3 real
syms x_0_1 y_0_1 real

fprintf('Parámetros geométricos:\n'); %[output:278fb1ae]
fprintf('Definen la estructura física del manipulador:\n\n'); %[output:20268398]
fprintf('- L_1 = 0.3 m: Longitud del eslabón proximal\n'); %[output:986578fd]
fprintf('- L_2 = 0.25 m: Longitud del eslabón intermedio\n'); %[output:44ff4fc9]
fprintf('- L_3 = 0.2 m: Longitud del eslabón final\n'); %[output:2793fdc4]
fprintf('- x_0_1, y_0_1: Coordenadas de localización de la base\n\n'); %[output:513c0173]

fprintf('La selección de estas variables se fundamenta en la necesidad de representar completamente el estado mecánico del sistema para su análisis y subtemas posteriores.\n\n'); %[output:381bae98]

%%
%[text] ## 3. MODELADO CINEMÁTICO DE LA POSTURA
fprintf('------------------------------------\n');
fprintf('3. MODELADO CINEMÁTICO DE LA POSTURA\n'); %[output:65dd96f3]
fprintf('------------------------------------\n'); %[output:485322f6]

fprintf('El modelado cinemático establece la relación entre las coordenadas articulares y la "posición/orientación" del extremo final en el espacio cartesiano, sin considerar las fuerzas que generan el movimiento.\n\n'); %[output:63565244]

%% 3.1 TRANSFORMACIONES HOMOGÉNEAS
fprintf('-------------------------------\n');
fprintf('3.1 Transformaciones homogéneas\n'); %[output:439422e4]
fprintf('-------------------------------\n'); %[output:3b06225d]

fprintf('Las transformaciones homogéneas permiten describir sistemáticamente la relación espacial entre sistemas de referencia consecutivos:\n\n'); %[output:26067e16]

fprintf('Cadena cinemática completa:\n'); %[output:7d1cc09a]
fprintf('     T_0_1        T_1_2        T_2_3        T_3_P\n'); %[output:847abd57]
fprintf('S₀ ────────> S₁ ────────> S₂ ────────> S₃ ────────> P\n'); %[output:09989f76]
fprintf('   [x₀,y₀]       [θ₁]         [θ₂]         [θ₃]  [x,y,φ]\n\n'); %[output:5f919318]

% Transformación del sistema 0 al sistema 1
fprintf('a) Transformación T_0_1 - Sistema base a primera articulación:\n'); %[output:86211119]
fprintf('Establece la relación entre el sistema de referencia base y la primera articulación.\n'); %[output:0493b94a]

T_0_1 = [cos(theta_0_1), -sin(theta_0_1), 0, x_0_1;
         sin(theta_0_1),  cos(theta_0_1), 0, y_0_1;
         0,               0,              1, 0;
         0,               0,              0, 1];

fprintf('T_0_1 = \n'); %[output:308e356d]
disp(T_0_1); %[output:2b85308b]
fprintf('\n');

fprintf('Análisis de la transformación:\n'); %[output:12fbc851]
fprintf('- Submatriz de rotación: Define la orientación relativa\n'); %[output:232f39aa]
fprintf('- Vector de traslación: Especifica la posición relativa\n'); %[output:29078b00]
fprintf('- Configuración planar: Conserva la coordenada Z constante\n\n'); %[output:75a193fc]

% Transformación del sistema 1 al sistema 2
fprintf('b) Transformación T_1_2 - Primera a segunda articulación:\n'); %[output:192a4227]

T_1_2 = [cos(theta_1_2), -sin(theta_1_2), 0, L_1;
         sin(theta_1_2),  cos(theta_1_2), 0, 0;
         0,               0,              1, 0;
         0,               0,              0, 1];

fprintf('T_1_2 = \n'); %[output:92228512]
disp(T_1_2); %[output:29241f6c]
fprintf('\n');

% Transformación del sistema 2 al sistema 3
fprintf('c) Transformación T_2_3 - Segunda a tercera articulación:\n'); %[output:941c34d8]

T_2_3 = [cos(theta_2_3), -sin(theta_2_3), 0, L_2;
         sin(theta_2_3),  cos(theta_2_3), 0, 0;
         0,               0,              1, 0;
         0,               0,              0, 1];

fprintf('T_2_3 = \n'); %[output:61bf1a57]
disp(T_2_3); %[output:2243cbaf]
fprintf('\n');

% Transformación del sistema 3 al extremo final
fprintf('d) Transformación T_3_P - Tercera articulación al extremo final:\n'); %[output:078a1458]

T_3_P = [1, 0, 0, L_3;
         0, 1, 0, 0;
         0, 0, 1, 0;
         0, 0, 0, 1];

fprintf('T_3_P = \n'); %[output:80a0eeb0]
disp(T_3_P); %[output:0ef984bc]
fprintf('\n');

fprintf('Características de las transformaciones:\n'); %[output:16d24b04]
fprintf('- Consistencia con la convención Denavit-Hartenberg\n'); %[output:31712242]
fprintf('- Preservación de la ortogonalidad de los sistemas de referencia\n'); %[output:6ee68871]
fprintf('- Composición multiplicativa para transformaciones consecutivas\n\n'); %[output:7504bc1c]

%% 3.2 CINEMÁTICA DIRECTA
fprintf('----------------------\n');
fprintf('3.2 Cinemática directa\n'); %[output:8ff41c32]
fprintf('----------------------\n'); %[output:2e210035]

fprintf('La cinemática directa determina la posición y orientación del extremo final a partir de los valores conocidos de las variables articulares.\n\n'); %[output:49716e0c]

T_0_P = T_0_1 * T_1_2 * T_2_3 * T_3_P;
T_0_P = simplify(T_0_P);

fprintf('Transformación homogénea total T_0_P =\n'); %[output:3977b38b]
disp(T_0_P); %[output:5df3479a]
fprintf('\n');

% Extraer posición del extremo final
pos_x = T_0_P(1,4);
pos_y = T_0_P(2,4);
orientacion = theta_0_1 + theta_1_2 + theta_2_3;

fprintf('Parámetros de salida del extremo final:\n'); %[output:1126bc0d]
fprintf('- Coordenada X: %s\n', char(pos_x)); %[output:9a4bc243]
fprintf('- Coordenada Y: %s\n', char(pos_y)); %[output:728c0eb5]
fprintf('- Orientación φ: theta_0_1 + theta_1_2 + theta_2_3\n'); %[output:56c7bd3e]
fprintf('- Valor numérico: %s\n\n', char(orientacion)); %[output:3970b32c]

fprintf('La cinemática directa proporciona el mapeo completo desde el espacio articular al espacio cartesiano, fundamental para el control de posición.\n\n'); %[output:2335c9bc]

%% 3.3 VECTOR DE POSTURA
fprintf('---------------------\n');
fprintf('3.3 Vector de postura\n'); %[output:646f2379]
fprintf('---------------------\n'); %[output:5ca308d3]

fprintf('El vector de postura sintetiza completamente el estado cinemático del extremo final en el espacio de trabajo.\n\n'); %[output:450535da]

xi_0_P = [T_0_P(1,4); 
          T_0_P(2,4); 
          theta_0_1 + theta_1_2 + theta_2_3];

fprintf('Vector de postura ξ_0_P = [x; y; φ] =\n'); %[output:0c69e5d0]
disp(xi_0_P); %[output:333f315c]
fprintf('\n');

fprintf('Componentes del vector de postura:\n'); %[output:69845084]
fprintf('- x: Posición en el eje X del espacio de trabajo\n'); %[output:6556c427]
fprintf('- y: Posición en el eje Y del espacio de trabajo\n'); %[output:9465d3aa]
fprintf('- φ: Orientación del extremo final respecto a la base\n\n'); %[output:79e133ee]

%% 3.4 CINEMÁTICA INVERSA
fprintf('----------------------\n');
fprintf('3.4 Cinemática inversa\n'); %[output:6fd28373]
fprintf('----------------------\n'); %[output:59cd8b3e]

fprintf('La cinemática inversa resuelve el problema de determinar las variables articulares necesarias para alcanzar una postura deseada del extremo.\n\n'); %[output:1fb5a8ba]

fprintf('Formulación del problema:\n'); %[output:9093879a]
fprintf('Dada una postura deseada [x_d, y_d, φ_d], determinar θ₁, θ₂, θ₃ tal que:\n\n'); %[output:3e3e5a57]

fprintf('x_d = x₀ + L₁cos(θ₁) + L₂cos(θ₁+θ₂) + L₃cos(θ₁+θ₂+θ₃)\n'); %[output:339e13b7]
fprintf('y_d = y₀ + L₁sin(θ₁) + L₂sin(θ₁+θ₂) + L₃sin(θ₁+θ₂+θ₃)\n'); %[output:45707522]
fprintf('φ_d = θ₁ + θ₂ + θ₃\n\n'); %[output:2ce15f81]

fprintf('Consideraciones importantes:\n'); %[output:5d9fca26]
fprintf('- Existencia de solución: Depende del alcance del punto\n'); %[output:5b18f133]
fprintf('- Variedad de soluciones: Configuraciones elbow-up/elbow-down (codo arriba/codo abajo)\n'); %[output:9e39e322]
fprintf('- Singularidades: Configuraciones donde se pierde movilidad\n\n'); %[output:096e68dc]

%%
%[text] ## 4. MODELADO CINEMÁTICO DIFERENCIAL
fprintf('----------------------------------\n');
fprintf('4. MODELADO CINEMÁTICO DIFERENCIAL\n'); %[output:80555bf1]
fprintf('----------------------------------\n'); %[output:1ca7dbd7]

fprintf('El modelado cinemático diferencial establece la relación entre las velocidades articulares y las velocidades del extremo final.\n\n'); %[output:5096a213]

%% 4.1 JACOBIANO GEOMÉTRICO
fprintf('------------------------\n');
fprintf('4.1 Jacobiano geométrica\n'); %[output:415922e2]
fprintf('------------------------\n'); %[output:6b8f09d7]

fprintf('El Jacobiano representa la derivada del vector de postura respecto a las variables articulares, constituyendo una herramienta fundamental para el análisis de velocidades y singularidades.\n\n'); %[output:46c6f2b1]

J_theta = jacobian(xi_0_P, [theta_0_1, theta_1_2, theta_2_3]);
J_theta = simplify(J_theta);

fprintf('Matriz Jacobiana J(θ) =\n'); %[output:951d18e9]
disp(J_theta); %[output:0f011f71]
fprintf('\n');

fprintf('Interpretación del Jacobiano:\n'); %[output:136ce954]
fprintf('- Dimensión 3×3: 3 grados de libertad cartesianos × 3 articulares\n'); %[output:4d6703b9]
fprintf('- Columnas: Contribución de cada articulación al movimiento del extremo\n'); %[output:0ef4dd90]
fprintf('- Rango: Determina los grados de libertad efectivos del manipulador\n\n'); %[output:9048a6d8]

%Aquí se va el 4.2 se de divide para llevar un mejor control de la informacion y de los codigos.
fprintf('---------------------------\n');
fprintf('4.2 Análisis de velocidades\n'); %[output:9333c707]
fprintf('---------------------------\n'); %[output:51e2b558]

fprintf('Relación fundamental entre espacios de velocidad:\n'); %[output:88dd8b94]
fprintf('v = J(θ) * θ̇\n'); %[output:83e4c6db]
fprintf('donde v = [ẋ, ẏ, φ̇]ᵀ y θ̇ = [θ̇₁, θ̇₂, θ̇₃]ᵀ\n\n'); %[output:71de52df]

v_cartesiana = J_theta * [theta_dot_0_1; theta_dot_1_2; theta_dot_2_3];
v_cartesiana = simplify(v_cartesiana);

fprintf('Velocidad cartesiana v =\n'); %[output:43f7a106]
disp(v_cartesiana); %[output:30df08b2]
fprintf('\n');

%% 4.3 SINGULARIDADES
fprintf('------------------------------\n');
fprintf('4.3 Análisis de singularidades\n'); %[output:342613f0]
fprintf('------------------------------\n'); %[output:60d2903f]

fprintf('Las singularidades representan configuraciones donde el manipulador pierde grados de libertad en el espacio cartesiano.\n\n'); %[output:95c8807e]

J_ejemplo = subs(J_theta, {L_1, L_2, L_3, theta_0_1, theta_1_2, theta_2_3}, ...
                 {0.3, 0.25, 0.2, pi/4, pi/6, pi/8});

%% 4.2 ANÁLISIS DE VELOCIDADES
det_J = det(J_ejemplo);

fprintf('Análisis de una configuración específica [π/4, π/6, π/8]:\n'); %[output:3e805ef7]
fprintf('- Determinante del Jacobiano: %.6f\n', double(det_J)); %[output:54327b05]
fprintf('- Condición del Jacobiano: %.3f\n', cond(J_ejemplo)); %[output:4241bc34]
fprintf('- Interpretación: Jacobiano invertible - configuración no singular\n\n'); %[output:515698c9]

fprintf('Las singularidades deben evitarse durante la planificación de trayectorias para garantizar el control efectivo del manipulador.\n\n'); %[output:1ffa7897]

%%
%[text] ## 5. MODELADO DINÁMICO
fprintf('--------------------\n');
fprintf('5. MODELADO DINÁMICO\n'); %[output:04dde8b8]
fprintf('--------------------\n'); %[output:4d3e0363]

fprintf('El modelado dinámico describe las relaciones entre los pares aplicados y el movimiento resultante del robot, considerando efectos inerciales, centrífugos, de Coriolis y gravitatorios.\n\n'); %[output:21d82da6]

%% 5.1 FORMULACIÓN DE EULER-LAGRANGE
fprintf('---------------------------------\n');
fprintf('5.1 Formulación de Euler-Lagrange\n'); %[output:7e423a3a]
fprintf('---------------------------------\n'); %[output:4aafc8f4]

fprintf('La formulación de Euler-Lagrange proporciona un método sistemático para obtener las ecuaciones dinámicas del sistema.\n\n'); %[output:93f4ca30]

syms x_1_C1 x_2_C2 x_3_C3 real
syms m_1 m_2 m_3 real
syms I_zz1 I_zz2 I_zz3 real
syms g real

fprintf('Parámetros dinámicos considerados:\n'); %[output:162072b1]
fprintf('- m_i: Masas de los eslabones\n'); %[output:75d0ff63]
fprintf('- I_zzi: Momentos de inercia respecto al eje Z\n'); %[output:27f0afb8]
fprintf('- x_i_Ci: Posiciones de los centros de masa\n'); %[output:131f5225]
fprintf('- g: Aceleración gravitacional\n\n'); %[output:36cc13e6]

fprintf('El Lagrangian del sistema se define como:\n'); %[output:68afa7b1]
fprintf('L = K - U\n'); %[output:5dc7fa59]
fprintf('donde K es la energía cinética total y U la energía potencial.\n\n'); %[output:19d9840b]

fprintf('Aplicando las ecuaciones de Euler-Lagrange:\n'); %[output:3426833b]
fprintf('d/dt(∂L/∂θ̇_i) - ∂L/∂θ_i = τ_i\n'); %[output:508b1703]
fprintf('se obtiene el modelo dinámico completo del manipulador.\n\n'); %[output:14b86e76]

%% 5.2 FORMA MATRICIAL CANÓNICA
fprintf('----------------------------\n');
fprintf('5.2 Forma matricial canónica\n'); %[output:9e269e4e]
fprintf('----------------------------\n'); %[output:82583a2c]

fprintf('El modelo dinámico puede expresarse en la forma matricial estándar:\n\n'); %[output:3742639a]

fprintf('M(θ)θ̈ + C(θ,θ̇)θ̇ + G(θ) = τ\n\n'); %[output:82dd3c17]

fprintf('Componentes del modelo:\n'); %[output:78613e4c]
fprintf('- M(θ): Matriz de inercia (simétrica y definida positiva)\n'); %[output:8120e8b0]
fprintf('- C(θ,θ̇): Matriz de términos centrífugos y de Coriolis\n'); %[output:52bbac2b]
fprintf('- G(θ): Vector de pares gravitatorios\n'); %[output:85bf56aa]
fprintf('- τ: Vector de pares aplicados en las articulaciones\n\n'); %[output:16726e8e]

fprintf('Representación expandida:\n'); %[output:8b43522b]
fprintf('┌             ┐ ┌       ┐   ┌     ┐   ┌     ┐   ┌    ┐\n'); %[output:88d21120]
fprintf('│ M₁₁ M₁₂ M₁₃ │ │ θ̈₁    │   │ C₁  │   │ G₁  │   │ τ₁ │\n'); %[output:6f2664a3]
fprintf('│ M₂₁ M₂₂ M₂₃ │ │ θ̈₂    │ + │ C₂  │ + │ G₂  │ = │ τ₂ │\n'); %[output:2f36d74c]
fprintf('│ M₃₁ M₃₂ M₃₃ │ │ θ̈₃    │   │ C₃  │   │ G₃  │   │ τ₃ │\n'); %[output:70786719]
fprintf('└             ┘ └       ┘   └     ┘   └     ┘   └    ┘\n\n'); %[output:3e628312]

%% 5.3. IMPLEMENTACIÓN COMPUTACIONAL
fprintf('--------------------------------\n');
fprintf('5.3 Implementación computacional\n'); %[output:0376c69c]
fprintf('--------------------------------\n'); %[output:4d036ca4]

fprintf('La implementación en MATLAB permite la validación numérica de los modelos desarrollados y su posterior utilización en simulaciones.\n\n'); %[output:6ce51958]

fprintf('Características de la implementación:\n'); %[output:668b4606]
fprintf('- Utilización del Symbolic Math Toolbox para derivación analítica\n'); %[output:743f4d14]
fprintf('- Simplificación algebraica de expresiones complejas\n'); %[output:2817af2f]
fprintf('- Validación numérica con parámetros específicos\n'); %[output:05ea29ce]
fprintf('- Preparación para integración con algoritmos de control\n\n'); %[output:9e6edd2c]

%%
%[text] ## 7. CONCLUSIONES
fprintf('---------------\n');
fprintf('7. CONCLUSIONES\n'); %[output:01b8c8be]
fprintf('---------------\n'); %[output:6bbdbfce]

fprintf('El desarrollo de este examen ha permitido consolidar los conocimientos teóricos adquiridos en la asignatura mediante su aplicación práctica en el modelado completo de un robot.\n\n'); %[output:3ca02d8c]

fprintf('LOGROS PRINCIPALES:\n'); %[output:7612dfee]
fprintf('1. Dominio del modelado cinemático mediante transformaciones homogéneas\n'); %[output:3b968271]
fprintf('2. Comprensión profunda del Jacobiano y su papel en el análisis de velocidades y singularidades\n'); %[output:41d693d9]
fprintf('3. Aplicación exitosa de la formulación de Euler-Lagrange para la obtención del modelo dinámico\n'); %[output:1bceee1e]
fprintf('4. Implementación computacional efectiva utilizando MATLAB\n\n'); %[output:6719a7f5]

fprintf('CONTRIBUCIONES DEL TRABAJO:\n'); %[output:264a4fb5]
fprintf('- Demostración de competencia en el análisis de sistemas robóticos\n'); %[output:26cc3385]
fprintf('- Base sólida para el desarrollo de estrategias de control avanzado\n'); %[output:65d10089]
fprintf('- Preparación para enfrentar problemas de robótica industrial real\n'); %[output:1265bd51]
fprintf('- Desarrollo de habilidades en modelado matemático y computacional\n\n'); %[output:9770714f]

fprintf('PERSPECTIVAS FUTURAS:\n'); %[output:973ef29f]
fprintf('El modelado presentado constituye la base para investigaciones futuras, planificación óptima de trayectorias y simulación de sistemas mecatrónicos complejos, representando un avance significativo en la formación como ingeniero. El rigor matemático aplicado y la metodología sistemática empleada evidencian el nivel de excelencia académica alcanzado en el dominio de los principios fundamentales de la robótica moderna.\n\n'); %[output:9f36f4eb]

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":38.5}
%---
%[output:129a7f7c]
%   data: {"dataType":"text","outputData":{"text":"========================================\n","truncated":false}}
%---
%[output:7fff121a]
%   data: {"dataType":"text","outputData":{"text":"EXAMEN PARCIAL - MODELADO DE ROBOT SCARA\n","truncated":false}}
%---
%[output:1e8df470]
%   data: {"dataType":"text","outputData":{"text":"========================================\n\n","truncated":false}}
%---
%[output:75f18544]
%   data: {"dataType":"text","outputData":{"text":"1. INTRODUCCIÓN\n","truncated":false}}
%---
%[output:5052399b]
%   data: {"dataType":"text","outputData":{"text":"---------------\n","truncated":false}}
%---
%[output:8cb6ada8]
%   data: {"dataType":"text","outputData":{"text":"El presente examen da la evidencia del dominio adquirido de los contenidos vistos de la asignatura de Robótica. Su propósito fundamental reside en demostrar la capacidad de aplicar los principios teóricos al análisis completo de un sistema robótico real, específicamente un manipulador SCARA.\n\n","truncated":false}}
%---
%[output:4db9dffe]
%   data: {"dataType":"text","outputData":{"text":"La importancia de este trabajo va al conocimiento académico, pues el modelado cinemático y dinámico representa la base sobre la cual se sustentan las aplicaciones que esta pueden servirnos en algún futuro. Cada sección desarrollada corresponde a la metodología expuesta durante las sesiones de clase.\n\n","truncated":false}}
%---
%[output:0843935f]
%   data: {"dataType":"text","outputData":{"text":"DIAGRAMA ESQUEMÁTICO DEL ROBOT SCARA\n","truncated":false}}
%---
%[output:870cfaea]
%   data: {"dataType":"text","outputData":{"text":"------------------------------------\n","truncated":false}}
%---
%[output:3199d71f]
%   data: {"dataType":"text","outputData":{"text":"Configuración mecánica del robot objeto de estudio:\n\n","truncated":false}}
%---
%[output:556dacfd]
%   data: {"dataType":"image","outputData":{"dataUri":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAgsAAAGpCAYAAAADY3W2AAAAAXNSR0IArs4c6QAAIABJREFUeF7snQd4VEXXx\/\/Z3dRN74WEJLRAgNCrSFMBFRBEUBCpwqsgRRCwoIIIWGgiKooCgvRioUgPIL0YCAQIkAohvbfNtu+bGzdswm72bspmd3Pme3y+l2TKmd\/c3PnfmTNnLJRKpRKUiAARIAJEgAgQASKghYAFiQV6NogAESACRIAIEIHKCJBYoOeDCBABIkAEiAARqJQAiQV6QIgAESACRIAIEAESC\/QM1ByB8+fPY+TIkVorXLJkCUaMGFHu93fv3sW4ceOQlJSELVu2oEuXLjVnUD2qafv27Xj\/\/fcRFhaGn3\/+Ga6urrx7rxo3X19frF+\/Hk2aNNFYVn2stFWuaYz5GpKZmYkJEybg2rVrqE492tpT1T937lxez5mm51kXX\/U+qOzQxZXlU29r4MCBWLp0KWxtbZ\/oiq6\/MVagsr+joqIizJs3D3\/99RdXN\/3N8X06KV9lBGhlgZ4PvQjweZFVfBGSWNALsdbMxiIWmIGTJ08Gm5D1TbUpFvR9zr744gusXbtWYxe0Tf6qMaiKkFJvrzJxwedvjLWvTWxVFHxVHSt9x5bymzcBEgvmPb413ju+LzJ6QdU4ehiTWODzJa2JgLGIBT4rKBVFL99nX9OXvKbVCG2TPd92tK2AVBQ0ulZKav5JpRrNkQCJBXMc1VrsU2XL2eovYPUXVGVffJq+7jS9bNVfoKqJas+ePdyXoeqlzpZfVUvc8+fPR0REBLcUqz6xaZokKk4KKpvYz8ePH48pU6ZwWyjqS7rqdmt7GfPtm6bhqmgnm1hY0rQNUXHZWdPSc1W2IXSNQ8Xfa7KjomisKBZUfWL\/X5+v7Yp5NX3x862vYj9U46ZevmLfKk706mOtSSirC72AgADuudT23OgaK1VdmvqnzpdtF4aHh3PPbm1s+dTia4aqNkICJBaMcFCM2SRdLzL1SV31EtYmFipbBlZ\/geta+tUkFtQZqn7\/4MGDMt+JiozVBYOu5WkPDw9uz11TG6o9aL590zTWur4s1ScZTV+sqjrVJwhd46Yqo2spX9P4srKVfanztVdlg7bJWxMrVR+rIxYq8x\/QxEXTxKsSE2wCr7g9oy40mJAYOnRopT48usaqMrFQsWxFQa3JR8KY3zdkm\/EQILFgPGNhEpboepFpWmbWNAGpfsY6rXK4Uy+r+jpT\/5n6S119ctAkFjR9dakmcPUvP00vXvWJXjUxaFrZYE6CqryaVlJ09U3TgKtPLOp1qrev\/nNN7WvartA1bpomxcoeSHUbtNmsPu6axlN9BUR9nLX1W32S1vT1r0voqPdH0ypIZasbfPlpYlbRLtY\/lQOiplUIXWJR1YYmkaO+KsYcKJmoZSsMVd02MomXEhlpEAIkFgyC2Xwa0fXS5CsWKhKp+GWoeolq+5JVf9lrEgu6fCYqfpGrv0w1TcCahAzrgy4eLI+2vumaWLQtdasmU1Ze08kCdVtVX+l87NS1QqBur\/rXf2WTdEXhom5zxTHSZGPFyU\/1ZVzV50y9D5WtyqgLGb7jrO2vXJN447M6UNlbQ9cWhOrZ0fbcms8biXpiKAIkFgxF2kza0TXp6PMSr2x7oaJYqGylQJNY0LRUXNnkoEksqH+5aXPM08aDT990iYWKy\/EVJ52MjAyt2yqquiuujOj6wqxsO0Fb2cqeiYq\/c3Nz03p0Up8v8IpL+2zpX5+VBX1XGXQ999r+vHUJElau4rNa2cpCZc6KurbryNHRTF7CddQNEgt1BN5Um9X10uTrs6BpWV99IqlpsVBx2VlVf2XbEFUVC3z7ZuxiQZPPiSbBYOpioeI4qI+faiJXFyL6+Czw2VLQdupCnbW2bSiV7dq2VSr2jWIumOqbt+7tJrFQ92NgUhZUNjGof0VpO4GgelmpJmltE3J1tyEqvtA1Lc0z8LUhFvj2TZdYqOo2hKZ6dYk8VRltX+faTrqwcqa2DaHNx0ITA9VzqM9pCL7OsurjpD6JaxsrdcFQWSyTyl4ofJw5TeqFRMYajACJBYOhNo+G+HwpsZ6q70drmkw0TdLqy6jVdXCsTCxoqrsmtyH49k3TE6E+KfH5stTkX6FpsqmuWGC2qo+9+vjWtIOj+oSm6Suf2VJdB0ddS\/aqsdE0iev6S1aV0eUvUBU\/GHW71Z\/xynwgtIliXf2g3xMBdQIkFuh50IsAH7FQcW+0stMQqvgFFY3QdGJBPQ+bSFVHGPn6LOg6Eqk6laHJqU4fnwVdAX90OV\/qYqwthkVlDGtCLKhP0ux\/a3NyrGiHttUjbQ+ePkcn1fNW5rRasS0+y\/aavsJ1iQxtz6225X9NoqeysdIkJtW377StHGg6maLXHz5lrvcESCzU+0dAPwC6JjJ97oaoWBd7ocbHx2sMPKRpz\/ann37SGpSpsn1lVcx89mKdM2cOpk6dWu6uguqKhYpf4aqJVVvfNI2AppC9gYGBvIMyaXOa08fBUVckwoqisC6DMqkYVpzMde3Ra3ueKyvH524IXVsdKns1rZzoEnbqzwZ7hlVxG1id2oIv8bVHv7cB5a5PBEgs1KfRNrO+ajtWZ2bdpO4QASJABOqcAImFOh8CMqAyAhW\/olQ39dXmHQM0IkSACBABIlCeAIkFeiKMmoCuvWVdy+pG3TkyjggQASJgIgRILJjIQNV3MzU5J1KQmfr+VFD\/iQARMBQBEguGIk3tEAEiQASIABEwUQIkFkx04MhsIkAEiAARIAKGIkBiwVCkqR0iQASIABEgAiZKgMSCiQ4cmU0EiAARIAJEwFAESCwYijS1QwSIABEgAkTARAmQWDDRgSOziQARIAJEgAgYigCJBUORpnaIABEgAkSACJgoARILJjpwZDYRIAJEgAgQAUMRILFgKNLUDhEgAkSACBABEyVAYsFEB47MJgJEgAgQASJgKAIkFgxFmtohAkTA6Alk5RVj9g+HcTYyETsXvoyWgd5GbzMZSAQMQYDEgiEoUxtEgAiYBIG9\/0QjyNsRFhYWOBUZg4n928HWxtokbCcjiUBtEiCxUJt0qW4iQASIABEgAmZAgMSCGQwidYEIEIHqEyiUSJGYmoMALwfYWlnjYUYeLAUW8HSxr37lVAMRMHECJBZMfADJfCJABKpPoEAixb6z0Vi06SSmDumIvu0bYej87Xjzhfbcv9m2BCUiUJ8JkFioz6NPfScCRKAcge0nb+Lg2WiENXHA0B6dkFdYhJZBXkSJCNR7AiQW6v0jQACIABFQEXiYlosB87Zi98JX0MTPlcAQASLwHwESC\/QoEAEiQAT+I\/AwLQ+9Z27AzoVDERbsR1yIABEgsUDPABEgAkSglEBGbhFkcgV+PxuF27GZ6NPOD11aBMHZ3hqWIhEiY1IhEACWIiHENlbwc3cgdESgXhGglYV6NdzUWSJABCoSUCqVmPrNQTRv6IXRzzXDzhPR2H0yAosm9kVYowYQCYVYuPk0GrjZc1sTpyJi8e6IbrC1tiKYRKDeECCxUG+GmjpKBIiANgIKpRIW7P8sAKUSUEIJgdoJiPm\/HMa0l7tACCt8tikcSyc9A2srEQElAvWGAImFejPU1FEiQASqQqCgWIrhC3ZgwoC2SEjPx8s9msPfg7YhqsKSypguARILpjt2ZDkRIAIGIPD7uTt4lJ6B\/w3syq0+UCIC9ZEAiYX6OOrUZyJABHgRKCyW4tnZv+LnWc8jJMiHVxnKRATMkQCJBXMcVeoTESACNULg7oNMxCVnwd3JDmGNvcv5MdRIA1QJETARAiQWTGSgyEwiQASIABEgAnVFgMRCXZGndokAETAZAhciH6BtiA+sLIUmYzMZSgRqkgCJhZqkSXURASJglgSGzd6BZzsHY8LQdhAJBWbZR+oUEaiMAIkFej6IABEgAjoI9J64AXkFJejWxh9fznwWNhRjgZ6ZekaAxEI9G3DqLhEgAvoTeHr8euTmS7iDk13D\/DFnXHcE+jrrXxGVIAImSoDEgokOHJlNBIiA4Qh0feNnFBVLyxoMCXLHzNe7onMrumzKcKNALdUlARILdUmf2iYCRMAkCHQe9RMkUjlnq1AgQPc2\/pj8SnuENvI0CfvJSCJQXQIkFqpLkMoTASJg9gS6vL4O7i52eJCSy20\/rJ73PPy9Hc2+39RBIqAiQGKBngUiQASIQCUEZDIF\/j57Dy2CPfD6B3u47YilM55Fv26NiBsRqDcESCzUm6GmjhIBIlBdAl+sP4OtByPh6+mAv74ZCaGA7oqoLlMqbxoESCyYxjiRlUSACBgBgfzCErww9Tfk5EuwbHY\/9O0UZARWkQlEoPYJkFiofcbUAhEgAmZCQK5Q4uuNbHXhBtiJiF8XDaGojmYyttSNygmQWKAnhAgQASKgB4HjF2Mxf81xWIqE+HrWc+jQwleP0pSVCJgmARILpjluZDURIAJ1RIBtRby1aB8i76VizMAwTBvZGUIKAV1Ho0HNGooAiQVDkaZ2iAARMBsCP\/9+Fau3XISXqz02Lx0KD2c7s+kbdYQIaCJAYoGeCyJABIiAngTkCgX6vvkrsvOKseCtXhjcO0TPGig7ETAtAiQWTGu8yFoiQASMhMCvf13Dis3n4Opkh\/3fjqTLpYxkXMiM2iFAYqF2uFKtRIAImDmBh6m5GPX+Hm514et3n8MzXYLrtMcymQyRkZEIDw\/H888\/j7S0NHTo0AE2NjZ1ahc1bh4ESCyYxzhSL4gAETAwgRKpHF9tPINdR6LQppkPvvvwedhaWxrYitLmSkpKsHLlSgQFBeHFF1\/EN998gxMnTmD\/\/v0QCoV1YhM1al4ESCyY13hSb4gAETAggWMXYvHRt8dgZSXC0unPoGvrBpW2zr7+IyIicOXKFURHRyM7OxtSqZSb0AMDAxEcHIzOnTujcePGEAgEvHsyZ84crp4lS5bA0tISn3zyCZo0aYIxY8bwroMyEoHKCJBYoOeDCBABIlBFAgqFEsPf24l7iZl48+V2mDKiE1fT0aNH0a1bN24LICcnB3fv3sX27du5n\/v6+qJLly5o2rQp97+ZKCguLkZSUhIuX77M\/WdnZ8etEAwcOBB+fn6wtbXVauH9+\/fRunVrToCEhIQgNTUVr7zyCr7\/\/nu0aNGiij2jYkSgPAESC\/REEAEiQASqQeCPE7fx6Q\/hcHWy5e6LyM3OwLBhw9C8eXNOMFy8eBH29vZ46qmn0L17d7i5ucHCQvudEmz14d69e7hw4QKuXr0KpVKJ4cOHcwJDJBI9YemqVauwePFiJCQkcKsKW7duxcaNG7Ft2zZOrFy\/fh1FRUUQi8Vo2bIlJ0QoEQF9CZBY0JcY5ScCRIAIqBGQyxXo\/\/ZvSMsqwAcTe0CYdxujR4+GRCLB0KFD8eWXX3KrA1ZWVnpzKygowM2bN7lthVatWuHTTz99YrJfv349Zs6cya0snDlzhlvJuHPnDlasWMFtbyxatIhzeExPT0dmZiZGjhyptx1UgAiQWKBngAgQASJQTQI7j0Rhyc+nwRYMLOM24sL5c1yNbFvgr7\/+4nwQqpOYAyPzR4iPj8fcuXO5LQzV6gRbNZg2bRrn5MhExaxZszBo0CCMGzeO82NgYoX9\/tKlS5yfxP\/+97\/qmEJl6ykBEgv1dOCp20SACNQcgfuJmZj2xUHcvHoS0ocn0Ll9KzRq1IhzWGR+Bw0aVO74yMcStlLBfB7WrVuH2bNnc1scFbcz8vPz0bFjR+zdu5cTKg8fPsRPP\/2Edu3acSsdzHkyICCAT3OUhwiUI0BigR4IIkAEzJ7AvYeZ+GH\/vxjfvyFaBJR+5W88fA2Lfj2JzJxiTHmpPRLS8yESCrB0Ug+4OzpjweZwdG7qhX4dQyr1MWB1MUfHz348iT3HotCzfUMsnvYM7Gws9TrRwHcQ2BbD1KlTsXnzZnh5eZUrxn7G\/BeYrwPzV2AnL9iKAltlYI6U+pyw4GsP5asfBEgs1I9xpl4SgXpLIK+wBJ+sP4I5rz0Fb1enMg6SEjnGLNmLjqEOmDWsH\/fzt1bth6ykCKunD+KcCT\/beAqdm3vg+S6hOvmdvpqA6V8chL2dFZa\/16\/WbqNkDo8sfgKLpcD8FZg\/BPvZ4cOHuZ+zFYQpU6ZwqxlMPDg7O3M+FJU5VersHGWo9wRILNT7R4AAEAHzJnA\/Lgsfb\/obP84eArHt42iGsY+yMPTj7fhr8Sto4OHGQVh74Cr2nbmEzR+MgpPYHkt+O41DV+7hxLKxOidbmVyBITO3ITE5F6NfbI1Zb3SrNbAKhQKbNm3C2bNnuWBMmo5W5ubm4saNG\/D29ua2QygRgeoQILFQHXpUlggQAaMnkJZZiGGfbca2+SPgo7aycPp6PN78ej9urp\/MnRpgERm7TlmH3m0bYumkZyESCjFn7REkZRZh8\/uDePUzIjoZ4+b\/AYHAAuHrxsBBbM2rXFUzMcdFdiSTHa2kRARqkwCJhdqkS3UTASJQ5wRyCyQYtXg3fn5vMDydxWX2\/HIgAvsv3sa8V3sgv6gE\/95NQvSDbLw\/qgcaejly+T7bdAqebtmY\/Dw\/scDKsCBN0fEZGDe4DaaN6gLtERWqj4Ydq1y+fDnWrFlDd0BUHyfVUAkBEgv0eBABImC2BIqlcmw5dgMBno7o0zYQArVgSP3mbMaz7YMx+rkwSGVyyBVyeLo4wNbqceCj5Mx8LNl6ApNf7ILmAe46tyIYyO2HbuDL9We4IE07vnoFLo6aoy8yp8hj5+8h4k4S51jZIbQBuoY1hEjEP8wzC+DETkawYE8saiMlIlBbBEgs1BZZqpcIEIE6J7Dv3F3EPcrA8D6tyq0qSGUKNBr1DdbNHojnOjbSaicTERfvPEL0gxQMfaoZ58egK0XFpGH2ssNIzSzAzNFdMXJAKy7+AktMIKRm5uPstQT8\/PtVFCiFELs4Akol8jKyEexhhwX\/64MAH5eyMrraY7EX2JFIFvWRRYqkRARqgwCJhdqgSnUSASJgNAQS03KxevcFfDK2J8Q2pVEUj1+Lw5zv\/sYfn78GP\/fHJyQqGr371C1cjYnBZ2MGQGDB74tfrlDio9XHcPDMPfTuGIjPpvaBnbUlouPTcOhMNC7fTUO6BLBzcYKVmsMlEwwF2XlwVRRiweTeaOjrwpvha6+9xvktDBkyhHcZykgE9CFAYkEfWpSXCBABkyOQUyBBzxkbsXvBcDTydebs7zVjA6xEFtj\/xShYCp+8b0HVyfd+OAJbu2IsfGOgXv2+fjcFb3y4F9aWQiyZ1hcnL9\/HuZtJsPb0gJ2TAwQCIbQ5MxRkZmNoGy+MGdye9+rCgwcPsGDBAnz33Xfc\/RCUiEBNEyCxUNNEqT4iQASMisC9uCy89e1ubJk\/AjaW1th89Dr2n4uGk9gKM17uhI7NtUc0nP\/zcRy6koALa8bw8ldQdbygqAQvv7sDyRn5sIAC3o394OjhCoFQqJONVFICi4w0bPhkMMS2\/O6TYKGe3377bSxduhTu7u4626huhtjYWLz\/\/vuIiorCnj17qh3Ourr2UPnaJ0BiofYZUwtEgAjUIYHER3n4aP3f+P7dQbCz0e8o48pd53Em6h52fvw67x4cv3Aff5+Jxr\/xOUhPzuHKNeoQAktr\/l\/8GQmP8HqPQLwxuD2vduVyOefoOH78eO7CqdpOx44dg4+PD7KysriQ0oMHD4a1tX5sa9tGqr9mCZBYqFmeVBsRIAJGRoDFT1i8+ShGPheGpn7evK0rlEjxwboTmDOiK3zdHSotxyIoXr2VhM9+OIYMiRJejQIgEImQEBmD4oIiOHu7wqcx\/\/shFDI57p6PwImf34STw+NAUpUZsXbtWgQFBeG5557j3UfKSAT4EiCxwJcU5SMCRMBkCaTnFuLQpRj0DHNHA3d+gmH36Vto1sAFoUHeGt0LmEBITs\/HlagHOHQhBreT8mDn7go7x8cnEjKT0pEa+wiWNlYIaBms1+pCevxDvPZUEMa+1L7ckU9tg8BCO7Ov+9o+QsluuWTXXXt6enLXbj969AiOjo50EsNk\/zr4GU5igR8nykUEiAARKCNQWCzFlv3\/IvxqPDLlItg4OcLK1hoWgvInJkoKJUi4GQPZ\/18VbWdvwzkssuiOVnY2ELs4wc7JUaujIwvp7JCTjqXTnoW7y+NgUtqGYffu3cjLy8PYsWNrbaQKCgqwY8cO7s6JDz\/8kLvBcsyYMdwWCJ3EqDXsRlExiQWjGAYygggQAVMhEP8oC+8tO4hMmRCu\/j4QWmo+TcFWHvLTs5ES8xCW1s6wFrtAaGnDgi1AWlIASX46LG0t4BnsV\/4IpRqI7IcpePellni2axOdeP744w+kpaVh4sSJOvNWN8OKFSu41QUPDw88\/fTT3P\/39\/evbrVU3ogJkFgw4sEh04gAETAuAlKpHHO+OYz7eYBY7Z4JTVYyJ8WCbDls7D0hEGp2bpQW50EqSYd7gDvsnEtDTKun4rwCNBBJsHL28xAKK4\/zYEixcOLECXzwwQc4ePAgd6slJfMnQGLBxMaYfa2wPcJz586hf\/\/+EIvFSElJQWJiItq1a0f31ZvYeJK5pkUg4s4jzPouHB7BAZUepcxOTkN2UgHErv6w0BHMSSGXojD7PhqENoLIuvxRSfb3nhIdi6+m9EaHFn6VwmLbEOymyXHjxtU6VPb+eeONN3DhwgW4urrWenvUQN0TILFQ92OglwWZmZn4\/fffMWvWLPzyyy\/cPuGhQ4e4PUQWkMXBoXKvbb0ao8xEgAiUIzDrq\/2IzreAvZv2r2nma\/Dw5n3YOATBwkJ3XAXWQElRNmzsS+DawOsJ4kV5BRClp2Dz0hGwqeT45datWyESifRycGQrBGwLoWnTppyzYmWJHc9kPgtMwJw6dYp737D3UKdOnbiPFhbrgW1NsJDTLi78o0\/SI2YaBEgsmMY4lbOS\/bGOGDECPXv2xJQpU7izzuHh4XjhhRd0\/sGbYHfJZCJgNATGzd+JTCtHLgqjtsS2DtIT2OTvy9tuuawEFhbp8Ajy1bhikX4vDvNGdkLfLo211hkREcH9\/bdo0YJ3ux9\/\/DH++P139OrVC68MH44uXbpwgkNTYiuYX331Fdq3b88dz2Q3XV66dAmLFy9G8+bN8e2336JJkyY4fvw4Fi5cyAkISuZDgMSCiY7lRx99xIV1\/eSTT3D06FHu6yAsLKzKvWFfBWfOnEFOdnZZHXZ2dujStSt3LIoldh1uZGRk2e8FAgG39dG4cekLrLi4mFv1YEkqlXJfIF6enujVu3dZwJaLFy7g9p07ZXWwPC+++CLc3NzK6ti0aVO5fvj6+nJCSJXO\/PMP2ItRlZgdb739dtm\/U1NTseW33yBXKMp+xry2VUfK2E19Bw4cwN27dzkbma0ssYh0qnTlyhUcPny4nB2tWrbEiwNLw\/4yr\/OtW7YgKSmpLI+XlxcmTZ4M4X9R+tiXXuT162W\/t7CwQP8BA9CjRw\/uZ+wI2pLFi5FfUFCWp2vXrnj55ZfLtpPY+LK2VIl93U2bNg2NGpVefsSYM0909fTSSy\/hmWeeKfvR9OnTUajWBuO19scfy37Pvgbffffdsn+\/88476NixI\/dv9lzMmzeP+2IskUjK8mzdtq1sUmPPzepvvilnAxsPJmZZunf3LpYsWQK2KqZKjNV3339f1s9vV6\/GgYMHy37PJj3WLpu8WGLL3osWLUJxUVFZHjZhvffee2VREd+cOBExMTGldkul8PP1xeIlSxAcHMz9jO3pf\/3VV+XsnPnuuxg6dGjZzxi33JzSQEosNQsJwbp168qe3xnzFmPPjo3lTj20euUDOPg8vozqwg9T4RoyDC5Bpf3nkxSyEjy6tgX58eHcM6lKAV2HgP0nk5TAPuM+7v6zEelpKWW\/b9e+Pb7\/\/ns4OTlx5dgz\/PvevWW\/t7W1xdIvvkC\/fv24n925cweDBz2+bps9P5L\/xtXGxgZ9+\/bF9z\/8oDFkNFsxYSsLbGzYEU1WjpVnq5n5+fkYNmwY\/vzzT0yePBkTJkzgHB8pmQ8BEgsmOpZsCfD+\/fvcHyabwNkEU53E\/sg\/\/eSTcmFb2Tnq9+bMQcOGDbmqmTPTxg0bypphk86YsWPLXkRsUmMvbJbY79g5MSYk2AtdtT2yd+9e7Ny5s6wOS5EICxYuRGBgIPczVsdbb71VrivsS4k5U6kSm6QP\/v13OTs2qNkVFxeHhQsWlHuhsy8f1aTKxMHGjRu5CYhN4MwGlthLUpVOnTwJNtmrp06dO5ftB7OXJguCExcbW5aFRbRjvFRfZpt+\/fUJUcNEDxNPLBUWFmLBp5+Ws7Nt27bc5KWK779s2TLOw12VbKytMW78+LIxYS9sNomqJ\/bCZ1+KqvTNqlXIVhOB7Hjf\/Pnzy37P9rnXfPtt2b+ZIFJFAWTC6vvvvuMmA5GlZVm8gVmzZ5eJhVu3bmH\/vn3lbBg4aBCaNWvG\/YyJt3379pUTPUyAsiN+jD9LJ0+e5MSoKjGG\/fv1Q8B\/zx4LL8yWzJlYUqUmjRvj6Z49ywTHnt27kfGfIGHl2Zdtnz59ysIfs7+X06dPl7OT3dbIng1VYs8mE0iqxCbhAQMGlAnAqFt3MOmjnyB0cioTKa7BbWElfnwZ1aNr4SiWOMHBq025tir7h1wqQXFOJGxsisvFdBB7NoTYIwBKhQLZsTEYGCqEn4ddWVWubm6coFJtITCRm5iQUPZ7JlzZSoCvX6m\/Q05ODk4cP16uv4yrj68vd831pEmT0LJlS952qzImJCRg9OjRYJEdmThl4mSQmijRu0IqYHQESCwY3ZDwM4h9wTOfBbYNwSYH1QR17do1bjJu3bo19xXAJic26etKv23ezH15bdi4sSwrm\/DZS4ib+LnrdRVlX+HqL3XVlzT7meorRVWGTQbqy5rs64dNQKpU8feqdiraq6pPVz\/o90SgNgnI5Qp8\/es\/OJ9UDBsHzddBs2f8YVQMRJZeEFmzif2\/+6krMawo9xEcvazh5Fm6wqYp5aZlokeQA+bScxxeAAAgAElEQVSN579ioYvFsq+\/5kQrE4ihoaFV3sZkYpKtELIPChZymn0gsFVHSuZDgMSCiY7l+fPn8fnnn3NfyOreyGwZdv\/+\/ZyIYBe8sK8r9mWkKzGx8Ne+fdi2bZuurPR7IlCvCZy8HIMvt1+Bo\/+TpxM4MVwiQ2psEvIy8+DkHghL68r37qXF+ZAUJqJhWHNYCLQLC7a6EB9xC3u+HgEf9yePWdb1oLDYC2xFigVtYiuf2nwf6tpOar9qBEgsVI1bnZZiy6RsOZXt5asvoTKj2JIiW4pk+4XsWBPbg62YR5PxJBbqdEipcRMiICmRYdqSP5Fm5QRrsS1nuVwqQ2FuAfIz85CXkQO5TM4tKFjbimFj584JBgt2LbVaUshLIC1m\/hEF8GrcACIr3RdN5SSno3MDW3w4uS9EOuIuGBop88G5fPkyt6JAzo2Gpl\/77ZFYqH3GNdYCO\/XAvI\/ZMn6HDh00bi8wZycmItq0acPts7L\/zWcJn\/kssL3MFStX1pi9VBERMFcC568lYPaa4\/BpGoSc1GzkpmejpEgChVzBiQRbBzu4+npAZClEXno28jOZz4cdBCJrzhFRXlIICwsZnLyc4OjppjUKZEV+rGxhXDyWzXgOTRrW\/lXU5jp+1C\/9CZBY0J9ZnZVgWwTM6W7VqlVlDoHqxjDHvZkzZ+LTTz81yJ32dQaCGiYCdUiArSxk5BTh9fd3IqdIDrm0dBWBiXN2P4RnoDdsHcXljkAyf5+inDzEhP8GCyjR+NmxsLQWIeKPNQgb9DZEVvxulmTdzs\/Mxost3PDmsE7cPROUiIAhCJBYMARlA7TBtiaOHDnCBWhinu7sKCUlIkAEao5ATn4xrt5KRvilWJyJSER6diFXubWdDexdHWDv6sitKKhOeGhq+cbuL6BUyNFq2PtQKhW4eWgD\/Fr1gEuDprwNlZVIYZefhVWz+sOZ5\/XVvCunjERACwESC2byaLAvF3YEjiW2X6g6emcm3aNuEIE6IyCTKbD72C3sOXYLD1JyUFBUGpfD18MB1lYWgKcnrO1sKxUJKuPToy9yxyA9QkrjRzy4fgrFuRlo\/NQQvfqXkZCE6YNa4oWnQ\/QqR5mJQFUJkFioKjkzKxd95w5i4+LKYiaYWfeoO0RALwJFEhkepuTi1NV4bD90EykZ+dz10q6OtmgW5I4hvUPQp3Mwdv59HZv\/iYODd9VW8qTFBTi38WN0fWMBLG01H8XUZHhJUTGy7sXi9xWj4GjPfwtDLwgA5x\/FjkXSZVH6kjO\/\/CQWzG9Mq9QjOg1RJWxUyMwISGUKnL4aj6MXYnDtTjKS0vLAAir6eTqiX\/dG6B7mj+bBHrCzKT25kJZVgHHzd8EuKIi3k2JFZNEnd4KFe27ed5ReNFPuJ2Bc36Z4fWA7TsjURmLxXJgvlCr6aW20QXWaBgESC6YxTrVuJYmFWkdMDRgxAZlcgaPnY7Bm2yUkpeeBBV9iycfdHqNeaI1hz7SAlZUQAg2z8pqt57DnQjw8gwOq1EPmu3BkxWT0emsFrPRYXWAnI8SZKVg2ewCcHUqPcNZkYqsKLDokOynFTlVRqt8ESCzU7\/Ev6z2JBXoQ6hsBtooQ8yALl28m4Y\/wO7iXmMEda2RbDc0beeC5Lo3Qs0NDOOlY5mdCY+jsrbDy9YNlhSumKzKNPbkVLLRz475juHDoqhR9cges7V3QsD2704P\/MkFeUgqmD26FZ7tqv2CqKuPKOHzxxRdcREf1e0OqUheVMQ8CJBbMYxyr3QsSC9VGSBWYCAGFQsmdZth\/OhqRd1PxMLXUMdjLTQxpRhSWLXgHzYIebzXw6daWAxH47WwiFzOhsnTnwPcoyc9Ey1feh4VFaRh1lgoyHuH+2T8Q2n8chJbWfJrk8rAbLoNtZVj2ru4orbwrBbgLuRYsWMDdLMmunKZEBEgs0DPAEUhMTMSjR4+4u+kpEYG6JMC++NnpHitLIa8TBppsZV\/GMQ+yEdzAmauD\/VtSIkdUTCqW\/XoOUTHp3M9EIgEc7awxZlAbDO0bgv7P9QG79VR1UyVfDvcS0jHv+3BYevtWujAQ\/fdaSHLT0XLY++UuEFPIZYg8uA7BnV6Ag6c\/32a5Pjy6E4uf5\/VH44CaC9LEwsizW2fJV4H3UJh9RhILZj\/E1EEiYDoESmRyLN9xDrfj0zB1aCd0aPbk\/Qu6eqNQKrH7aBR+P3EHX0x\/BrkFElyMfMg5Ld68lwp2ATTbaghr5o2e7RuiT+cgOIpLv+ZZuHR278rcuXN5RT5V2cK2Ir5efxLnkiSwc9Z+b4M2scDqeXD9JLKT7qNl\/\/G6ulju9wVZuXCT5uGHT4bC2rJ8SGm9KvovM7sMjm09sOuuGzRoUJUqqIwZEiCxYIaDSl0iAqZK4NKdJMQ8zECgjytORUZj6uCusLXW72jgXyfv4PN1p8FWKIIbuCA3vxjp2UWc06KttQhD+oRgcO\/m8PWwh72ddbmTBCyk+meffcZdie7urt+XenR8Ot74cBcCO7Qst2qgPhb3T2xCSV4mQga+U24bguVhvgwnvp2GpyYuhY2DC+8h5G65vBGNL6f0Qdc2pdfJVyetXr2aW9l555139BJM1WmTyho\/ARILxj9GBrGwsKAARcXFcHOrfM\/VIMZQI\/WWQEFhCWxsRBAKBIhPyYGLgw23TcA3sZWDOSuPlvkhsHJsO8PLzR79uzXCawNawdWp8pMDy5cv5+5eYZex6ZveWrgHDxQsoqOzvkW5\/DHn\/kRhdhFC+w+vdAumKNcK9896wtaxBEGdUyArkaCJlQQLpjwLaytRldpmhdLS0tCzZ0\/8888\/5W6zrXKFVNBsCJBYMJuhrF5H\/vjjDxw7dgzffPNN9Sqi0kSgjgiwmAhzVhzBjXup5SyYMKQthj0bCm+38vc1aDPz6tWr3N\/Bzz\/\/zN33oE9KTs\/DGwv\/gkuQPwR6lmXtsFDQR5ZfQOsXW8E7xEFj0wq5BRKuusFCoERWoh0C2j2Ci78UstQULJrwFEKCPfUxuSyvXC7HwoULuUvohgzRL6JklRqkQiZFgMSCSQ1X7RlLpyFqjy3VzI9AfpEUp67HoUVDdwR6uyCvqASHL93H0B4hOh0dc\/IlmLJ4\/xNCgbUc6OeMPctG8L50iS3B9+\/fn7uwjc\/17hV799naE7icUgI7Z82TvS4a+xbegaRAjq6j\/eHb8sk6ZCUCFOeJIHYtgUwihKRACXs3BXLTMjGotScmv1I1J+U7d+6A3Vq7bNkyvUWSrj7R702fAIkF0x\/DGukBiYUawUiVVIPAtuM3sOtkFPq08cLbQ3riRlwqXl24C6dXjoWLo12lNbP7Gh6l56GoWIq8whLkFpSguFiK7PxiMOfD0S+G6eX89++\/\/2LRokXYvn07RCL9lvXPRsRj6bYrEPt6P2FzbtJdyIry4RLcRqsA+uPj2yjKkXFl277kjUbdXCGyfnzMUhsIGbsN834sti9+GR4u+h93\/Omnn+Dk5IThw4dXYxSpqLkSILFgriOrZ79ILOgJjLLXCoGd4VE4d\/smlv\/vFa7+99Yew6JxT8PaqjS8siHT+PHjMWPGDLRu3VqvZvMLJXhv2UGkWTvB0qa8v0Xc6R3IfXiHi7MgEGoWIXvev4WSQjnXpqW1AEGdXRA2yAtCSwFKikSIv+wOeYkMTZ5Oh6TACndP+yCkTzysxUBWUip6BDvi\/Ym9ea+ksHZycnLw5ptv4ttvv4WnZ9W2MfSCRJlNjgCJBZMbstoxmMWAP3b0KFZ\/+23tNEC1EgEeBPadi8ayXZdxYtlInLweD2dbAcKa8I87wKMJ3lkuXLiAc+fOYfr06Tq3QSpW+seJm\/hqy0X4t2pW7ld8xMLO2VGQS0vDTatS877uaD3Qmzu5UZhljVM\/hqDTyEgk\/uuP5NvO6D7hKuzdSv0rsm7fxU8fD4a\/N38ny6lTp3IxVt544w3efChj\/SJAYqF+jTf1lggYNYFjV2Mw6\/tjOLd6DP6JikPX5oGwt7VCek4hHmWUXurEtiT8ParmD6BP5x8+fAh2MoIdpWQBivRNw2b9BrmbF2zsH5eN+2cnch\/c1rqyoFQosf3dm+CCQbDr5t2s0PFVX3g1sS874qlUWOD6vgBICgQI7XcHYlercqblp2VgUBsvTBjSkdfqwq1bt7gVlD179nDX21MiApoIkFig54IIEAGjIXDx9kO8sXgvpr\/SFUOfagIvl9IARzn5xXjh\/S34cdaL2Hb8Jt4Z0h4e\/\/2utoxnjo4ff\/wxBg4ciM6dO+vdDPNdWLDpIlwCfMtWJhLO70V23A20fGUeBMInt1YKsqS48NsD+LZwwLW\/krmth6fGBcC7eXkfhHv\/eCPqmC9e\/OjiE9sZcqkM4vxMLJ\/ZDy6OlR8TZScgPv\/8c\/To0QO9e\/fWu49UoP4QILFQf8a60p6yFyML7qLvUTHCRwRqksDtBxkY\/8Ve7Fv4ClxdnMqqLiiU4vkPtuLYslFYsOEUBnfzRofmzWuyaY11sRMCI0aMwJUrV\/T+28grkGDaVweQJ3Ypu2CqKDMJxbnpcA7QHrhJZcjhZfeRmVCExt1c0WHE41sfZRIBEq+54crOYAz85BysxAJu1UEuFcBCoIBACGQkPsK8YW3Qp3OjShndv3+fOwHBjkxWZfWk1geAGjAaAiQWjGYo6tYQ9jK8efMm7VnW7TDU+9Yj7qdAIChB66Dyfgp\/X7qHa\/fT0bGZF6IfZOHNF9pwgZsMkSZOnMitMAQE6HcFNRPf2w5ew5azibDXccGUpn6k3itA+HdxsBBYYOAnTSGT2CMz0R4iqxI4eObj9LowNHnqFnxCimEhtMaD666Q5AOh\/R5BVlIIYUYaNi56GXY25bcp1NtiN0s2btwYQ4cO1dsvwxDsqQ3jIUBiwXjGok4todMQdYq\/XjeeX1yCy9HJKCgqhruTA9o38YZIWP6a5gUbw7l4C96uDnAS23BRGQ2VcnNzYW1tzf2nb2JBmv732e+wDgysUpCmI8vvIyO+CI27uyKkbxAeRLghoF067FwkeHDNHSXFcjRslwWlQsTFXIj4syHaD4uEpY0NHt2JwbQhbTD0mZYazY6NjcWkSZM4XwUHh9r3AdGXHeU3LgIkFoxrPOrMGhILdYa+3jd8JzEds9YcxrzRvfBU6OPldhWY5Mx8fLntPOa82gnertovaTJWkF+tP4ljtzPh4ucFeUkR5NISWIlZP8oLIk32x13KxoUtD2FpI8CAeU1g66Q95kNuii1S7ysQ3EkCgQiQSaWwTHuE7z96CU725e\/XkMlkmDBhAsaNG4devXoZKzqyy4gIkFgwosGoS1NILNQlfWq7MgKRsSn4924K+ncKgKcz\/+OAxkI1O68Ir8zZAedGgci8dwFZsdfQpP8kjQ6OFW3OSZbgn3XxKMiUos1L3mjaw02rxmBiIfJAAJr1vgP3wNKaCh4l451BrfBs1yblqmZHQrdu3cqd9tA36JSxcCU7DEuAxIJheRttayQWjHZoyDAzILD+jyvYcT4RhY8ikBZ9Hq2GzYNApN2XQNVldlT0wqZExF3JgX8bR3Qe2aDSaI7Rp7zh3ewBHL1KVyCK8wvQ2kWAjyf3gVBQupLBTkAsXboUffv2RZcuXcyALnXBEARILBiCsgm0kZycjPS0NLRs1coErCUTiUDtE4iKikJiYiJ3CqJZs2bw9fXV+0SEysqER9mY9e1xpD66gbRbZ9CKRXDkIRZY+dS7BTjxXRxEVhbo\/XYQXBs+eRwy5rwnpEUiOPkUwjskuwyOQq5ARmwi1r73HBr5l94oGx8fj5UrV3InIMhXofafI3NpgcSCuYwk9YMIEIEaJXDo0CG89dZbePvtt7lbGAMDA6ssFqRSOb7eeBr7jh9FVuyl0pUFS34Ok2x14fBX95D1sPiJY5R8OpyfkQ1\/UQlWfzAIQqEALFrjgAED8Pzzz9MJCD4AKQ9HgMQCPQhEgAgQAQ0Ebty4wU2o7Fixh4dHtRldvJGIt+Z8DWlhApoPms57ZYE1zOItHFkew8VCeenzEFiLH58GsWCOkjp8JWMu38C6+YMgL0jmxEJ4eDj5KlR7ROtXBSQW6td4a+0t24ZIS0tDK9qGoCeCCHAE9u3bh\/Xr13OOgFZWuv0L+GD734I9SIItxGoBp\/iUkxYrcGJNLCcagrtZwi\/0AZTKYlgI7CCy9oXY1Qu2jg4QijQfKS3MyUMjqyJkRe\/De7PeRYsWLfg0S3mIQBkBEgv0MHAEdu3aBbbsyq6ppUQEiAAwevRozlfhgw8+gKCGAkDFJ2Vj\/OJ98GgcCAs96mRbEbePpeL6vlSIXQvx9PgrsHUqgkIuhFRig7xsf8ikwXD19YHY9XHkS\/VxjD17FL2CpVjy+ULafqAHXG8CJBb0RmaeBeg0hHmOK\/WqagTYcn9ISAh3idTw4cOrVomGUqzeGV\/tR5zEEnZO\/AMhyWUyRJ+Kwq3DSsilFmg7+CYC2z0s14Kk0B5pD4JhaeMPt4AAWNvZlhMk\/\/6+Bm+9NhjT36y5\/tQYGKrI6AmQWDD6ITKMgSQWDMOZWjENAteuXcOrr77KbUU0alT5\/Qr69Ijd8PjNut2Is2gK54AGvItmJSVDWngKUYc9kHzHAwFtktBhyA0IROWvslYqBSjMdUFhng8Ewsawd\/fgREluShxuHd2K0K6v4LfPX4WTQ\/kgTbwNoYz1lgCJhXo79OU7TmKBHgQi8JjAzJkzwQIXMUdAG5vHEytzemzZUnP4ZD78Tpw4gS+\/WgHvtq+hwNUPQkvtERlV9SlkMsRcuYoGTc8jN9kOx3\/oApGVDM9OOwOxS5HGZhUKIaRFdshKC4aFRUPcOrwcbYdMg1LggkHtfPDOyG58zKU8RKCMAIkFehg4AuEnTuDCxYuYO3cuESEC9ZpASUkJnnrqKe7a5q+\/\/prb32e3sp48eRKurq4Qi8XIzs5G69at9XZ8ZOJjzZo1GPDqTGw+lQCv4IDKTzIolUiNfQAL\/AMXz9Jth2PfdUXWQyc0fSoOrQfcrnSslEoLxEcUICEiHi2fnwd7N29kx8Zj65evwtfD9EJn1+sHs447T2KhjgeAmicCRMB4CGRkZHBOvizC4eTJk9GzZ0\/OOHYj6\/nz57Fp0yZua+LIkSPcTY0sXoE+SSUWvv\/hJ7z+0R6IAwNhZat9S0BSWIT0mAh4BJyHQCDnmnoQ6Y2LO8O466gHzDoJG4cSrSZIJVLcPHILjbs1Ayz8UFTgj6IcN0x4qT0mDO3IxV2gRAT4ECCxwIcS5SECRKBeEGArCBKJBOyiJXZnAoveyBL7N1thsLW15WIdHD9+HMHBwQgKCtKLy9mzZ7Fi+XJs2LgRl2+lYsGvF+DVSPvqQlZSKiA7BAfXlLJ2CnNscGZjB+Sk2KN57\/sIfeauVhsyEzORcj8NIT2bcvYzn4biAgdkJzXBs5074t0xT8PBjl9wKL06SpnNjgCJBbMb0qp1iL0M2X\/q+7NVq4lKEQHzJhAdHY358+dzpyTY6gKbhPmmnJwc3Lt3D2FhYVAoLTBx0Z8oFDvD0ubJCZuFak66dRbufv9CZCkpa4JtLdw43AR3TgfDzT8b3V6\/Cmvxk6sLTNT8++c1BLZrCFd\/l3ImSouVUBb7QiALwgvdu+GZLs3R0M9FV2wnvt2kfGZIgMSCGQ5qVbp07Ngxbpn1ww8\/rEpxKkME6g0BNgnHxsZizpw52LFjR5VjMLDYCVsPRmDbuQcQe7g+wS\/lfgKEFmfg\/J+vgnqGjARnnF7fkcXgRav+CXD0UUAuE3FbE1Y2hRA7ZSI99j5SY9LQun9LCCpsNyjlCggUcvi6eyAr0wmyglBMGtYHT7dnDpH1Ziipo3oQILGgByxzzkqnIcx5dKlvNUUgNzcXly9f5qpzdHREhw4dqlV17INMzFp+EFYNA8utUEiLJYi9EoHAVmfLfBXKNaS0wImfusDGxQkNWrvAzskVAqEVlEo5SopyISlIxt2T36Dba4Gwc9YcfVJaVAI\/dzHsxdaQSoV4FNsdS2a8jEDf8qsQ1eogFTYbAiQWzGYoq9cREgvV40el6wcBdr3z0aNHOX+FJk2a6N3pgoICxMTEcOGWVf4QX\/wcjvB7OXD2Kb1\/gq1cpMYkwMbmOMROGU+0oVQIkJ3mj4Lc9rBz9NN4x4RSqYAkPwNQ3oCbXxQsrYo11KOEQC5DgI8zd311SrIb+rUfjdcGtNO7X1TA\/AmQWDD\/MebVQxILvDBRJiJQLQJ37tzBF0uX4pvVq2Fvb8\/VlZFdiJff2wbP5k24ux0kBUXITDgP9wb\/wsKifNAllr+40AGZyb1h69gIFhaVn2YoKcqCSHgSrj73NdqtKJHC08UOjmJr5Obawd9xID6Y+EK1+kiFzZMAiQXzHFe9e8Xuhjh8+DB+\/PFHvctSASJABMDFYtB1h0RUVBTnHLlhwwY4ODwO97z053CcjsmFo5c7MhITIVCEw8Ht8QkIdb7JMe0hsu0EkZWdTuxshaEg6y58g\/+GQCjTuLpgJwS83e2Rn28HD+sBWPD2SzrrpQz1jwCJhfo35hp7zM6XZ2VloXHjxkSECBABPQmkpqZyER8HDRpU6ekIbWIhMTkb01YehYWTC1LuXoBX4DUIRVKNVsRH9YWjZ2udqwqqwoU5SXD1PAAb+5wn61MCCqkU\/p4OyM91RcdGr2LyK0\/p2XvKXh8IkFioD6NMfSQCRKBWCRQWFmLq1KlYvXo1F+FRW2KnKGbNmsWtLDAHSVWSyuRY\/us\/2BN+G67eV2DvnK61jrgb\/eDsE4rKQz8+Ll6UmwJHl78h1lKnXCqHk60IhVntMH34KHRrG1irrKhy0yRAYsE0x42sJgJEwMgIrF27Fkw0zJgxQ+vqQnp6Ohfuefbs2U+Iil2HI7Hitz\/g0zRCo6+CqrtxkX3g5N0aFoLSgFG6UkH2Q7j57IeNXZ7GrEqFAtICGwQ6jcDi6S9AbKv59ISuduj35k2AxIJ5jy\/v3t2\/fx+JCQno1bs37zKUkQgQgccE2LFKFmzp6tWrcHHR7\/hhyf9\/3a\/4NRynb2+AjWMeLDSEYS7KtUHiNR8kRXvDv60d3ALCoCsogkIuRXHeTXgHhWs+gglAIQeS7rbE8ncnoGubhjSkREAjARIL9GBwBLb89hsX837L1q1EhAgQgSoSWLVqFXf0ka0u6JOSUnMxc9m38PSLQmJaFixtH0d0LCm2ROwFf9w+HQRpsSWEohI07mGBBmG6\/RYKsx\/Ayuow3P2ztJqTl+mGIKd++O6jYbq0hz5dorxmRoDEgpkNaFW7Q0cnq0qOyhGB8gQmTJiAZcuWwdnZ+Qk07MQEC6tuZVV+qX\/R2kO4m3oA3j5ZSEjOQaFEhNxUZ6TcdUfspQYozreGhUAJB\/cCuAVkw6dFASBqBkubAIisxU84O8plEpQUpkOSG47MuEMQu9jCs5EnnLwcIRA9Pm4plwlQlB6KFTOnICTIk4aSCGglQGKBHg6OAIkFehCIQM0QYNdad+zYsezGSvVa2YmjlStXcqGiVY6Q16MfYdayX9G67S0ILJSIuuyIiH88kPnAhRMJLDl65iO4UyK8mqRD7FIIFl4hP8MSUScK4NNqMERWzhAIRGBHJWXSQohEyXBwuQc7xwzIpcXISc7BozspkJXI0KhTEBy9HKGQyVCYK0aXRqPx\/sR+sLLk5wNRM5SoFlMjQGLB1Easluz97b9tiK20DVFLhKna+kKARXiMiIjgnBgrprS0NEyaNIk7DeHk5AS5QoEZS\/9CvuIIclIscXpPQ6QnlcZPEIoUELsWIqRXDPxbP4KFhfJxdUrg0q4r8Av1hVfTABTlOUEus4KFQA4bcR53P4SmlJGQgWv7I+Hm74Lm3RpBKe2NDyeMQufWAfVleKifVSRAYqGK4MytGHu53b59G6+++qq5dY36QwQMSoCFdB47diy+++47eHiUhnBWJfa7UaNG\/ScWnHHwaAzeX3QMqQl5SE0UQyG3gJ2DFD6NMuHaOAG+zXNgafNkMKXsRzm4eeQmuozsAqHatoK2jjI\/CoVMDqEFYCMSICchC\/eu58HOugmWL5yG7t26lIWfNigsasxkCJBYMJmhIkOJABEwJIG7d4HTp4HXX1fAyqrysMoV7dq0aRO3usB8FzSJhdmzV2DDhkT8\/XcCkh4VQqkAJxKad0pDWI9k2LsWIyElFUJb6yeOYbKJ\/9aJO5wPgnvDJ2+rLNegUgmZVAbI5XB1Kg3rbCkSQKEQ4sLZAHwwqi\/++n07d+Rz3rx5CAkJMSRiasuECJBYMKHBIlOJABEwDIGiImDSJCXS0y0wdmw2hg93qjQyoyar2rZtj5deWolevRrj6ad9kJtbgujoVLz4whvIyR0KicSK22qwdy5B47BMdHzuIRxdJWVVsTsjMvIlEFlZlqu+MLsQ987dR+gzLSDU4mfABAW7htpCLoej2ApuzmIIBI\/vnk5+5IKWDQbhvXF9ubpPnDgBdpKD+Vq89tpr8PPzg7X14xMZhqFOrRgzARILxjw6BrStpKQE7D\/V5TYGbJqaIgJGR+DqVcDKSo6AACG2bQNGjmR\/G\/oFK5o27QesX69A+\/b+GDu2GfbujcXx4w9QXJwES0sfWDpK0b5nIpq2S4eT25O3QjIoMQ+zoBSKYKE20cdeiecm\/oZtAp4I4sgEgkIuh7VIAAc7Ky7AUkXHRYVCgJTE1pg\/8Q00aehexp5tkRw\/fhz\/\/PMPLC0tudDVnTp1MrqxIYPqhgCJhbrhbnSt0kVSRjckZFAdEpBKAcv\/PugV3MWPynJf5rpMi4rKQo8efyAzs4TLamMjRHGxnPvf3bp5oe9gV5y4eQpdu0dzRyK1paycImTkl0Dw3wqCUqHEqV\/OoMvITrC2eyxe2EqCTFICK6EAHi5i2NlYarU3J8cOfuKhmDexLyxFT56AKC4uxq1bt\/DZZ5\/Bzs4OixYtQmAghYDWNebm\/nsSCxrP+NEAACAASURBVOY+wjz7R0cneYKibGZNQCYD7twB0tLYpF7qq\/DoUem\/W7YEBDxcFx48KMDw4Udx7tzjWyOZWBgwIAAzZrRE2\/au+GTNAchs98PWtlRMaEsssmNSWh5kFgIIhAJEHbsFa7E1GnUJBpjTooLdBKWACEq4ONlyPgkWFo+3GyrWK5cLcCOiFZbNeh2hjb10juXBgwexfft2hIaGol+\/fmjatClsbGx0lqMM5keAxIL5jWmVekRioUrYqJCZEWArCsePA5MnA\/v3ZyA01A3h4cCaNQps2ACIxbrVwpgx4fjtt7uQyx+vGLi5WeO33\/qiX78G+GbtVpxPuAX\/oDhe9IokUqRkFCAnqxDXDtxAp+EduBMQ7E4HB1tLONhZV7qSoN7Ig0Q3tPAbiHkTekGoIaS0JoNycnJw4cIFnDx5EmzVYfTo0WjTpg0v2ymT+RAgsWA+Y1mtnpBYqBY+KmxmBJ5+Gpg27V8MG9aW69mqVQq8\/bYFLC01f7WzbQAWcGnChK9x7pw9\/P2boahIgezsEs6xsaBAho8+aotPPmmPZmFt0fPVNnDz4vY3eCWlErh8\/DbYpdW+zb0hthXB1dGO94TPGpFKRYiKbIqdX70LB7F+\/hcqI9m9FxMnTkT79u257QlPT0+9HT95dZgyGR0BEgtGNyR1YxBbbjx16hSWLFlSNwZQq0TAiAgMHgw0bQp89RWwaxfQvHkJQkOfnGDz8\/Nx6dIlhIeHIzMzk4vaOHDgwCdOErDtArbSEHHnISaMfw69RraGrT3\/0wYlxTKc3vsvOvUPhYNLadAmfVNysht6NB+OiS931bfoE\/l\/\/\/13HDlyBP7+\/ujbty+30sCcIimZLwESC+Y7tnr1jHlCFxUVwd39sXe0XhVQZiJgRgQmT2YrBcDcuUBOjhS9e1uW+4Jm9zv89ddf2LNnD1q0aMFNmGxfXxXCWRMK5n8wau5W3PlnEXqNDNNLLMTdfITk+Ax07h9a7mSEPsiTE7pg\/sQRaBzgpk8xrXnZ9sSNGzewd+9esPfH1KlTOQaUzJMAiQXzHFfqFREgAtUgsGSJErt2KbFyZRa6dXOFUGiB1FTgl1+A0FAFevcuxty573F3PDRsyO9a5z1Hb2DjwV2IPb1NL7GgkCuw9evDGDixBxzdxFXqVUqyM5p4voR5E3tByMdLU89WTv9\/9KpPP\/0UXbt2xVtvvcVFrqx4WZaeVVJ2IyNAYsHIBoTMIQJEoO4JbN8ObNiQi3Xr7ODnJ+IMunQJyMwEzp0rxNSplnB357\/snpNXjIVr\/4Lc5hDir8cgKMwbltal9epKURdikZqQiZ7D2lXJP6BEYomIqy2x4bOxaOjroqu5Kv9eIpGAbWcy4cDuvXjuuefQpUuXKtdHBY2LAIkF4xqPOrMm8vp1REdH4+Vhw+rMBmqYCBgLgZ9\/Bvr1k6FBg\/ITOltdOHpUiuHDBRBpiFGgzf5LNxKxbMuPCAhKKH8hlI4OS4pKcGjjeTw3ugtsquiUGBfrhf4dR2Ds4PZVEhv6jgnz42D3zPzwww9cGOkFCxagSZMm+lZD+Y2MAIkFIxuQujKHTkPUFXlq11gIJCcDGRngthuaNwe8vZ+07IcfgH37JFi5UoDGjfmtLMhkCkz49FfYupyHk5Pm2yC1MbgXkYi87EK07dWsSpgkxZZIS2qLHz+aBLFaEKcqVVaFQl9++SW2bNnCXVA3dOhQBAQEUJyGKnA0hiIkFoxhFIzABhILRjAIZEKdEmCnHk6eBKZOLT0JoSm2ETvCuG1bMdq2FSAkhN\/xw73HbmD9\/u0IaV66qiCXKXjdFMlgnNzzL1p0CoRHg6ptHyQ\/8kDvViMwZnBHg6wqqA8gc5hmjp9MMGRnZ+PMmTMQCAQYM2YMF9yJkmkRILFgWuNVa9aSWKg1tFSxiRBg0RtZaGcrDRqA\/W7GDCU8PS0QFqbE88+zmAu6O5ZXKMH4j3aiQaPjsLIuvWr6yPrL6Da0JcROlUdCzMsqxOnfI9DvDXZ9tO5gUJqsib\/bA1\/NeAX+Ps66ja3hHJs3bwaLy8Bu3mRRJdndMzdv3uRaadu2NH4FJdMhQGLBdMaqVi0lsVCreKnyekiABWrafeQG9v6zBQ0CHpYROLj2Ap4e0RpiZ1utVORyBXYsP4ruA7vgbsRbSI4LRrs+BxDS8Spvn4eY+954KnQQ3hnVHYJKQkDXxtCwAFXsyuvFixfDza1mjmrWhp1UJ38CJBb4szLrnAkJCUhKSiLvZbMeZeqcIQnkF5Zg3qptENifhq3t46un+YiFe9cegPkrtOszFMUFDnByz0TcrWA0bXsNtvaP69LWn8ICa8TcbY1Nn0+Eq5N2UVJbPI4ePcqtKrCjpZTMgwCJBfMYR+oFESACRkbg\/LUEfLl5LRo3TSzn\/3DghwvoMbwVHFw1R2JkqwpHt1zEU4PbQOxYtUub4uO8MKbfeAzo0dzgVNiKyttvv41JkybRdoPB6ddegyQWao8t1UwEiEA9JZBfKMFrczagYZMrEIuLy1H4Z1ck2j7bRKvPQkpCJmIiH6JTvzDkZ7vBRpwHa9tiFBXYQyGTQ+xUVCnVkhIRCjO6Y8m0kXWyqsDCQLOojitXrqTATGb0\/JNYMKPBrE5XWPha9h9dP1sdilSWCJQSWLvjAo7+uxtBwclPnKooypPAWmwFgUDzpVRn912HT5A7pJJBuH25M3yCLqLN09dxcONEKJVyDJ78Q6WYExN80L\/DK3h9YHuD+yqwuArPPPMM1q9fj2bNqnbck54h4yRAYsE4x8XgVpGDo8GRU4NmSiA5PQ\/vLd8D78ATEAj43yzJcBTmSfD3r+cw8M2nYGklQvytUITvHoGuz++BnWMORKJ0eAfmaSUnlQoRc6s71i0cCXfnql04VdVhYdsPW7duxd27d\/HJJ59UtRoqZ6QESCwY6cAY2iwSC4YmTu2ZK4Htf0dg\/8Xf4OObolcX2WR74JezCO0ShMBQX65sXpYr9n43Hd0Hbkej1lGV16cEbt9ugJHPjsCI\/mF6tV0TmdnFUixa4\/Tp03nfl1ET7VIdhiFAYsEwnI2+FRILRj9EZKCJEBj1wRq4+\/wLG9sSjRbHRCTBr5kHrG3LB2pIjsvA+QM3MOh\/T5dtUeRmuuLPtVPRtudahHarXHzk5tghP7MTflkwFpaiqsVlqA7iCxcu4MCBA5g\/fz5EIn73XlSnPSprWAIkFgzL22hbI7FgtENDhpkQgS37I7D71FY0avxIYwRI1hV2GqL7yy3h5PH4BkmpxAKXj15HQIg3\/Bp5oLhQDEsrCVITfXDzXE9kp3nhhQlrYGlTAqXCEhlJvhBZSuHmy05alPo+JMb7YcKL49G3s+HvYWD+TuPHj8e0adPQoUMHExoxMpUvARILfEmZeb7w8HBcvHiRzkWb+ThT92qPQFJqLl6buxFtO0TA2lqqtaED358vFQue9mDho2NuuCD9oQyFueHoPqg1RJY2uHDoeUBpgabtT0NS6Iq9a6bj2VFrENzqHuJvtUROhguir3bBMyO\/hbtPPmRSIYqznsHCt4fAzcC+Cqyjf\/zxBw4dOoRVq1bBkk9oy9obBqq5lgiQWKglsKZWrUKhANszFQqFpmY62UsEjILAil9P41rCTnh5Z1dqz4HvL6Dby6Fw9rBH5FkvHN8eDBfPCIT1vI6wHqWrAnK5kBMLQpGM+\/8ymQgCoZxzmMzLAhycgVO\/v4zgVqfQoHEaom4G4vV+L9eJr0JxcTEGDBjAXRjl4+NjFGNBRtQ8ARILNc+UaiQCRKCeEUhMzsbH32+Hu99ZCARKnWKhdZ+2iIlqgstH\/CCTCuDieQ2jP8yADc+bIdk2xcVDfdF90O8oLBTjYUxnbF46Cg5ia4OT37NnD2JiYjB79myDt00NGo4AiQXDsaaWiAARMFMCv\/55GYevboNfg1SdPbxxuhDXz7bFw\/se3DYES8GtHmLYtFidZblVB5kISfebwN0vBjbiEtyK8se8N95E97YNeZWvyUwSiYQ7Jjl27FiEhITUZNVUl5ERILFgZANSV+Ywf4XI69cxYeLEujKB2iUCJklAKpNjyMyVaNI8ClZW2n0VWOekJUJsXNgWWanWUCofB2Vq3CYTQ6foOBr5H53719si+t\/2cHTNgFJQhE5dRVgxZ3idsLt9+zbWrl3LXUNNvgp1MgQGa5TEgsFQG3dDdBrCuMeHrDNeAkvXnUBE3H40DNS9qsB6kf7QjvNTiLv1+NrogJAcvDorklcnE+40h0xaeuxSbiHBlFeH18kJCHbl9NChQ7Fw4UK0a9eOl+2UyXQJkFgw3bGrUctJLNQoTqqsnhCIup+C2ct2oEXYFQiF\/KI1SoqE+OunEMREusDJLRcKhSXsnWUY\/cE1vahJJJYoSHsGX88eAif7ql04pVeDFTLv3LkTp06d4u6AIMfo6pA0jbIkFkxjnGrdShILtY643jQglQIffwy0aVOCYcMsIRRqvgPB1IHIFUp8t+0MIhO3wcUtl3d3ti76F8lJwyCTeaLLgFN46iUR4qNcERiaxbsOtoURcTUYs0e\/hue6NeVdrqYy5uXl4X\/\/+x+WL18OLy+vmqqW6jFiAiQWjHhwDGkaiQVD0jbvtn75BcjJkSMuTogpU9LQtKmHUXZYLpdX64uYuwNi1S\/w9IuASCTn3cctC\/9FSvLLsBBIMO7TGDi563+CITPTASjsgW8\/GAZrK8NHS2QxFSIjI+kEBO9RN\/2MJBZMfwxrpAf5+fkoKCigr4QaoVl\/K5FIgMxMKby9RSgqssDRozIMHCgsizJoTGTGjBmDn376qcrXKH+94QQiYv+Cn386727lZ1th55dXkJ09GF1fuIIuz7sAei68KBQWuHPLH1+88w6aB9fNV\/17772HUaNGoU2bNrz7ThlNmwCJBdMeP7KeCBCBKhKYOXMmmGCoyoT3MDUHY+evReu2t3ivKigVFti5qgXykrdDIWiFMZ9IYWWj\/6pAXq4dPKxfwIeTnoeVpeGDqF2\/fh0\/\/vgjtwVhZWVVRfpUzNQIkFgwtREje4mAkRKIiwN27AA8PDIwbpwbZ+V77wGvvlqI9u0Ne10yH0QHDx5EcnIyxo0bxyd7WR6FUokPV\/2N5IID8PTK4V32wT1H7FoZChvrP9G+nw06PufAu6x6xrj7IZjy8qt4ukNwlcpXpxA7AdGvXz\/OqTEszPA3W1bHdipbPQIkFqrHz2xKs\/1bFvKZzkqbzZDWSUd+\/hl4\/30lUlLAbT2wedjVVYlly\/RcazeA9Szq4IoVK7B69Wq9WrsYmYjFP+9Es5YRvMux4Esndwfi4uEGcHZPxktvRcHTX\/+v8vw8W+Qk98Ivi4bXyarCrl27cP78eXz99de8+04ZzYMAiQXzGMdq94IcHKuNkCoAcOsW0K8fEBurgFAowMGDQGBgAZo3f3zDorGAYnehsFsSZ8yYgUaNGvEyS65Q4JvNJ3E7ZRecXfJ4lWGZslJssWNlKHLSbdCqewSeG52n9ykRuVyA6xGN8eX08WgT4su77ZrKmJubi48\/\/phzamzQoEFNVUv1mAgBEgsmMlC1bSaJhdomXD\/qT04GevQAIiNlSEgQITLyEYYO9dF6XXNdU2FxAr766iv8+eefvJwwM3IKMXnRajRsdJu3rwLr4\/mDDXB6byCUykKM\/\/Q83P30X1VITXVCsNvz+ODN\/hAKDL9Sc\/nyZRw+fBhz586t1imSuh5zar9qBEgsVI2b2ZUisWB2Q1onHSooADp1Ag4fzkZkpAi9e9vB2lrA3YFQWAiw24uNzScuICAAbCL09PSslBlbiXhn8V7kKk7BxyeTN192UdT3czqhKF+E0C7HEBySDP8WnrB3seVdBzsBERfTBJ9NmoSQ4Mrt5F2pHhlZ39mKwvDhw9G5c2c9SlJWcyFAYsFcRrKa\/SCxUE2AVJwjoFAALPLvpElZ6NXLCS1aCLifHz4MnDsHCIUSvP22EK6u+p8CqC3E27ZtQ3x8PObMmVPp6sLlmw8wd9UmtOtwh7sqmm86tbchzh\/wh404E2M+uolT28+j84vN4dnwcbhnXXXl5ojhLR6MueOegY214dmdPXsWv\/76K1atWgVra\/3jQujqH\/3e+AmQWDD+MTKIhexl8O\/Vq5gydapB2qNGzJcAEwsbNmShVSsXbvuBrTbEx8s4gfDjj3L066dE586Gn\/C0EZfJZFw0Qubs6OCg+YSCVCrHR6sPId\/iD9g7FPEevJwMa2xf3grZqdZo0zMaz7yWhv0\/nNNbLFyPaIVFb49E+xZ+vNuuyYy\/\/PILnn76aTRu3Lgmq6W6TIgAiQUTGiwylQgYMwG21RATAxQVAS1bPmkpW3XYvTsf3bpZws\/PeL5O2RL7F198gZ49e6Jr164aEbMTEMu3bOJ8FXgnJXA13AcndgRDZJWPF8ZfReMwIf789hw6vRAC7yAXXlWlpjjDVtEb33wwGCJh6UoNJSJgaAIkFgxNnNojAmZGoKQEWLcOcHcHAgJKtyE0+SVcv65ERkY+evWy5+VMaEhMbCsiPT0dU7WsrH22dj8Scg7A1ZX\/CYiSYiF2fROKB3cd4d8sBsOmPYSllYVeYkEqFeHu7ab4dt5kNPThJy4MyY3aqj8ESCzUn7GmnhKBWiEgkwHsPojevYGgIECkYYfh3j3gwQPm\/Kjg4nnY\/x973wEW5dF9f9hdeu\/SBSmCigL23ns0do1GTYxppvjFL78YYxJLql8S04xplmiisSbG3rtgb6CoINJ7X2CXbf\/\/HQKiIizsLu7CzBMeA7wzc+fMy77nvXPvuVb6cQxx69YtLFq0iNmUkpKCY8eOPaI1kp5djOeXfIu27e7UK1aBSMKfX7QDBSc+u+A43Hwr1BaL80phZmUKY5O61Rezs20R4TsRr07uVV9VaJ3sNR+0+SLAyULz3fsHVn769Glcvnz5sW9WzRmmK1eALVsAd3cFXnnFCAIBdwXX534Qi4FPPwUIR4ph+OwzFdq2bfzUP7KZxMeIFJw\/fx50z1M9lLFjx2Lw4MEs2r9\/\/\/4YOXJk1fIoVmHmwi2wcDgJB0f1vQoKuQC\/Le2AnDQLeAbEYMrbeQ3ypqQktMeC56ahjb\/2akBIJBLcuHEDsbGxmDJlSoPsqs\/+82ubBgKcLDSNfdR4FTwbomYI6fz9zz+V8PYW4NAhBcaPVyIiwlhjvPkADyJw+XIObt0qhESigEKhQnm5AlJpxf\/7+9tg9OiWGkFGngMiw9u2bUNhYSE6deqE8PBwBAYGwszMjI2dmpqK8ePH4\/jx41U1Dw6euYNvN\/+J4DZxMDJSqW3D9TOu2LfWH0aCMkycew3ereVq9628MDvbBt62T2HB7IFaUWuUSqXMc7J+\/XoEBASw+IxBgwY9Qhbi4uKwceNGRigoTZLknYODg+ttP+\/QtBDgZKFp7WeDV8PJQs3QkTZAXh5AgnUSCUX2l8PRsf6COg3emGbS8cSJDAwevAtS6aMpibGxkxAUZNsgJMiTEB8fz9IiKSaBAhm7d+\/+2LfpMWPGMJXCsLAwSKQyLP7hIMpMtsHUVKb2\/Aq5EbZ\/H4KEGHsEhidj+HOJMKngI6yplKqK+etwrpw41g4bPpsFX08Hteeu6ULC4Ny5c1i4cCGrKkvpj87OtZcN37BhA5YuXYro6GguwKQR+k2nMycLTWcvNVoJJwsawcc7awGB1atv4bXXTqGsTFE1mqWlCCdOjEJoqANEIvWOf8iLQC52ekBShURKjXzmmWfQsWNHiGoKqKhmO13\/119\/4f3338fl2DT87\/dV8Pa9Wy+vwr0b9vjn5yDIpMDAZ66ifc+yB4jBrhVRiBgWCDe\/x5OAlGQnBLkNx\/svDWjQMQFleFDtC0qJpjURYZg+fTpCQ0PrPEajvvPnz2cel8WLF2thZ\/kQTQEBThaawi5qYQ2cLDwIIqX5UZzC4cMqDBwox8SJxkhPB5YvV+KTTwQ1BvFpYRua\/RCLFl3E0qWXoFTed\/m3bGmNHj1c8d\/\/hqJDB6daMbp48SIrnywUCln8QUREBEihkb5Xp+Xn5+Pjjz9mD8sPfz4IufFJ2NmL1eladc2eNYGIjnSBpXUeZi2JgZnlgy6Ef747g45Dg+AeUFGZ8+EmlRoj5V4b\/PL+K7C3UV\/lsXKctLQ0\/PDDD+xYZeDAgcyT4uPjUydJqOxPxILSSN977z0MGzasXmvnFzddBDhZ0NO9LS0txZo1a5hIzLPPPtugt4v6LE0mk7E3MHPz+n841WceQ7v2p5+AW7fysGyZDYqLRXjlFRV+\/lkCmwZ8iBva2p+EvTk5EkybdhT79yfDx8eaBURmZJSyWAZqzz4bgLfeCmXHEubmIvbGTAWOKGDxl19+Af3dLFiwoNajhrrWRbUirJz88Ne5GHQIj3+sV4GyHCi1saTQFDKpCOZW5RAIFfj53QjIy40w8oUzCOnyaJzDP9+eQcSwIHg8hizk5tiiW+A0PD+mi9o1NSgeITk5GZs2bcL27dvZsQsFbjakiiwRJiIZFLdAMR28cQQIAU4W9PQ+2Lt3L3Mf0nkruQ979uypp5Y2bbMuX6ZI\/gKsWWMFoVCEnTtlGDvWGGq+qDZtcHS0upiYfDz11H7Mn98ew4Z5YffuJGzefBcnT2ZALlfC3t4UI0d6Y+BAB6SmHkZxcQ4cHBzQr18\/FrTI4gE0aHv2HcQb736JoTO8YWkleWQkuVyIvDwrFGVYwP1uPnxzM2EllyDHxBo\/ZXdD0h1rOLlnYvp7tyEyedSW2siCSmWE5PhOWPTSJAT51h5XQIaJxWJQMSwKyiTvCXlSyBtgYWHRYAR+\/fVXVljr999\/h42NTYPH4R2bFgKcLOjhftIbPkUiUwQypTnduXMH7du3V9uVqodLMliTqOTyq6+qsHWrEZKTVcjLU6J\/f\/Vc2ga7aD0wPCWlhJECilmgM\/T8\/HJcvZqLxYsvgoIh6Wfm5kawsirBkiXdMWtWBIyNtbMv2w5cw+zp4zBtfjjMre4rTdKDPCPdHhkJdghPvouRqRfgXF4AC4WUxSpeLffE6IxXoFABg5+NRYfeNRebOr\/nFlqFucPB7VFp6Xv3XNDeZzjmz+oHQS2VJcmjsmPHDuZNoawGSoH08PDQiCRUbnvXrl2ZtPNnn32m9tGFHtwy3AQdI8DJgo4BNpThKVKc3I+UUsXbfQQSEoBp0xT45RcBoqMlGD\/eFEZGAhQWAlZWNQsQcfy0iwA9GOkc\/ubNm1i\/fgNUqrZISAjE7dsFyM2lN38jREQ44cMPIxAW5gg3N4taH7S1WVcqkeHDH3Yg6sz3UMkK0G14e0ikJijIskTJbTMEZaTiqezz8C7LfmAYBQT4IO8prCvuCm+LDAQNKEP7kWkQCNRPtywvFyHmajts\/PwlONo96hmgl4jMzEwWuElBmC1atMDs2bNZvQZNvSmVi8nOzkarVq1A2RDV9SZiYmLg5eXFPQ3avbUNajROFvRsu+gDgSrglZWVoe2\/AvsU2U0pT\/b2upN75QGONd8IFNQ4bpwS06fLMH26gr25JSZSoSRgxgygpWbp\/3p29+mXOeRVowfjvn37WDwNedo6d+6MoKAgdiR0+HAqtm9PwPr1dyAWV6Q2dunignHjfDF5cit4eVnVe0FnrtzDVxtXwaflPWz84jgiBo+FV4YE7VMT0KEoAR6S3BrHjJc5Y1b2s6B\/X7HdDft2Vkgc4AIPz5qvr2mQpHsuGNFlMqY91fGRX5PS5NatW5Gbm8vWT8Gb2iQJlRMSSXj++edZJoW7uzv7cUJCAtauXYu33noLJItNOgyvvvoqfEmuk7dmgwAnC3q21fThuGTJEmRkZCAyMpIFKFGw0YwZM1igo64aJws1I5ubC\/zvf\/mYN88Kzs4VYkwKBfDJJ8D48UBz1arZvHkzi6ehZmJigokTJ7I3T201OoP\/6KOPWCzC3Llzme4BlUZ++A2aYhjy86VYuvQyfv75JhNyEgqNYGoqxNy57fD22+1hZ6e+LsaIOT\/CxuEO0lIdURh1GJOLYjHJWA6RSl6rLAJ5FBbmjYIKRjjvuQRmZgK83OlVdO0TC6Gw7nLW5FXIS++Mr+ZNf8CrQGqThMOFCxfwySefoFevXiylUVuehOr7tXLlSnz55ZeMHFA2iJWVFSMnFDD57bffol27dkhPT2dfu3fvxo8\/\/lhnKqq27gc+zpNHgJOFJ78Hj1hALr8BAwawAEcXFxdQOlhBQQH7ma4aJwuPIkukgAIc6bihdesHf\/\/xx8DYsc2XLNBb\/8yZM9kb6JEjR9iDRZNWXl7OyEdUVBQuXbrEhnrllVfQunVrtc\/NKTDyhx9icPRoGlODpPRLPz9rTJ0agLFjfRESYg8Tk5q1GpLSC7Dr+A3s\/H0\/2ooTMTD3KgS5CThcVo5Xbc1Rm8KDRGWMXqn\/RYbCBrNtduAD+yhm\/9f+o5Dd1xotWhQ8AM3lg3HwbuMCR\/f7wYNZmU7oGTwZzz3dCcXFRbhy5QoLXKQH99NPP40RI0Y88ZglyjQhwkZHIRT8SPLYXPpck7vesPpysqCH+0Vsno4gDh8+zFyOv\/32G0uDsrOz05m1nCzch5YknpcuBVq0AKhMgJ\/fo7A3d7JAZ9uTJk3CsmXLmNiRJo3IBqXpETEmDwKNR7oADXl7lstViIsrZKmXv\/56C9HRVJOBjous0auXG158sTW6dXNlMQ0UJHknMRfbDl1H4YWraHnhGNqW3GJHDcYqBYqUKnxRUIa37cxhXUuw4beF\/fFFwUDYC3Nx2uNbWBlVHImkmjli2cAx8G2X+YB3Yce3ZxA2yB\/ewS7sOsquuBPTCZ+98RQunT0OyoQiHMiLQEcv+pSRQIJX5IEYN24ci5ngrfkgwMmCHu41vbXRh8S6deuYR4HerioDD0kPgVToGvJBWttSL164gOiYGHbcoY1GHyqVtlJKF30w09sjNbKdXNfU6Gf0dlKXsp42bFJ3LL\/5lAAAIABJREFUDJkM2LQJGDq0ouzyw40Em4hMjBsH\/BtWou7QTeY60jUYPXo07t27V7WX6i6O7g3SBTh16hRzd4eEhLB\/27Rpo+4Qal1HSpDr19\/G\/PnnUFxMOiJKdkQxapQPFnwQio37ziM16hJm511BeFYcCoqzYWz8oKzz8sIy9DA1RmezmqtkFijNMTT9TaTKbfG23T68YXu8yjapwBjf+49A+XAhrKqlYFYnC\/R3ceuGK4yLLJB5+ygoE4HUI\/WJIFQuiPaNiB29wFAMFR2RavtzSK2N5Rc9EQQ4WXgisNc+Kf1RUqEbSoeiFCYK6qIPFQr0ooerm5sb+5m+NiI7lNZFHyRUiIbeEultiQKj6FybXNekwU\/KeuRqvX37Nou8ptQvQ2gU9LhuHdC7N9CtmyFYrH0b6cya8vGpMJO6rmgij3T2TrE4RDJov0eNGqXzIkUFBeXYuDEOP\/56HdevFEKlrKh+GdSiCO9ZXsQY6wTkZmYCQvEjJajvyZWYmyPGFlcbGD8kmUB5DmuKuuOjguFwEBRhpfPv6GSa9gDYRx3bYe+AcHgF5lT9fMc3p9FhYAAsbI2RcCMbJdn2GDe0HyZOnPBEggbps0Wdhz6lc5NQnKWlJTw9PdnnE\/0\/b80DAU4W9HSfSViFIp4puIsYPGVI0BvH119\/zYKQSJJWXxu9Mf7xxx\/4\/vvv2TkrKctNmzaNfdD4+fkxlTkKYCNJWvqg+vvvv1nAFD18eDMMBChinlzlr7\/+ep0GkxeB3kiXL1\/OvAd0Bk\/KgPR2qi7RqHOSWi7ILyrD7zsv4eTuC+gQcxMnEl1wqMgDCpURbITlCDAtwgTRaYyxvQQLQYX3q3qblFmMhfYWaGfyoI5DvtICr2Q\/g9OSVuhnfgWrnLfA2OjBYMYikQXeC5kK32FZMDauqDxJZKFMUgZ7d2uYObTHWy\/8BxOGd1Xrga0JDjX1pRLdFItQV2Ep6ksCUOTppEZKrxR8qg7J0LbNfLwngwAnC08G91pnpT9eEluhHOpKJbaDBw+yBypJ0VLg11dffaVVVyV5LOhL00A1WhgRBSIGhw4dYut88803QUGb5F0g4kMZH7Q2esOk9a1evRqrVq1iBEKfjiP08NbQC5OI4NGDnsggZUHU1WhfK6sYUlxCY7QyqQxpmUXYd+gKDu2MxNjCWxgnjoOFsuKYIUrsgg\/TO+J8iTPyFRXCS62NMzDP7iA6mSbBXlgCASo0EpLkSnxRVI6Frs5QCCqOI0QqJe6WOmJK2vOMdOxz\/xrBxg9qL1Suc517P5zv5glbyzjERCUgP6MIXYa2QQs\/NxRn9cVHc8bBxVGzANGGYEr7SBU2n3vuOUbieeMI1IYAJwt6dH9Q9gOd5WdlZaFDhw4PkAGqQ79z5058+umnmDNnDr777juWQqWtRg\/2qMhILHz\/fY2HpLdIOoMmUkAEhKSq6ShiC1VmApgiJQVsUqAU\/e4\/\/\/kP85xQihZv+o8A7dXw4cPZ\/Vj9IUOZDHTs9PDbJj2U6KsxvAjiUilOXbqHi+duwfRsJNpkxKF7WSpslY96DMqUIuzNsMGOYi8cKAtm2QxEENqapGKk5XUMNr+JFmZFOGMfgmVFUrRsNwpl1u5QCYxgJSlEWaYY1+9aoHfeJXxlvwPCf8lF9R3MUSixTybECodgePqVwifQAZ6BrhCKBLh3zw3DO03As09FNFhESpO75ezZsywlkoi6Nj9LNLGJ99VfBDhZ0JO9oXN+0nUfP348Ez+xtbV9wDIiEORRoD9scudqu3SsNrMhKNWTxFvIC0JuTiqLS6SAsjqoUToYxSwsXboUTz31FNOhJyKxfv16PdkNbkZtCLz00kusBDSRwspqjqQLQvLAFJfwxhtvsCC4xmzi0nL8fSQGO3ZdQK+UaxiXcx2OijKYqe6Xu37YHplMgdSsfKhMSpGqsGPqi2uLu0OmEkBkpICTsATubiWw6t8aAitbCI3NYfSvZ0GlUkKlVEBSnA\/n1Iv4JG4tbORlVVPIVSqsE0uxv1SG4RYmUPl2xY1hIfDyqXDjl0uNcS6qPXb\/MBt21o1fvI3ioug4iLQbKsXfGnO\/+FyGhwAnCwa0Z5RKGR0dzcrHkudBm01bZKFSsIXePEkBjkgQBWNSbYtKMkAPGvIs0FFLjx492Fsn5W2Ti5oEqNQtJ6zN9TdkLBIAKimRw8Hhfv2AhoxjKH1IRZGIIJFWkgQmMkheBApcpRRKOn6iDB7SA6H91nWTlsuRklmIqPNxiNpzBv6JNzCh+A7c5eqVlC4sliCvOAfGJvczILIU1vi+sC+OSQJxT+4EcztTdJnqB+Fj9BlojTJJMVrePYw37vyJEkkxzkrkOFImQ5ipEGMsTdFCKECKmRO+6TsSnuE5KMgsQkq6P16fPAvDez8k4KFr0P4dnzyJ9EUEjzeOgDoIcLKgDkrN4BptkQXyGtADhVI\/KZiN3mBmzZrFhFzIbU1EgCLiSdCHzrIdHR0Zofjpp59Y5gepxBlK3AKJAL333jl89lkXtG6tOw0Mfbn9KFCRiB7taU2NAh4plkbXZIFIwpkriTgTGQvji+fRLjEaHaTZaCEvqVVlsbrNKhWQkJoNkUnpIxkQShhho2UP\/GQ7HlYOjnANtKXyE7U2SdZtWB\/5CN7iNISaiNDFTARX4X0pJ0qj\/Ml3KCSjjXFk3Qm07zwNa79dAGORdopf1eceoaNB8iiQZ0HbLx31sYNfa1gIcLJgWPulM2u1RRbIQEqxog8j8hZQowfM5MmTsX\/\/fhYYR+l25GWgLAhqlAVB8Q0\/\/\/yzztani4GpNsHAgbsRFuaEnTuHwMODp5Hpmiwcv3AXy9edgs\/daMzJuwz\/8oKqQMT67HFmrhhiSSFMTR+NZaBx3gmagYzWoyAQVUh819VkZYXwi\/0HH97dgsc9\/g87tse2bt0Qd3oLPnz3U0yaOK6uYXXyeyLulE1F3iAeq6ATiJvkoJwsNMltrd+i6BiA4iAoU0GdVLi6RqfjEpKCvUxayQA7ZqBAKkq1ovgFOuvu27cvS72jRtkSpLWwZ88eg0rF+u2325g58xhbg4+PFX75pTf69XOHSFSbOHBd6OnX78mbQIqilUWF6rKOyEK\/fv2q9rau6+v6vVKlwt2UPFy+lohrByJheTMGo8TxCClXv0DTw3PI5AokpuXBzOLxxxWvh7yI4tYj1L4fKYZBkB6NVZHvw6iGQEeyoVwgwushL+FG3A4s\/2wxe7Nv7EZ\/i+TVmz59uk7l4xt7XXw+3SPAyYLuMdb7GYqLi5m0LFW6JE16yqHWpJFHgbwFlMFR2SgdNCkpiX34UrokibpURs3TWfeKFSuYQJOhHEHQupYtu4p33jlbtUYnJzN89FEnvPBCa6YUaMitqKiIBZ5SKWTyCk2YMKHO5RCxIB0Qa2trFtegSQ4+kYSrsenYvP8aRDHR6Hr3IkJLMuApFz\/2YVyngf9ekFtQiuKyPIgeUmus3r8hZEGYfh2\/Rn5Qq32HLDvgw\/ICfL1sIQvybexGRJ3+1kheu1JFtbFt4PMZJgKcLBjmvmnN6sq3fhJ8okalZyk9U5MPenroE2GgOAR1xqHjCSIXlamVWlucjgf673+j8OWX16pmIYLQqpUNTp4cBRcXzQiXjk1\/7PAUxEiBp\/QwIRXRDz\/8UKt6HnWtSyKVIfZuFtZuOo28i9fxasEVdC1Lr6tbvX6flSuGRJH7SKxC5SCUP\/F\/fpMR5xgEe88OMBLUHVdQXpoPr+it+DBpJ8wfwxOVCgGkUku8GdQR73wyD316Na78J2WqkFeBspC4rkK9bhl+Mcn0q+hpwVuzRYACErt168ZU3KiRlPSuXbuqalE0BBgKWCSyQN4DCqB6XMEZCpS7evUqO5bQdonjhthd3z5Tpx7Bhg1xLEeeKhxGRDhj795hcHbWnv5FfW1q6PWFhYWs4uOZM2fYPUAu8sYqFETYJWUU4EJ0Cu6cvATTyxfQoyABYdIsmJA2s5ZbVp4YEnkOBIIHP\/okKhWiJHLElMuRCBEuBI+HV6dnIRDVXeJamnUbjsc+RYuiZBbg2MfcGDYPFZ+SSkzRwtEJOz3CYf\/+fAzp1biZEKdPnwaJuy1atEjLiPLhmgMCnCw0h11+zBoVCgWTkCYlvspG2QoLFy5kQkmaiOjQGyoFUtnb21epUD5sBvFUOg+nsrfkujakRrY\/\/\/xxODubo7RUjpUrbzCvwqFDI+Dt3fhqfA3Fjt42165dy4JOKRuFUl4bM0I+JbMA6\/65hORz1zEo4Ty6iFPgoiiFsQ5IQiVG2fklKJXmQSiqkF+mtqOkHFvEUrQ3FWKQuQl8jYX4y2cIDgRPgqm1c63wlpcVodXdg5h7ZzNKpSU4VFaO42UyTLYyxUALExbwqFQKIIQt3JxtcdG8BW6\/\/i6mTurZ0G1rUD\/SZhk0aBC6d+\/eoP68U\/NGgJOFZrz\/lB9PNRsoe6F6I0EdSnNsrDdLQ9+CuLgiDBq0GykpJVi+vBvmzGnDChXpayMvEulhUEwJyTBTqiPVemis\/SYBpdTMAuzafR6Xjl7CuNwbGFp6r0qKWde4SaRyJGTkocC0GOekMvwpLke4qQgzrE3hXi3dUSw0wyqvwbjkOxAqGzcIBFTtVcDSKIksKhUyQJwNr5RzmB+\/CdbVRJnS5UqsKJKgVKXEVCtT+Kos4WPnCFsrM5wxdsCVmXPx6kvDdb3UqvHT0tLYiwEpv1ZKyDfa5HyiJoEAJwtNYhsbtgjKUKAzafIwVG\/kUfjoo4\/w2muvNWzgZtZLoVBh2rQj+PPPeAwZ4ont2wfDwqLmksZPEpr8\/HwmxEM6F+RRoOMn8iZQOmtjtPzCUhyKisPtCzdhfj4KHXPvorMko1aVRW3bJVWpcLS4GLszcyFTyhEkAnpaCeBWjSRUn7NMaILztgE47xiKuw7+KDR1YHLP1pIC+BTcRVhuDPrkXod5DXLSdIBCRxqHSxQoUIgw2NkBTzvYY4FYguB3F2HWzLqDRrWxfjruo2BKUtYkYsgbR6AhCHCy0BDUmkAfynwgmdfs7JqL39CxANVw4G8h6m12UpIYPj4bYGIixK1bE9Gypf4cq5AngY4aKFNhxowZmDp1KvMiNFaOfZFYgg17rmDL3iuYlH4JowpuMSlmXR41PLxr5SoVtubn49usLHSxtMRbLi6wgwD5ucUol0tgZiZ7bMAjjUVpj+VGIijIswAjCKCEiVLOvh6XKllpQ3GJGUQOtlhbXIAjRUWQ2jpg\/vIv1CrCpd7dV\/tVFKdAFV7rU05cG\/PyMZoWApwsNK39VGs19KZBGQ+ff\/55rdeT5gJFTmsSu6CWQU3gIgoTHjZsL\/bvT8awYV7Ys2fYE10VlRO+fv06KKiNCpSFh4fjhRde0EpVUXUWViqRISE1D1GRsYjedxqh6bcwvug2rFX3pZXVGUeTa0qVSsRLpTglFuN8SQm8TUww1dERAaYPynMXiaXILy6FQlkGoUgGoVB7QZVyuRBGKmt4udkjR2iBL4zdsDUzBn16dMSsF15giqUP14HRZM0P96WXgnfffZd5Cf39\/bU5NB+rmSHAyUIz23BaLnkMBg8ezIILa2uk\/09n2iTdzFvdCJw4kY4BA3azeIWYmAkICHiwGFjdI2h+RUFBAbZu3cqktFu3bs1IAlWCJEGsxmhU9fH4+bs4fvomXK5dQMe0m2grzYGT4n6RJV3bUaJU4hgdNRQWwk4oRCdLS3SysICHicljVZvpKKlEUo5CcQmk5RJWL0IbpKFcaga4+OCYYwBu+4QgdOxAbPvtc7QNaQ1TMzOkpqayYmpDhgxRK824vthRthFVc6VS1IZSc6W+a+TXNw4CnCw0Ds56NQulyNHDpDJrlqSZK5udnR3TWqBGHoVhw4axtx\/e6kYgP18KSqfcuzcZU6f64\/ff+9fdSQtX0D6SJ4GOGUjgio4aKJulsY4ZaAlkw54Tt\/Dzn6fRJuEa3sy\/DFdFRTpuYzVKhNxRUIDF6ekIs7DAUnd3eBirJ9dc3UZxiRRpOWIIhBKYmspgZFT\/7HLqITUywXrXgTjVqjOmT+yO8YPbwdLcBNOffZYRhAkTJyI5ORnz5s1DXl4ey0qi4GJ1tEnUxZQym0gtlQq08cYR0AQBThY0Qa+J9LWxsalaiY+PD3Nf81Z\/BEgv4OOPL2Px4osICbHHX38NZumUumoUb3Lp0iVERkay2BOq7jl06NBGC1ikgk637+XgyrUE3D4YiRbxMRhZkgBvWVFddZe0BolEqcS1sjKcLilBglQKF5EIzzo6wsekbm2E2oygvSwUS1BcUga5qgxCoVwtT0OJ0BQ3rbxw0bkVTjuEY+rkPpg4JBTWlvePPogYEJGrHg9Ex0XkEaK\/xf79+zNBLE3jhSjLacmSJaysvaUlr1uitZuumQ7EyUIz3fjqy+ZkQXs3QUJCMcLDtzHthd9+64fJk1tpb\/B\/R6Ljoz\/\/\/JN5hyibgbIaAgICGlVpMfJKIrYeuA7L6CvonXgZ7aTZcJU3nieB3tz\/KSjAutxcBJubo6+VFdqZm8PF2FirREWuUKK0TIb8IjFkysd7GkqFpjjm0BbHHNtBFQBIzYxhKeqAXxePh6mJepkxJSUlrOgayWzT8QRJZkdERDTo\/qG4pPHjx2Pu3LnsHuGNI6ApApwsaIpgE+jPyYJ2N3HkyH3YvTsJERE2OH9+klbcyqSKmZOTw5QxN2\/ezHQR6EvTt091V061GkpKy3HjTjrW\/HEcRjduYE7BFbSVNrygk7pzV16nUKmQp1CwgMXPMzIQbmGBt11dYS2skGOuPCwQGRmxWAVtSl3QMUtBkQQ5BSUQGUtZXQmFQACxyBxnHFpjh3dniLwV8A9IZ8cWMdcD8OOCV+Hjbl\/fZbLrKdaAHvR0BEiBxuTxq08th1OnTjHZ7t9++61B8\/NOHIGHEeBkgd8TD7yR8mMIzW+I9PRSlkZJKpY7doTjqac6N3hQUsEkOWyqykkeBSr4RcGpuoygr24sZXncSczGqUv3kHL6IhyjL6O3OBHtpDkNXlN9O1LaY5RYjONiMfLkcviZmuIpOzu0NDGBWKnE1IQERJfRcUEFXRhjZ4cvPD1BpEHbjTwNGSVynBfY4LKTN2K8vWDsp4CzSyEsLKSg7Ie0FA\/0Dh2KVybWrNBItVNIUpu8QXU1qpty9OhRFpxI8UMUrErVYWtrVNCL4pBIW6Ex1TjrWgv\/vWEjwMmCYe+fVqznngWtwFg1CD2zXn31JH788SZ8fQW4e\/eFek9AWQ1U7pneEOlDn2SYPTw8GjVokeIR1vx1HrlXbmBc0lmEl6bDXimFSIdSzNWBIqmwnQUFWJGdzY4YnrG3RyszM9gKhaheBPxKaSkG3L7NvA5EEH7w9sZsJ6d6Y65Oh2MWXthkHwKXruEIbOuLzQcvQmGUBCvrMkgkxsjOssXzT\/fFlGHhsDCvOW6CxJF6dO+OSZMnqzMl6HgiMTGRqS+SZgYpMdaWBknXkq4C1YDQtIKsWgbyi5oFApwsNIttrn2RnCxo\/yagY4hx4w4ydcwjRwaiVy+\/OiehYk7kQdi3bx\/TRxg3bhzLbKiP+7nOSeq4gNzt126nY88\/UUg7fRFj8m6gX2myVl36tZlAXoQ0mQxnS0qwLT+fBSq+4OSEILPHF+cif8KKrCz8NyUFNkIhQs3N8YG7O7pZWsJYQ++C3EiAbKE5rlq4YW\/LjrBo1wbTR0egta8zO16io5lz0clITMuHo50leoa1hL1t7RVHX5szBz169MCUZ56p93YdPnwYy5cvZ\/2JRPr6+rLaKpWN9o90Faj+w6hRo+o9Pu\/AEXgcApws8HuDH0Po4B7IzCzD+PEHcepUBl59NQjffdebVaesqVGdht27d+PixYusdHBoaCj7sG\/s4lqpWUU4HBWHvBU\/o3tJCjtqMFfdL7akA5iqhpSpVEwb4UhxMej\/yZPQ3coKrUxNH\/AiPM6GQoUCLycmYry9PQt4\/Cg9ncU0vObsDDNBdT+E+qu4buqEw5Y+KGwbBt\/eHdG1Q0sEtHTSmDhRLELnTp3wzNSp6htT7UryLpAqIxFKalOmTEFYWBj7f8qOIU0FCoC1sjKcgmYNAoJ3alQEOFloVLj1czLuWdD+vtBRxLx5kVi+\/Dr8\/Mywa9dwBAc\/6BqneASqBHjy5EkWzEZluilgsbHFc6iw0oqNZ3D8yBU8k3YBEwpuQlgVLqh9bB4e8Z\/CQnyZkYFAMzO84uyMEDOzBj3gKY3SRCBg5IJqQMxNTmZiTM\/X40iCvBS3TBzwtV0YJMFt8Mr0Pght7c4yGgQaeikq1026CuFhYZg6bZpG4FJsAqlzvv322wgMDGT1XOg+Io0NSr3kjSOgTQQ4WdAmmgY6FicLutm4vDwpXF3XM8GizZv7Y8wYP1a2m3Qszp07h7t377JgRRLoaayshsqVFpdIcSM+E2dPRePOoUj0zovHUyV3YdYIngR6kMdJJDhTUoLIkhI4CIV40cmJkQVttky5HK8lJeF5R0cMtbWt1SOQLrLENVMnnPMJQ1mHMIzo1wbd2vs81hukiZ3kFXB3d0ebNm00Gaaqb3l5Oav7QEqNJPJEWRCk3llXIKRWJueDNBsEOFloNlv9+IVysqCbm4BIwjvvnMP\/\/ncVHTrYYsqURMTHx7O3QMpqCAkJaXRXcXGpFPtO3cKx07cQFB2Fjlm30UaaB1ulVDcgVBuV3tqp4uPvubloYWzMZJjDzM3hY2qqsWv\/ccbflUox7u5drPDyYscaD7dEYxvssGqFNN9gtB3SHeEdfOHn6QgzU\/W0EXQOWj0moNRaCoil7BkSfaJ6EN7e3vUYgV\/KEXg8Apws8LuDxyzo8B4gCWgnp3UgkZz586X46KM5jX7MQBoJZRIZdh29gQ2bTqJ3WjTm5l9qlKMGJnusUuFwURGWZWTAzdgYyzw9WVGnxmop5eVYlJ6O77y8YC4QQAEj5InM8KNDOC54hsBMlYznJ\/TGoIEDm0TRNLrXKEiWsi7mzJnDjiV44whoigAnC5oi2AT6c8+C7jaRZINnzjyG9evvoFs3Z5w8+TSEQu3n\/9e0Aqr8eCMuE+cuxSP18GkEpNzCoJJEeMjFulvwvyNTkCLJMB8vLkaqTMbSHSfZ29ea1aAro8iWd1JT0cPOCTauQbjqFoS8sC7o0S0Il07uwNOjhuPmzZvw9PRkgaW6buQBoAyX6n93upiTUi5TUlJYvQneOAKaIsDJgqYINoH++kQWJAoJvo76Gm7WbpgROqMJoAts2BCHWbOOw8JCxOpF9O7tptN10fHHkbPx2HngKlrEXEL\/1KtoJSuAg0KiNXd\/mVIIcwEpITzY6CdEEFZmZ8PLxATDbWzQ9l8Z5oblJGgOlcRIhE+NXPDn3auY9+Vq9O7VDt7u9jBSydnbN2kSUDYKFeOapmHQoTrWLv\/qK5by+PSYMepczq\/hCOgFApws6MU2PFkj9IUsqKDC4hOLMaDlAFzJvIJgu2AMDDD8annFxTIMGrQb585l4\/33w\/DhhxFaD5wjZcEisQQXrydh458n4BR3Ey8WXYd\/eYFObq4P0jrii8z2cBRK4SiSwFpYDmdRKRLKcxFsdgzvu5kiWMsBi\/VZSLmREJlCCxywD8AO704Y1q8dNv+6CJ99vJipIFIrKipi5\/qrV6\/Gnj17WPDp7Nmz6zNNg65d+N577G3\/2enTG9Sfd+IIPAkEOFl4Eqjr2Zz6QhakCim6\/tIVR6YewYXcC1h9bjU2TtyoZ2jV3xx60\/\/kkytYuPA82rd3xIEDw+HiUrtwj7qzUExA9O0MnLwQj+wz5+F+8yr6lKUgsDxf3SEadN0ZsSsG3BkJibKiLgM1kZESrzrfwCce52ApeFSfIVIcCltRIVqbJaqlndAQw8iLEGXeAlG2LaHq2hVBnduiV0dfONtb4syZM0yDgM7zRSIRk+Mmz8KyZcvYzygocOTIkQ2Ztl59KF22pY8PZsycWa9+\/GKOwJNEgJOFJ4m+nsytL2SBjiA6\/dwJZ6adwYX8C1h5eiU2T9msJyhpZkZhYTns7NYyj8LBg8PRv7+HRgMSAYmOy8SPm6IguBGNqann0bosBzbKcgh0qJEgVQnxe14Alme2w80yOyirHWz0sU7DTv\/9sBbIHllbhswBfW\/\/Ag\/jLPzg\/SmCzJI0Wv\/DnaVGQuy1bIltjm3Rtm84Jo3rzgiChZkJKuURCDOKSdi5cyec\/tVeIJ0CKs5FqYxTp06Fs7OzVu2qabCl\/79stJe3N2ZysqBzrPkE2kOAkwXtYWmwI+kLWaAP81n\/zMKLnV5EdGY07MzsMD54vMHi+rDhixdfxKJFF+HtbYW7d6c0KNAxK0+MmLhMHNkViZLzlzFBfBvdytJ1ihERhASpNQ4We2BFVhvcltjBCCrYi8qRK69Ie2xvnovI4L9hZvRoHIMKRliTMxLPOO5GdFkQ0mVyPGV7R2Ob6aiB9BEuWLrjeKvOcOvYDpOHt4evh8NjxyYpZNI3qC02obi4mHkakpKSWGor6RWkpaVhwYIFWsmW+OXnn+Hi6orRo0drjAEfgCPQWAhwstBYSOvxPPpCFgiidHE69sXvg5WxFcYEjmHuYmqF0kLcyb2DNs5tYCoyxY3sG\/Cy84Ktia0eI\/ugaXFxRQgP34aSEjm2bx+E0aNbqm17Qkoe00fIuHAdPtHnEVGcgqDyPJipHn04qz1oHReWq4TYW+iFnYXeOFrsjrtSG9bD17QYo2wTMdQmGaPihyDAtBB\/+h1GO\/O8GkdUQgCFCjA2UrLfp8mc4W6c3WAzKfXxspkrjtr6QR4egaA+EQgP9oC3m12dsSAkqU1EgB78VNvh4UYCR1TAi7IV3nzzTdD3VB3y119\/xdChQxtsc\/WOZWVl7Fte5EkrcPJBGgkBThYaCWh9nkafyALhpFDR48AIAqOK+HmJXIJPTn6CLTe24Pth38PK1ArEEUn2AAAgAElEQVSjN45mHoglfZboM7QP2CaTKTFvXhS++y4agwZ54MCBEXXanp1fgm\/Wn8Kt01fwXNYFDBInQqSid\/WKcsy6an8XtMT7qZ0QK7WFXFWxDzZCGRa7X8Asx1hYCOQQGqmwMisEIeYF6G2dprVMi9rWdNHMFf+zj4B1aAhee7Y32vi3gEikfp7FrVu3sGnTJrz33ns16l2QaNarr77KjiboSOLy5ctMQCs1NbXRyoLrak\/5uBwBTRDgZEET9JpIX30jCzXBqlQpsTxqOU4knsCMDjMQ4BAAFysXuFq4GtQurFt3By+\/fBKOjqbYtm0QOnd2ecT+3IJSxMRl4NyJa0g5FoWBhfHoV5YCS+WjsQDaXLxMJUB0mQOmJfTDDYk9G9rVuAwRFjkYY5eAifZ3YSMsr\/eU32VNxors8djg+xoEsMHLSQsww3EVXnE+qdZYSSJrXLZww2X\/MKhC22N0\/zYID2lYzEdcXBx+\/PFHVkeBAhofbi+\/\/DIjBZ9++ikLgJw\/fz6IYOzatatGT4RaC+AXcQSaAAKcLDSBTdR0CYZAFmiNpxNPY9bOWTjz3Bk4WD7+XFpTPHTZv6CgHB06bEVycgk+\/bQz3n67fVUAHtVr2H4oGtcioxEScxYd8xIQIMuHhVK3lR8VKiMcKvbA2pwgRJW44F65NZxFEsxwvIVx9gkINC2EvUjaYM+BXCXEG8n\/xY0yV7zssg+explwN06Gn2nNxxaEf2VBp+1W\/igKaoMuI7qjfVsfdtQgEqrvSXh4L0mk6PPPP8cnn3xSY1XPzp07s1odCxcuZAW+iFS88847LN2ShJu0UaCJ5JiprDSVmeaNI2AoCHCyYCg7pUM7DYEskAbD0XtHMWXLFBx+\/jDaOrbVISK6Hfqbb6Ixd+4ZuLpaIC5+EkqlUvy17yr+3HIKk4tiMa0oFpYq3XoR6GFcqhThbIkL5qd2wfmSiiwAiiv4wP0SXnOOhl0DvAiPQ+5YcQSG3vkOWe17wUb4+DgLClq8Z2yD1U5hSPAPxYsTu6J\/F\/8qQqXpzlA58I8\/\/piRhZoUFCk2gQoxdevWDX369MHXX3\/NijRFR0fj559\/xoYNGzQ1Ad9++y0rHPbCCy9oPBYfgCPQWAhwstBYSOvxPPpMFmQKGZKKkmBhbIH4\/HgsOLQAQ1oNwdTQqXC3dsfxpOMIdAiEj62PHiP8oGmlpXK4uf0OsViGN\/\/PF3bJp9E69RYGlCbBUSHR6TrKVQJcL3PAyWI3rM8LwNUyR5BnwUkkQQ+rTIy2u4fnHG9p3YYz4vYYeGcFLgYPR7BZ0QPjE3HJpKwGU1fE+LSBslMndO0chK7tvWFuZqxVWyirgY4YiDDURBYooPHs2bNMNIkqOBJZWLVqFRNwIoJBwY+aNk4WNEWQ938SCHCy8CRQ17M59ZksZJZkYvY\/szHQfyCeb\/88\/o79G1+c\/gKrn16N9i3aY9XlVfC09sTwgOF6hmrN5lC9hr0nY7HggyjcjlLB2lSOlNDfYa0sb7CbX92Fk\/eAVBdPl7givdyCaSSQ+uI0hzuY5hCHALNC2GrRm1BpV0q5K5JkjngtaQGmOOxGD8sYhFvexIWSNvC2uYfttr6I9Q5BrxHd0aNrINydbWBifF\/sSd31qXPdvXv3sHz5ckYY6ioLvmbNGqbqSMcQubm5nCyoAzC\/pskiwMlCk91a9Remz2ShrlVsitkEKxMrjAioO7OgrrF09XuZXIG8glKcuRiPPdtPwzchBsEZ2Xj+Rm8UKEyxx38vhtkma316ucoIuXIzFqxI8sykukgEgTIZKHDxWYc7eMn5BtyNS7U+Nw2YJ7dBr1u\/4jWX3\/Cswy78nj8Om\/IG4mPvj5AtdMeigtlwH3gbk58OYkGLNpamOrGj+qC3b99m8s5Llixh6ZE1NalUygowTZw4kR0VvPTSS8jLy9MaWfhx5UoWXDnzued0vl4+AUdAWwhwsqAtJA14HE4WdLN5CqUKl26kIPLsHYgjz8E3PhrdJGnwkRWDCjHNvNcXW\/L9WBDhH75HYFqDoFFDLCO3\/s0ye2wt8MWeQm9cKHFmZZlJMGmEbRJG2iVisE2KzkhCdZvPlrRFsNk92AjFyIMF1ggjIPE2gyqiO2Jiu+LTJXZo6a3do4baMIuNjcXWrVtrFVjKzs7GnTt3WFlxgUDAghopuJGCHukYwt\/fvyHbUtWHMjKgUsE\/IECjcXhnjkBjIsDJQmOiradzcbKg\/Y3JyS\/BZ78chercOUzNvIggad4jqY8b81ph+r1+zPW\/o9UB9LDK0NgQ8iK8m9oZp8QtUKQwAXkXzAVyzHC8jTddouFtImbfN06R7IrllAiM8beVP9bZhmDYiM4YOyICVmZW+PYbEV55BXBtxOzXY8eOsRoRpORYkyjT4zaAvA2FhYUsrZIyGXjjCDQ3BDhZaG47XsN6DZUskDz06iurYSG0wJTQKXqzk2USGT76fBu6Hv0LT4njH2sXFWHyvj4VOXIzfOkdhafckxBvYo\/bZs4oFJnDWiFBoCQb\/tI8+MiLYfIYtcZUmSUulzrih+wQHCzyZCJK5KUIMivEU7aJmOV0C76mDwYV6hosympIFFnjrK0PLrbuDL9ObTF5eAdWr4ERiBLgf\/9Do5OF5557Ds888wwGDRrUYAjy8\/NZwKOPj+EE1TZ4sbwjR+BfBDhZ4LfCA1Hh9AF4\/fp1g0CFhJpismKY0mMblzZ6Y\/Py307Cet0qPFd0A0JVhcTx4xoVZXouvS\/atimGb6AFcq09YGRsCiMjIVQqJZTycjgWp6J7znW8kn8ZVsoKUSQ6aoiV2GFtbhBOFrfAlTJHlClFsBbK2BHDWLsE9LTKgKdJiU4LSz28rjIjEc6Yu+OonR9sunREh77hCA1yg6uj9QPpj\/HxwFtvVXz16dM4W0ciS6SjQDoHdnZ2DZqUsiUo3iEyMhJr166Fl5dXvcehYEk64miMolX1No534Ag8BgFOFvitYbBkQR+3TiKVY9RLP2N\/9Gq1XP0yCBBiORNuId4wtahQTayplZcVQJR2DTtTdyBPaoq3krvh78KWINVFaiT\/TBkNC90vsVoNjXnMUGnvCXMPfGMfDs+uHfDm9F6soFMN5ReqlqdUgv2+tmu0uceUAnno0CGmlUCqjL6+vvU+UqC0SvIqeHt7M8noP\/\/8s6p+ibq2rlu3DqWlpSC1SN44AoaCACcLhrJTOrTTUI8hdAhJg4cmFcZnX\/4Rf99cX+cYlJmw3D4cf\/sOh5m1U53Xy8qKIL0SjesXLFEiE8FKIGN1Gfpap2Gmwy20Ni9oVJIghwDxJra4bumG6607wTIsFE\/1DUaQrzMEjcUA6kSt4gI6sho5ciS+\/\/57RhK2b9+OefPmYfbs2RgxYgTatWunVkXJhIQE1p9aSUkJqy9Rk2x0bWYRWaC+r1DABm8cAQNBgJMFA9koXZrJyYL20C0tK8eYl37B\/htr6hw02dgaE70nwMojVO3X64L0ZNzYW4DBSMJ0x9voaJEDj0Y+aqCFXTF1xmbrQKjahaLX8G5oH+IBD1f9rQBKZOHatWtVpIDIwsyZM9ke0dEbqTW+\/fbbjRKH8Mcff7BgSSpYxRtHwFAQ4GTBUHZKh3ZysqA9cOmhNOO9zXj5xO\/oLkmvdeB1NiFY03oSRObqn59Li7Mx\/9paTL5xRGtGn\/PxQesaIvynpaXhH7FYK\/N0796dlYauqd29exeTJ08GpTVqo5Hq4vPPP1\/jUFu2bMGsWbMeO83cuXMxZ84cFk9AaZOVjcpKU4zCihUrWNrl6NGj2RwhISF4\/\/331fJKVI61efNmUHomzcMbR8BQEOBkwVB2Sod2UjqYSCRiM9jb2+Ott95CREQEK55T2f7++2+QVG5lo\/Sx6h+6dAZ8+PDhB6zs3q0bOoSFsZ8VFxdjz549TAmvsllZWWH69OnsWwr4OnP6NK5VC66kc\/feffqgTZuK4MWsrCzs2b0bpWVlVWP4t2qFwUOGVI2xfds2ZGVnV\/3ezNQUgwYPrgpEI7Gdf\/755wE7e\/bsidDQ0KoxqCph9WZhbo4JEyfC0rIikr+mMcaOHYsWLVqw38cn5+Kt0c9gSMm9qmHMjYzwnJVV1fd35XK8K3BBds\/\/g9DYXO3dlYqz8Wn0zxh2\/ZTafeq6kJOF+wjRkcKMGTPwwQcf1Fho6ocffsDx48dZsSn6G6C\/lwEDBtQrDTMqMpLFPVTet3XtD\/89R0AfEOBkQR924QnbQGTBxLhCGMfa2hqTJk1Cv\/79MXjw4CrLfv7pJ9B5bWUzMzfHhx9+WPX95UuXQG9M1duw4cPRu3dv9iNKN1v322\/IyLivJUAejXcXLKh6SO\/etYvlwFdvT48ZU0Va6CH929q1EFd7223brh2mTp3KuigUCqz84Qekpqbef0ibm2PylCkIDAyseJDHx+PXX355YA46y+7Rs2eVHe\/9a1PlRZZWVnjjjTeqAkFJVGfVr78+MMbLr7xS5cIm4jNmwnOwjbkCD3kJu87SyAgLbe+76aNlMnxVLsCd7u\/CzE79csvlxVlYFvMLNiVHa+2uecfBAa7\/ksXqgy4uVeEXI3smv9wl1AvGooZLMNM5\/+uvv16jzTk5Oaz+Akkra6ONHz8e5MmoqV2+fBnr168HeTMoK6KykRehb9++rCQ1eQvo76AmHYaCggL06tWLjdGhQ4cGmUtZGeSBMv73b65Bg\/BOHIFGRoCThUYGXB+n48cQ2t+VY+fikLFwKSbnxTx2cLHAGCM9x0Pk0wlGAnUexCrYpF7GF4l\/w1dWqH2j\/03JjDO2wy639rgZEIYRQ8MxtEcgTE0qPE9NpVXGLBApaNWqFf7v\/\/4PQ4YMqfMBTp4xCoikYlCUhskbR6C5IMDJQnPZ6VrWycmC9m+CrDwxvvp0Ez47upINnm4JyAVGMFECIiVgrFCxf\/dZ+OJrnzEwsfOsgzCoUFaQipcTduGZolidaCdkC81x1MILyZNmonPnAIQHe8DSvOb6CdpHrHFH3LFjB\/OEkReCSEJdRaXIOvIIUL\/Tp0+Djq6INFCj44gLFy7A09Oz6iiqcVfDZ+MI6B4BThZ0j7Hez8DJgva3iNzMy1YdQ9DvP+JpcTxOehrhl\/ZGMFKRJkJFo\/+nJkj3w23pUJg5+9eYFaFUylGSm4iJ6afxesFlGNch9FTf1UiNhFhrE4IdDsEYPaY7Zk3sDpHofnBffcczhOtJXImOi+hBr47s85QpU+Do6MiKSW3btg2bNm1i8TZ0ZLdy5UpW0prqR1CGQ2X8z+NwoJiFtPR0UJwLbxwBQ0GAkwVD2Skd2snJgm7AzcwtxjOzV2JX8nZITOV4ebAAympqSUQWwjNV+O854Ki5NzbZBiPH1hslFo6QC00hVJTDqiwPLQqTML4gGgNLk7RmaKmRCHdM7HHB0Q9XQ7ogvFsIJgwObbKeBE2BI8+Bm5sbPDw8WJDupUuXWGAjkQ6KYTh16hQWLVrEpKRJs6G2RgG2VCqb4mB44wgYCgKcLBjKTunQTk4WdAMueRc+\/+UwTA59B5lzOi67AopqZIGIwhsXVbCUVcxPBZfuiWyQKzSD1EjEakE4KCXwlhXDVinVipGlAhEjJvusWsJnQHd07BWKdgEt4GhnoZXxm9sg6enp7Dji3Llz+Oyzz1gW0bBhw2qFgVJIKXvozTffbG5w8fUaMAKcLBjw5mnLdE4WtIXk\/XFk8nJcijuD1Xv\/hzxxRSqnQFVR00FlBDiWAW+dVyIwv1ofipDXgfIhzSk3EuCAZUuscumIdn06YN6MPrCx4tUTNd15Elfq168foqKisHTpUowbN67OLIkD+\/ezI4s3587VdHrenyPQaAhwstBoUOvvRJwsaGdvqLBVas49xCZfwZErO3E37SboZyqFBcKyyjEgWYabTsARbyO8fEWJHvczPJGvVKJ3Ziauu7lpxxgAEiMhbtNRg5Un7rbtAo9ObTG0ZxB8PR20NgcfCKzcNaVdXrx4ESTqVFew5LGjR3H7zh28+OKLHD6OgMEgwMmCwWyV7gzlZEFzbJOz43Hk8j+4cOcksgrSoVQqYG1ui74dRsKoPAhFP\/2NOakXEG9nhFwzFTpl3A90pNmJLHTPyMBNd3eNjVHBCFFmLbDdNgjmEWHo\/1Q3BPu5wMXBUq1gPo0NaGYDUFEo0gAhvRJXV9c6V0+CTFKplFedrBMpfoE+IcDJgj7txhOyhZOFhgEvlUmQV5yFXVEbcfTqTtDRg0gogpW5LbqFDMSY7tNhb+0McakU\/1m8Bd8f+Q6mKkWNk2lKFqgoVbHABLFmTljv0QnK4DaY80x3tPGv++HVsNXzXhwBjkBzQoCThea0249ZKycL9bsJyuVSXLx9EudvncD52ycgKS+FkZEAwd4dEO7fHV2DB8DV\/r4qo0oFrPvnIvK\/\/xFz8y9rnSzcMrHHSXMPpAaHwaFbR\/Tt1ArtAiukp3njCHAEOALaQICTBW2gaOBjcLKg3gYSSTgdcwA7I39HdmEmpOVl7CwhwKMtJvSejVbuwbA0tYKgBjVGcVk5Jk1eho3pe2CjLH9kwhKlEu8WFuJbe3v1jCHpamM7\/GLbFnkBIZgwqTfC2nrBztocImHT1khQGyA9vZAko+kowtvbW08t5GZxBB5FgJMFfldU1TwgKKhc7\/VqxZw0hSe3LBdfn\/saTmZOiHCPQE+vihoMhtIo9iCnKBNX46Nw8NJfSMi4xUy3sbCHn1trDI4Yi4jAnhAY1S3XvP6vczD+9htMLq4YoyEtT2iGO8Z2OODZAdnBYXh6aHv07+LfkKF4nyeEwMGDB3E2KgoL33\/\/CVnAp+UI1B8BThbqj1mT66Erz4IKKvxx7Q84Wzgj0CkQv1\/9HfN7zoexsKJolT43ymJISI\/FqegDuJZwDinZd1lmg5OtK7qHDEKYf3fmUTA1NlN7GWlZRVg190u8FXcAlsp\/xRXU7J0issIhC2\/EebWGe\/\/u6BThz+IRLMz0H0s1l9hsLjt08CCizp7FwoULm82a+UINHwFOFgx\/DzVega7IAj1cPz75MUZ6j4Sbsxs+PfEplg1aBlORfuf3F5XkY9W+\/zGdBKmsjFUIFAqEGN9rFvp3GAU7aycIjOrv6lcolFjx23GM+3kxPORitfaNRJRW2obijFcoJk\/siZH92sDUWASBoJq6k1oj8Yv0BQFOFvRlJ7gd9UGAk4X6oNVEr9UVWaCH7FeRX6Gne094OnpixbkVWNR3EUyE+lecqLi0APHpN3Hi2l6cuXEQCqUCJsZm8HL2Q8fAXhgUPga2lprrExw5G4+jn\/+C95OPMoXGylaiUuHTwkJ8ZGeHQoEpYk0ccNYlELFtu6Bfj9YY0iMQNlbqezGa6K3aJJZ16NAhnDx5EosXL24S6+GLaB4IcLLQPPa51lXqiizQpJEpkTiRdAIDfQfiWsY1zOgwo0Fv5braprLyEnbUcCp6P5Ky4iAuK2L2tW3ZEYMixsDfvQ0cbV1hVFX+STNLZDIFvll\/EsKNG\/Bi4fWq4whKneycmYVPAnvjrFMA\/AZ2Q0S3EAS3coWNpX57YjRDpPn1jouLQ0JCAgYNGtT8Fs9XbLAIcLJgsFunPcN1SRbIyrNpZ3En5w4mtZ0EY4ExCiQFWHh0IVacXYEunl1gbWqNqOQoDPIfhFVPrYK9ufoZAQ1BgTweRBJORu\/HjtO\/Ibswgw1jLDJBkGc7PDvwTRa8qKtG83+\/IRIXth\/C0wWxsFVIcVlkg2\/unMAbi9fgpQldYM0Jgq7g5+NyBDgCDUCAk4UGgNbUuuiaLNSEV1R8FLqt7wY\/Bz9snbgV4nIxRm0YhQF+A7BlwhadKA3KFTIkZsWxzIaT0fuYNDM1Z1s35kno1W4oAj3bwaQRYioUShXuJObg0o1USKQymBsrsOTtmbgZG9vUbi++Ho4AR6AJIMDJQhPYRE2X8CTJwuCAwdgwdgNkChlG\/TkKMVkxSJmbAnsL7XoX7mXexs7IDYhJvMhUF+nt3t7KGYPCn0b3NoOYiJLoCWZp5Ofno3u3bpwsaHoz8\/4cAY6AThDgZEEnsBrWoE+SLAwNGIo\/xv3BAgrHbBqDcynnkPCfBHhY3VdAbCiapRIx0vOS8PeZdYi6eYQNQ14DBxtn9Go7DKO6TYWZiX6UZlYqlUhNTYWXl1dDl8v7GQgCFy5cQGRkJF5\/\/XUDsZibyREAOFngd4FORZkeB2\/lMUQlWSDPwug\/RyM2Oxapc1NhaWbZ4J0pLivE+VvHcfbmUdxKuYYSSTFLfWzfqis6B\/VBRGAv2Fk6Nnh83pEjoAkCRw4fxv79+\/H5smWaDMP7cgQaFQFOFhoVbv2c7El6Fjp6dMTfk\/9GWXkZeq3thaltp+LzQZ9jd\/xufHn6SxyfeVxt0EqlYhy9shO7zm5EYUkeK+wkFIjQ3q8LpvR\/lR01mBmb6yQeQm0j+YXNHoEjR45gz+7d+OLLL5s9FhwAw0GAkwXD2SudWfokyUI\/v354vcvruJZ2DSqBCu\/0eAfmInMUlRch6NsgpP83vdZ1EyHILEjFlfgo7Du\/GZn5qayok4O1E1p7tceg8LEI8QnXe4Igl8sRHR2NDh06VK2XjmaOJR1DtjgbvX16w91a8\/LVOruJ+MBqI0Bk4Z9\/\/sHXX3+tdh9+IUfgSSPAycKT3gE9mP9JkoXKYwgHswcFj+oiC6QOGX3vAs7FHmNEITM\/BVTVydOpJXq2HYJQvy5o5da6xqJOegD5IyYU5OejX79+uHzlStXvTiWewvnM8xjpPxJH7x3Fi+Ev6qPp3KZ6InDmzBl2DMFFmeoJHL\/8iSLAycIThV8\/Jn+SZIE8C5vGb2L1I6q32shCUlY81uz\/EjeTLrPASGoUqDi1\/xz0aT8CZibmWhNRaqwdejgbgupqfHz8YwzxHYJA50DMPzgfK0etbCxz+Dw6RIAycehLIKi\/ZLgOzeJDcwRqRYCTBX6DNHqAY4msBBujN+JI\/BFYmlhiWMAwjA0e+8BOFEoLEfRdENLnpcPICCgQ5yEm8RIrEX3xzilQNUhzU0u0cgtGl9b90K\/9SJiamBvsbtZIFk58jFE+o+Dp4olFRxfh2+HfGuz6uOEcAY6AYSPAyYJh759WrH8SnoXaDKe3rlPJp7Dm8hpMDZmCwoxknL99Eik5dyEpL4OxyBSdgnqzok4tXQO0UrNBK0BqMEhNOguH4w8jtSQV3b2642jCUcwOn63BDLwrR4AjwBFoOAKcLDQcuybTU9\/IAh0tULrjvvObcOjSDuSLc1iAImUyhPp1xqS+L7MCT02plZaW4rPPPsOSJUuqlkVxGXMPzIWblRtGBY5CG+c27HcKlQKl5aWgoworEytWy6KkvIS5tSk4lDf9RiAnJwdpaWkIDQ3Vb0O5dRyBaghwssBvh0Y\/hngc5FKZBHFpN3Dx9kkmopRdmM4CFD0cfRDm3wNdg\/vBzy2YaSY055ZTloNN0Zuw4foGbJ2wFS2sWmDR8UUokhVh+aDlzRkag1j7sWPHsHHjRvz0008GYS83kiNACHCywO+DJ04W6NiBxJO2n1yN+PRYULloemt2sm2BMT1mIMy\/OxytXXlAWLV7lYpxTd42Gd8P+x7+Dv5IzEvEoeRDmNV+Fr+j9RyB48eOYd369Vi1apWeW8rN4wjcR4CTBX43PBGyQAShuKwA8Wmx+Ov0WpbZQM3cxAItHLwwIOxpDAwfzUSVmkMjPIqKimBra6vWcsvkZZizZw7e6f4OK8a1+vJqzGg\/A2YiM7X684ueHAKcLDw57PnMDUeAk4WGY9dkejZ2zEJ2QTqiYo\/iwq3jzJMglZWxdMewVt3RLWQA2vhEwMZSu4Wk9H2zxMXFeHPuXLXfNkke+53972B6u+mws7RDVlkWOnl0MriUUX3fF13Yx8mCLlDlY+oaAU4WdI2wAYzfWGShQJyLfRe24ODFv1gAo0Iph7HIBN1DBmFC7xdgb+3UKOWh9XFL6lt1koIfPzj8AXp59cKVnCuY120eRAIRtsVuw42cG3i\/5\/v6uExuE4D09HTcuHEDAwYM4HhwBAwGAU4WDGardGeoLsmCpLwUKTn3mDbCwYvbWc0GOlpwsXNDa+8OGNZpIlq6Buq9HLPu0K8Yub5kgY4tlp5YioySDHw35DsIhRVBn8nFydhxZwdeC39N1ybz8TkCHIFmhAAnC81osx+3VF2QBfIaXLx9CpE3DyPm3gXki3OZi7xli0D0Dh3OijuRNDPVceCt\/mRBppRhd9xudHHvwlIrKxsnC\/xu4ghwBHSBACcLukDVwMbUJlmgN96YxItMjplkmakRSXCwdcXUfq+yug2kmcDbgwiQZ6Fnjx6IuXGjVmgoS4T+O5p0FN423vC393\/gek4WDOPOor8T\/ndgGHvFraxAgJMFfidonA1BD7CsgjRcu3sOp6MPsMwGOlO3MrNBsE8HJsdMcQkUn8BbzQgolUpkZmbCze2+l6CmK9deXYv4\/HhMbjO5SqSp+nX3Cu9hS+wWvN3lbQ61niJw8eJFbNq0CcuWLdNTC7lZHIFHEeBkgd8VGpGF9LxkVhr6esJ5ZOSngEpGW5haoVe7oejVbhg7arA0s+YoawmBIkkRjARGsDapGdOo1CjsvbMXk9tNRrBjsJZm5cNoE4ETJ05gxYoVjDDwxhEwFAQ4WTCUndKhnfU9hiBCQIGKO6M24Pi13SyzgZQWLU2t0CW4P0Z1mwo3B28dWsyH5ggYLgKcLBju3jVnyzlZaM67\/+\/a1SULpVIxbiZdwbnYYzh\/+wRTWiTpZd8WQegU1AedAnvDy6UVR7QBCEilUmzfvh1TpkxpQG\/exZAQOHnyJL755hts3brVkMzmtjZzBDhZaOY3AC2\/LrJA8QfnY49hZ9QfSM5JQKlEzFDzcfXHuJ6zEOzdAbaW9jyzQYN7qSA\/H71798a169c1GIV3NQQEzp07h59+\/BGrVq82BHO5jRwBhnrLd7QAAA6uSURBVAAnC834RsjNzUVCQgLGjBmDgoIChoSfnx9+\/fVX+LXyg5GxAjH3LmFH5HokZt5hv7cyt4W3Syumj0DehOZe1EmT24ci4uPj4+Hp6YmysjJ079YNN2NjNRmS9+UIcAQ4AjpBgJMFncCq34MqFAocPHgQX3\/9Nc6cOYPi4uIHDPbwc8XEl4bDzEmFhIzbkCtksLGwR5fWfdG5dT\/4e4SwTAfeNEOgvLwcnTp1Qr9+\/TB0yBD85z\/\/4WRBM0h5b44AR0BHCHCyoCNg9XVYepv97bff8MYbbzxCEipt9gp1RMTolhAZC5j88qCIMRjV9VnYWtk3m8JOjbF\/RBbIq0DxCmZmZrCxtsbBQ4fQsmXLxpiez8ER4AhwBNRGgJMFtaFqGheSJv3YsWNx69atxy7IxEKEjmN8Ic6RQJltiX3\/HIKHh0fTAECPVlFJFiQSCbPK2NgY1tbWmDp1KsaPH4\/WrVvD3NxcjyzmpmgDgbS0NERFRmLsuHHaGI6PwRFoFAQ4WWgUmPVnkg8++ABLly6t0yBTCxHKy+RQqYBevXrBx8enzj78gvohQEJMe\/bsAR0LPdzc3d3Z8cSLL76IsLCw+g3Mr9ZrBE6fOoWPP\/4Ye\/bu1Ws7uXEcgeoIcLLQzO6HgIAAxMXF1WvVJEtrZWVVrz78Yu0hQOmUCxcuhLOzM5MIFggEzAtR2eRyOYh4VG8mJvfVMunoia6pbDQGfVUWn6KfU3+6rrJV\/x39vPrv6JrKMbS3yuYzEicLzWevm9JKOVloSrupxlpsbW1RVFSkxpUPXkLucd6eDAIB\/v5wcHSEibExe0iHhYc\/4B1auXIlDhw4AMG\/NTfoQb95y5YqY5OSkvDO\/\/1fxQNeIGD\/hoSEYMGCBewaOg5Zs2YNrl69ysag+Ikvvvyyqv+F8+exe\/duiEQiRlQEQiHat2+PoUOHsmtKS0uxf\/9+5OTkQCQUQigSwcHBASNGjKiqf0DpgqkpKVVkh2wMat0a\/v4VtS3oKCbyzBlmH81BNpJ3hbJzKmso0BEaxXcIBRXFx2geX19fWFhYsO+JEKWkpFT1p352dnYPEN3CwsKKvv9W6aS5Kvs31u6ePn0aH37wAQ4dPtxYU\/J5OAIaI8DJgsYQGtYAnTt3xvnz5+tlNH2gWlpa1qsPv1hzBKhOxMsvv8weuhS7QG\/35AGgh3mLFi2qJsjOzmYlrpl3gbwAAIKD70s904P4Vmws+3mlB4E8RUFBQWwM+hnFsNCDlv6fHv6UTlvZYmNj2YO8XCZjRyb0RQ9xsouaWCzG77\/\/zsiATCZjX27u7njrrbfYg5va6lWrQA9JGl+hVLJ\/J0+ejJEjR7Lfk\/0vzJoFiVQKpUIBpUqF4cOH47XXXqt6sE+cOBH37t1jv6dGY\/\/4008IDw9n3xNZeXr06Ae8Hm+8+SaL\/6hsUyZPBqUMV3pG6N\/de\/ZU2ZmRkYEXZ8+GsYlJFTn7v3feQYcOHdgQRKyWLFkCcXExyHtT6eFZsnRplZ03b97Egf372RwmpqaMZBGxomBWapwsaP63wUdofAQ4WWh8zJ\/ojD\/88ANef\/31R9zWjzOKPpA\/\/PBDUKwDb9pF4OEARxqdHiz0Vv70009j3rx5dRaW0q5FhjUakSB6WFc\/MklMTGQeBiIj9OXi4gJ7e\/uqhUVGRqKkpASy8nJGvmRyOUaNGlXlvSgsKGDKikSMyItBjR70FGxKjYjQl19+yciNVCJh31P75ttv2d5R+3\/t3c+rj3kUB\/DPzsIOhaWfG2VryErYKWVhImyUpPwoCyULJT92MwsrFigp5ccKZYEoWQh170qxYIGFlH9gOp\/pFprM7WTmPs89r6esxrn3Oa9zM+\/7fD\/P5\/Po0aP25x9\/9K8f9xjhKgLGb2vX9v8+OTHRJiYm2vbffx8XuLstLSAsFBv\/u3fv2vbt21v8o\/lvV\/xmtG7dunb37t2+St\/1awV+DAvx23q8qbJt27a2atWqX\/vNfLXBCEyt\/3BE9WBG4kamISAsTANpNv2V+IcqPoaIx8zxCtfPrpUrV7YrV660NWvWzCaCwfQyFRbiM\/MDBw603bt396cK3y5eHMzNuhECBEoLCAtFx\/\/58+f+mDsOtfn06VPfbjiu+Gx84cKFbf369f31rlhk5vpvBOJx+YkTJ9q+ffv+cSOmWIwXi1Fjj4upz\/7\/mzvxVQkQIPBzAWGh8E9IfN4ar1HG4rapVeKxejyeKMSfbz8LLsw0I63HU4fz58+3e\/futUOHDvXFfi4CBAjMlICwMFPyvi+BnwjEAVPxcVG8cXDq1Kl2\/Pjx704HhUeAAIH\/U0BY+D+1fS8C0xSI1xfjFcn4+CGe+sRHFvPnz59mtb9GgACBXysgLPxaT1+NAAECBAjMOgFhYdaNVENjFoi9AWJHxqtXr\/ZXKA8fPtzf0Y8Nh2INg2scArFHQ\/yJjZviCVE8GYqnRbEZlsWq45ihu\/xeQFjwE0FggAL3799vZ8+ebfv372\/x5sqCBQv6Hgyu4QtEMHjy5Em7ePFif5vo5MmT7dKlSy02RLt9+3ZbtmzZ8JtwhwR+EBAW\/EgQGKDAx48f244dO9rp06ftczHA+UznluIto3gtNp4Qxcmt8ZQhgsKcOXOmU+7vEBiUgLAwqHG4GQJ\/C3z9+rUfTx1bc8cumq7xCXz58qVt3ry5z3DXrl3ja8AdE\/hGQFjw40BggAIPHjzo6xbit9Bz58718wViy+3nz5\/3cwpsvz3Aof1wS7FGIZ4Oxfbqccy4i8CYBYSFMU\/Pvc8qgQgEcUhRnN8RCxvjtMe9e\/f2tQtxcmLs9hgnNT579qz\/tuoatkDslRHHgMeCxmvXrg37Zt0dgX8REBb8iBAYkMDk5GQ\/GyJ20IwdNmNBXBzjHCclxhkdr1+\/7rs53rp1q2\/N7RqewIsXL\/rbDzdu3OjHZx85cqS9fPmyH28dCx5jPUq82RLbeMesN2zY0JYsWTK8RtwRAR9D+BkgMC6BV69e9acM8VQh3oqY+p\/NuLqocbexTmHFihV95804c2Xjxo1tz549\/aCwxYsX9xAYB4edOXOmPXz4sL19+7YdPXq0Bo4uRyvgycJoR+fGKwm8efOmbd26tf+GumXLlnb9+vU2d+7cSgSj6TVOdv32+Okfj6R+\/\/59u3nzZjt48GC7cOFCi1NHd+7cOZr+3GhNAWGh5tx1PTKBeKwdC+XikfadO3f6K5WucQrE04RYwLp69eq+cDXO\/xD8xjnLSnctLFSatl5HLRCbM3348KEtWrSozZs3b9S9VL75y5cv97ULmzZtqsyg95EJCAsjG5jbJUBgvAKxUDWeDh07dqwtXbp0vI2483ICwkK5kWuYAIGZEIhzPx4\/ftyePn3aX4Vdvnz5TNyG70kgJSAspNgUESBAgACBOgLCQp1Z65QAAQIECKQEhIUUmyICBAgQIFBHQFioM2udEiBAgACBlICwkGJTRIAAAQIE6ggIC3VmrVMCBAgQIJASEBZSbIoIECBAgEAdAWGhzqx1SoAAAQIEUgLCQopNEQECBAgQqCMgLNSZtU4JECBAgEBKQFhIsSkiQIAAAQJ1BISFOrPWKQECBAgQSAkICyk2RQQIECBAoI6AsFBn1jolQIAAAQIpAWEhxaaIAAECBAjUERAW6sxapwQIECBAICUgLKTYFBEgQIAAgToCwkKdWeuUAAECBAikBISFFJsiAgQIECBQR0BYqDNrnRIgQIAAgZSAsJBiU0SAAAECBOoICAt1Zq1TAgQIECCQEhAWUmyKCBAgQIBAHQFhoc6sdUqAAAECBFICwkKKTREBAgQIEKgjICzUmbVOCRAgQIBASkBYSLEpIkCAAAECdQSEhTqz1ikBAgQIEEgJCAspNkUECBAgQKCOgLBQZ9Y6JUCAAAECKQFhIcWmiAABAgQI1BEQFurMWqcECBAgQCAlICyk2BQRIECAAIE6AsJCnVnrlAABAgQIpASEhRSbIgIECBAgUEdAWKgza50SIECAAIGUgLCQYlNEgAABAgTqCAgLdWatUwIECBAgkBIQFlJsiggQIECAQB0BYaHOrHVKgAABAgRSAsJCik0RAQIECBCoIyAs1Jm1TgkQIECAQEpAWEixKSJAgAABAnUEhIU6s9YpAQIECBBICQgLKTZFBAgQIECgjoCwUGfWOiVAgAABAikBYSHFpogAAQIECNQREBbqzFqnBAgQIEAgJSAspNgUESBAgACBOgLCQp1Z65QAAQIECKQEhIUUmyICBAgQIFBHQFioM2udEiBAgACBlICwkGJTRIAAAQIE6ggIC3VmrVMCBAgQIJASEBZSbIoIECBAgEAdAWGhzqx1SoAAAQIEUgLCQopNEQECBAgQqCMgLNSZtU4JECBAgEBKQFhIsSkiQIAAAQJ1BISFOrPWKQECBAgQSAkICyk2RQQIECBAoI6AsFBn1jolQIAAAQIpAWEhxaaIAAECBAjUERAW6sxapwQIECBAICUgLKTYFBEgQIAAgToCwkKdWeuUAAECBAikBISFFJsiAgQIECBQR0BYqDNrnRIgQIAAgZSAsJBiU0SAAAECBOoICAt1Zq1TAgQIECCQEhAWUmyKCBAgQIBAHQFhoc6sdUqAAAECBFICwkKKTREBAgQIEKgjICzUmbVOCRAgQIBASkBYSLEpIkCAAAECdQSEhTqz1ikBAgQIEEgJCAspNkUECBAgQKCOgLBQZ9Y6JUCAAAECKQFhIcWmiAABAgQI1BEQFurMWqcECBAgQCAlICyk2BQRIECAAIE6AsJCnVnrlAABAgQIpASEhRSbIgIECBAgUEdAWKgza50SIECAAIGUgLCQYlNEgAABAgTqCAgLdWatUwIECBAgkBIQFlJsiggQIECAQB0BYaHOrHVKgAABAgRSAsJCik0RAQIECBCoIyAs1Jm1TgkQIECAQEpAWEixKSJAgAABAnUEhIU6s9YpAQIECBBICQgLKTZFBAgQIECgjoCwUGfWOiVAgAABAikBYSHFpogAAQIECNQR+Au14mR6nSF2OAAAAABJRU5ErkJggg==","height":340,"width":419}}
%---
%[output:8137a9f6]
%   data: {"dataType":"text","outputData":{"text":"Especificaciones técnicas:\n","truncated":false}}
%---
%[output:706a1cdd]
%   data: {"dataType":"text","outputData":{"text":"- Arquitectura: SCARA (Selective Compliance Assembly Robot Arm)\n","truncated":false}}
%---
%[output:2f804e88]
%   data: {"dataType":"text","outputData":{"text":"- Grados de libertad: 3 (rotacionales)\n","truncated":false}}
%---
%[output:58ed7a24]
%   data: {"dataType":"text","outputData":{"text":"- Espacio de trabajo: Planar con capacidad de posicionamiento preciso\n","truncated":false}}
%---
%[output:0d0d1a6b]
%   data: {"dataType":"text","outputData":{"text":"- Aplicaciones típicas: Ensamble, pick-and-place, manufactura\n\n","truncated":false}}
%---
%[output:5e800dbb]
%   data: {"dataType":"text","outputData":{"text":"2. DEFINICIÓN DE VARIABLES SIMBÓLICAS\n","truncated":false}}
%---
%[output:1d802c11]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------------\n","truncated":false}}
%---
%[output:3a55e149]
%   data: {"dataType":"text","outputData":{"text":"El abordaje metodológico inicia con la formalización matemática del sistema mediante la definición de variables simbólicas que representan los parámetros físicos y estados del robot.\n\n","truncated":false}}
%---
%[output:51fbac8d]
%   data: {"dataType":"text","outputData":{"text":"VARIABLES ARTICULARES:\n","truncated":false}}
%---
%[output:7100f863]
%   data: {"dataType":"text","outputData":{"text":"Estas variables definen la configuración instantánea del manipulador:\n\n","truncated":false}}
%---
%[output:78ddfe97]
%   data: {"dataType":"text","outputData":{"text":"- theta_0_1: Desplazamiento angular de la articulación base\n","truncated":false}}
%---
%[output:4efebeb5]
%   data: {"dataType":"text","outputData":{"text":"- theta_1_2: Desplazamiento angular de la articulación intermedia\n","truncated":false}}
%---
%[output:6b45c8f3]
%   data: {"dataType":"text","outputData":{"text":"- theta_2_3: Desplazamiento angular de la articulación final\n\n","truncated":false}}
%---
%[output:9d74dddb]
%   data: {"dataType":"text","outputData":{"text":"VELOCIDADES ARTICULARES:\n","truncated":false}}
%---
%[output:5c709183]
%   data: {"dataType":"text","outputData":{"text":"Representan las derivadas temporales de las variables articulares:\n\n","truncated":false}}
%---
%[output:8afd4a43]
%   data: {"dataType":"text","outputData":{"text":"- theta_dot_0_1: Velocidad angular de la articulación base\n","truncated":false}}
%---
%[output:93092038]
%   data: {"dataType":"text","outputData":{"text":"- theta_dot_1_2: Velocidad angular de la articulación intermedia\n","truncated":false}}
%---
%[output:24b39efb]
%   data: {"dataType":"text","outputData":{"text":"- theta_dot_2_3: Velocidad angular de la articulación final\n\n","truncated":false}}
%---
%[output:81ba4085]
%   data: {"dataType":"text","outputData":{"text":"ACELERACIONES ARTICULARES:\n","truncated":false}}
%---
%[output:69aefb0a]
%   data: {"dataType":"text","outputData":{"text":"Corresponden a las segundas derivadas temporales:\n\n","truncated":false}}
%---
%[output:9e1a6b7b]
%   data: {"dataType":"text","outputData":{"text":"- theta_ddot_0_1: Aceleración angular de la articulación base\n","truncated":false}}
%---
%[output:5cb492fb]
%   data: {"dataType":"text","outputData":{"text":"- theta_ddot_1_2: Aceleración angular de la articulación intermedia\n","truncated":false}}
%---
%[output:7acc9b90]
%   data: {"dataType":"text","outputData":{"text":"- theta_ddot_2_3: Aceleración angular de la articulación final\n\n","truncated":false}}
%---
%[output:278fb1ae]
%   data: {"dataType":"text","outputData":{"text":"PARÁMETROS GEOMÉTRICOS:\n","truncated":false}}
%---
%[output:20268398]
%   data: {"dataType":"text","outputData":{"text":"Definen la estructura física del manipulador:\n\n","truncated":false}}
%---
%[output:986578fd]
%   data: {"dataType":"text","outputData":{"text":"- L_1 = 0.3 m: Longitud del eslabón proximal\n","truncated":false}}
%---
%[output:44ff4fc9]
%   data: {"dataType":"text","outputData":{"text":"- L_2 = 0.25 m: Longitud del eslabón intermedio\n","truncated":false}}
%---
%[output:2793fdc4]
%   data: {"dataType":"text","outputData":{"text":"- L_3 = 0.2 m: Longitud del eslabón final\n","truncated":false}}
%---
%[output:513c0173]
%   data: {"dataType":"text","outputData":{"text":"- x_0_1, y_0_1: Coordenadas de localización de la base\n\n","truncated":false}}
%---
%[output:381bae98]
%   data: {"dataType":"text","outputData":{"text":"La selección de estas variables se fundamenta en la necesidad de representar completamente el estado mecánico del sistema para su análisis y subtemas posteriores.\n\n","truncated":false}}
%---
%[output:65dd96f3]
%   data: {"dataType":"text","outputData":{"text":"3. MODELADO CINEMÁTICO DE LA POSTURA\n","truncated":false}}
%---
%[output:485322f6]
%   data: {"dataType":"text","outputData":{"text":"------------------------------------\n","truncated":false}}
%---
%[output:63565244]
%   data: {"dataType":"text","outputData":{"text":"El modelado cinemático establece la relación entre las coordenadas articulares y la \"posición\/orientación\" del extremo final en el espacio cartesiano, sin considerar las fuerzas que generan el movimiento.\n\n","truncated":false}}
%---
%[output:439422e4]
%   data: {"dataType":"text","outputData":{"text":"3.1 TRANSFORMACIONES HOMOGÉNEAS\n","truncated":false}}
%---
%[output:3b06225d]
%   data: {"dataType":"text","outputData":{"text":"-------------------------------\n","truncated":false}}
%---
%[output:26067e16]
%   data: {"dataType":"text","outputData":{"text":"Las transformaciones homogéneas permiten describir sistemáticamente la relación espacial entre sistemas de referencia consecutivos:\n\n","truncated":false}}
%---
%[output:7d1cc09a]
%   data: {"dataType":"text","outputData":{"text":"Cadena cinemática completa:\n","truncated":false}}
%---
%[output:847abd57]
%   data: {"dataType":"text","outputData":{"text":"     T_0_1        T_1_2        T_2_3        T_3_P\n","truncated":false}}
%---
%[output:09989f76]
%   data: {"dataType":"text","outputData":{"text":"S₀ ────────> S₁ ────────> S₂ ────────> S₃ ────────> P\n","truncated":false}}
%---
%[output:5f919318]
%   data: {"dataType":"text","outputData":{"text":"   [x₀,y₀]       [θ₁]         [θ₂]         [θ₃]  [x,y,φ]\n\n","truncated":false}}
%---
%[output:86211119]
%   data: {"dataType":"text","outputData":{"text":"a) Transformación T_0_1 - Sistema base a primera articulación:\n","truncated":false}}
%---
%[output:0493b94a]
%   data: {"dataType":"text","outputData":{"text":"Establece la relación entre el sistema de referencia base y la primera articulación.\n","truncated":false}}
%---
%[output:308e356d]
%   data: {"dataType":"text","outputData":{"text":"T_0_1 = \n","truncated":false}}
%---
%[output:2b85308b]
%   data: {"dataType":"symbolic","outputData":{"name":"","value":"\\left(\\begin{array}{cccc}\n\\cos \\left(\\theta_{0,1} \\right) & -\\sin \\left(\\theta_{0,1} \\right) & 0 & x_{0,1} \\\\\n\\sin \\left(\\theta_{0,1} \\right) & \\cos \\left(\\theta_{0,1} \\right) & 0 & y_{0,1} \\\\\n0 & 0 & 1 & 0\\\\\n0 & 0 & 0 & 1\n\\end{array}\\right)"}}
%---
%[output:12fbc851]
%   data: {"dataType":"text","outputData":{"text":"Análisis de la transformación:\n","truncated":false}}
%---
%[output:232f39aa]
%   data: {"dataType":"text","outputData":{"text":"- Submatriz de rotación: Define la orientación relativa\n","truncated":false}}
%---
%[output:29078b00]
%   data: {"dataType":"text","outputData":{"text":"- Vector de traslación: Especifica la posición relativa\n","truncated":false}}
%---
%[output:75a193fc]
%   data: {"dataType":"text","outputData":{"text":"- Configuración planar: Conserva la coordenada Z constante\n\n","truncated":false}}
%---
%[output:192a4227]
%   data: {"dataType":"text","outputData":{"text":"b) Transformación T_1_2 - Primera a segunda articulación:\n","truncated":false}}
%---
%[output:92228512]
%   data: {"dataType":"text","outputData":{"text":"T_1_2 = \n","truncated":false}}
%---
%[output:29241f6c]
%   data: {"dataType":"symbolic","outputData":{"name":"","value":"\\left(\\begin{array}{cccc}\n\\cos \\left(\\theta_{1,2} \\right) & -\\sin \\left(\\theta_{1,2} \\right) & 0 & L_1 \\\\\n\\sin \\left(\\theta_{1,2} \\right) & \\cos \\left(\\theta_{1,2} \\right) & 0 & 0\\\\\n0 & 0 & 1 & 0\\\\\n0 & 0 & 0 & 1\n\\end{array}\\right)"}}
%---
%[output:941c34d8]
%   data: {"dataType":"text","outputData":{"text":"c) Transformación T_2_3 - Segunda a tercera articulación:\n","truncated":false}}
%---
%[output:61bf1a57]
%   data: {"dataType":"text","outputData":{"text":"T_2_3 = \n","truncated":false}}
%---
%[output:2243cbaf]
%   data: {"dataType":"symbolic","outputData":{"name":"","value":"\\left(\\begin{array}{cccc}\n\\cos \\left(\\theta_{2,3} \\right) & -\\sin \\left(\\theta_{2,3} \\right) & 0 & L_2 \\\\\n\\sin \\left(\\theta_{2,3} \\right) & \\cos \\left(\\theta_{2,3} \\right) & 0 & 0\\\\\n0 & 0 & 1 & 0\\\\\n0 & 0 & 0 & 1\n\\end{array}\\right)"}}
%---
%[output:078a1458]
%   data: {"dataType":"text","outputData":{"text":"d) Transformación T_3_P - Tercera articulación al extremo final:\n","truncated":false}}
%---
%[output:80a0eeb0]
%   data: {"dataType":"text","outputData":{"text":"T_3_P = \n","truncated":false}}
%---
%[output:0ef984bc]
%   data: {"dataType":"symbolic","outputData":{"name":"","value":"\\left(\\begin{array}{cccc}\n1 & 0 & 0 & L_3 \\\\\n0 & 1 & 0 & 0\\\\\n0 & 0 & 1 & 0\\\\\n0 & 0 & 0 & 1\n\\end{array}\\right)"}}
%---
%[output:16d24b04]
%   data: {"dataType":"text","outputData":{"text":"Características de las transformaciones:\n","truncated":false}}
%---
%[output:31712242]
%   data: {"dataType":"text","outputData":{"text":"- Consistencia con la convención Denavit-Hartenberg\n","truncated":false}}
%---
%[output:6ee68871]
%   data: {"dataType":"text","outputData":{"text":"- Preservación de la ortogonalidad de los sistemas de referencia\n","truncated":false}}
%---
%[output:7504bc1c]
%   data: {"dataType":"text","outputData":{"text":"- Composición multiplicativa para transformaciones consecutivas\n\n","truncated":false}}
%---
%[output:8ff41c32]
%   data: {"dataType":"text","outputData":{"text":"3.2 CINEMÁTICA DIRECTA\n","truncated":false}}
%---
%[output:2e210035]
%   data: {"dataType":"text","outputData":{"text":"----------------------\n","truncated":false}}
%---
%[output:49716e0c]
%   data: {"dataType":"text","outputData":{"text":"La cinemática directa determina la posición y orientación del extremo final a partir de los valores conocidos de las variables articulares.\n\n","truncated":false}}
%---
%[output:3977b38b]
%   data: {"dataType":"text","outputData":{"text":"Transformación homogénea total T_0_P =\n","truncated":false}}
%---
%[output:5df3479a]
%   data: {"dataType":"symbolic","outputData":{"name":"","value":"\\begin{array}{l}\n\\left(\\begin{array}{cccc}\n\\sigma_2  & -\\sigma_1  & 0 & x_{0,1} +L_2 \\,\\cos \\left(\\theta_{0,1} +\\theta_{1,2} \\right)+L_1 \\,\\cos \\left(\\theta_{0,1} \\right)+L_3 \\,\\sigma_2 \\\\\n\\sigma_1  & \\sigma_2  & 0 & y_{0,1} +L_2 \\,\\sin \\left(\\theta_{0,1} +\\theta_{1,2} \\right)+L_1 \\,\\sin \\left(\\theta_{0,1} \\right)+L_3 \\,\\sigma_1 \\\\\n0 & 0 & 1 & 0\\\\\n0 & 0 & 0 & 1\n\\end{array}\\right)\\\\\n\\mathrm{}\\\\\n\\textrm{where}\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_1 =\\sin \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_2 =\\cos \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\n\\end{array}"}}
%---
%[output:1126bc0d]
%   data: {"dataType":"text","outputData":{"text":"Parámetros de salida del extremo final:\n","truncated":false}}
%---
%[output:9a4bc243]
%   data: {"dataType":"text","outputData":{"text":"- Coordenada X: x_0_1 + L_2*cos(theta_0_1 + theta_1_2) + L_1*cos(theta_0_1) + L_3*cos(theta_0_1 + theta_1_2 + theta_2_3)\n","truncated":false}}
%---
%[output:728c0eb5]
%   data: {"dataType":"text","outputData":{"text":"- Coordenada Y: y_0_1 + L_2*sin(theta_0_1 + theta_1_2) + L_1*sin(theta_0_1) + L_3*sin(theta_0_1 + theta_1_2 + theta_2_3)\n","truncated":false}}
%---
%[output:56c7bd3e]
%   data: {"dataType":"text","outputData":{"text":"- Orientación φ: theta_0_1 + theta_1_2 + theta_2_3\n","truncated":false}}
%---
%[output:3970b32c]
%   data: {"dataType":"text","outputData":{"text":"- Valor numérico: theta_0_1 + theta_1_2 + theta_2_3\n\n","truncated":false}}
%---
%[output:2335c9bc]
%   data: {"dataType":"text","outputData":{"text":"La cinemática directa proporciona el mapeo completo desde el espacio articular al espacio cartesiano, fundamental para el control de posición.\n\n","truncated":false}}
%---
%[output:646f2379]
%   data: {"dataType":"text","outputData":{"text":"3.3 VECTOR DE POSTURA\n","truncated":false}}
%---
%[output:5ca308d3]
%   data: {"dataType":"text","outputData":{"text":"---------------------\n","truncated":false}}
%---
%[output:450535da]
%   data: {"dataType":"text","outputData":{"text":"El vector de postura sintetiza completamente el estado cinemático del extremo final en el espacio de trabajo.\n\n","truncated":false}}
%---
%[output:0c69e5d0]
%   data: {"dataType":"text","outputData":{"text":"Vector de postura ξ_0_P = [x; y; φ] =\n","truncated":false}}
%---
%[output:333f315c]
%   data: {"dataType":"symbolic","outputData":{"name":"","value":"\\left(\\begin{array}{c}\nx_{0,1} +L_2 \\,\\cos \\left(\\theta_{0,1} +\\theta_{1,2} \\right)+L_1 \\,\\cos \\left(\\theta_{0,1} \\right)+L_3 \\,\\cos \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\\\\\ny_{0,1} +L_2 \\,\\sin \\left(\\theta_{0,1} +\\theta_{1,2} \\right)+L_1 \\,\\sin \\left(\\theta_{0,1} \\right)+L_3 \\,\\sin \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\\\\\n\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \n\\end{array}\\right)"}}
%---
%[output:69845084]
%   data: {"dataType":"text","outputData":{"text":"Componentes del vector de postura:\n","truncated":false}}
%---
%[output:6556c427]
%   data: {"dataType":"text","outputData":{"text":"- x: Posición en el eje X del espacio de trabajo\n","truncated":false}}
%---
%[output:9465d3aa]
%   data: {"dataType":"text","outputData":{"text":"- y: Posición en el eje Y del espacio de trabajo\n","truncated":false}}
%---
%[output:79e133ee]
%   data: {"dataType":"text","outputData":{"text":"- φ: Orientación del extremo final respecto a la base\n\n","truncated":false}}
%---
%[output:6fd28373]
%   data: {"dataType":"text","outputData":{"text":"3.4 CINEMÁTICA INVERSA\n","truncated":false}}
%---
%[output:59cd8b3e]
%   data: {"dataType":"text","outputData":{"text":"----------------------\n","truncated":false}}
%---
%[output:1fb5a8ba]
%   data: {"dataType":"text","outputData":{"text":"La cinemática inversa resuelve el problema de determinar las variables articulares necesarias para alcanzar una postura deseada del extremo.\n\n","truncated":false}}
%---
%[output:9093879a]
%   data: {"dataType":"text","outputData":{"text":"Formulación del problema:\n","truncated":false}}
%---
%[output:3e3e5a57]
%   data: {"dataType":"text","outputData":{"text":"Dada una postura deseada [x_d, y_d, φ_d], determinar θ₁, θ₂, θ₃ tal que:\n\n","truncated":false}}
%---
%[output:339e13b7]
%   data: {"dataType":"text","outputData":{"text":"x_d = x₀ + L₁cos(θ₁) + L₂cos(θ₁+θ₂) + L₃cos(θ₁+θ₂+θ₃)\n","truncated":false}}
%---
%[output:45707522]
%   data: {"dataType":"text","outputData":{"text":"y_d = y₀ + L₁sin(θ₁) + L₂sin(θ₁+θ₂) + L₃sin(θ₁+θ₂+θ₃)\n","truncated":false}}
%---
%[output:2ce15f81]
%   data: {"dataType":"text","outputData":{"text":"φ_d = θ₁ + θ₂ + θ₃\n\n","truncated":false}}
%---
%[output:5d9fca26]
%   data: {"dataType":"text","outputData":{"text":"Consideraciones importantes:\n","truncated":false}}
%---
%[output:5b18f133]
%   data: {"dataType":"text","outputData":{"text":"- Existencia de solución: Depende del alcance del punto\n","truncated":false}}
%---
%[output:9e39e322]
%   data: {"dataType":"text","outputData":{"text":"- Variedad de soluciones: Configuraciones elbow-up\/elbow-down (codo arriba\/codo abajo)\n","truncated":false}}
%---
%[output:096e68dc]
%   data: {"dataType":"text","outputData":{"text":"- Singularidades: Configuraciones donde se pierde movilidad\n\n","truncated":false}}
%---
%[output:80555bf1]
%   data: {"dataType":"text","outputData":{"text":"4. MODELADO CINEMÁTICO DIFERENCIAL\n","truncated":false}}
%---
%[output:1ca7dbd7]
%   data: {"dataType":"text","outputData":{"text":"----------------------------------\n","truncated":false}}
%---
%[output:5096a213]
%   data: {"dataType":"text","outputData":{"text":"El modelado cinemático diferencial establece la relación entre las velocidades articulares y las velocidades del extremo final.\n\n","truncated":false}}
%---
%[output:415922e2]
%   data: {"dataType":"text","outputData":{"text":"4.1 JACOBIANO GEOMÉTRICO\n","truncated":false}}
%---
%[output:6b8f09d7]
%   data: {"dataType":"text","outputData":{"text":"------------------------\n","truncated":false}}
%---
%[output:46c6f2b1]
%   data: {"dataType":"text","outputData":{"text":"El Jacobiano representa la derivada del vector de postura respecto a las variables articulares, constituyendo una herramienta fundamental para el análisis de velocidades y singularidades.\n\n","truncated":false}}
%---
%[output:951d18e9]
%   data: {"dataType":"text","outputData":{"text":"Matriz Jacobiana J(θ) =\n","truncated":false}}
%---
%[output:0f011f71]
%   data: {"dataType":"symbolic","outputData":{"name":"","value":"\\begin{array}{l}\n\\left(\\begin{array}{ccc}\n-L_2 \\,\\sin \\left(\\theta_{0,1} +\\theta_{1,2} \\right)-L_1 \\,\\sin \\left(\\theta_{0,1} \\right)-\\sigma_1  & -L_2 \\,\\sin \\left(\\theta_{0,1} +\\theta_{1,2} \\right)-\\sigma_1  & -\\sigma_1 \\\\\nL_2 \\,\\cos \\left(\\theta_{0,1} +\\theta_{1,2} \\right)+L_1 \\,\\cos \\left(\\theta_{0,1} \\right)+\\sigma_2  & L_2 \\,\\cos \\left(\\theta_{0,1} +\\theta_{1,2} \\right)+\\sigma_2  & \\sigma_2 \\\\\n1 & 1 & 1\n\\end{array}\\right)\\\\\n\\mathrm{}\\\\\n\\textrm{where}\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_1 =L_3 \\,\\sin \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_2 =L_3 \\,\\cos \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\n\\end{array}"}}
%---
%[output:136ce954]
%   data: {"dataType":"text","outputData":{"text":"Interpretación del Jacobiano:\n","truncated":false}}
%---
%[output:4d6703b9]
%   data: {"dataType":"text","outputData":{"text":"- Dimensión 3×3: 3 grados de libertad cartesianos × 3 articulares\n","truncated":false}}
%---
%[output:0ef4dd90]
%   data: {"dataType":"text","outputData":{"text":"- Columnas: Contribución de cada articulación al movimiento del extremo\n","truncated":false}}
%---
%[output:9048a6d8]
%   data: {"dataType":"text","outputData":{"text":"- Rango: Determina los grados de libertad efectivos del manipulador\n\n","truncated":false}}
%---
%[output:9333c707]
%   data: {"dataType":"text","outputData":{"text":"4.2 ANÁLISIS DE VELOCIDADES\n","truncated":false}}
%---
%[output:51e2b558]
%   data: {"dataType":"text","outputData":{"text":"---------------------------\n","truncated":false}}
%---
%[output:88dd8b94]
%   data: {"dataType":"text","outputData":{"text":"Relación fundamental entre espacios de velocidad:\n","truncated":false}}
%---
%[output:83e4c6db]
%   data: {"dataType":"text","outputData":{"text":"v = J(θ) * θ̇\n","truncated":false}}
%---
%[output:71de52df]
%   data: {"dataType":"text","outputData":{"text":"donde v = [ẋ, ẏ, φ̇]ᵀ y θ̇ = [θ̇₁, θ̇₂, θ̇₃]ᵀ\n\n","truncated":false}}
%---
%[output:43f7a106]
%   data: {"dataType":"text","outputData":{"text":"Velocidad cartesiana v =\n","truncated":false}}
%---
%[output:30df08b2]
%   data: {"dataType":"symbolic","outputData":{"name":"","value":"\\begin{array}{l}\n\\left(\\begin{array}{c}\n-{\\dot{\\theta} }_{0,1} \\,{\\left(\\sigma_3 +L_1 \\,\\sin \\left(\\theta_{0,1} \\right)+\\sigma_1 \\right)}-{\\dot{\\theta} }_{1,2} \\,{\\left(\\sigma_3 +\\sigma_1 \\right)}-L_3 \\,{\\dot{\\theta} }_{2,3} \\,\\sin \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\\\\\n{\\dot{\\theta} }_{1,2} \\,{\\left(\\sigma_4 +\\sigma_2 \\right)}+{\\dot{\\theta} }_{0,1} \\,{\\left(\\sigma_4 +L_1 \\,\\cos \\left(\\theta_{0,1} \\right)+\\sigma_2 \\right)}+L_3 \\,{\\dot{\\theta} }_{2,3} \\,\\cos \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\\\\\n{\\dot{\\theta} }_{0,1} +{\\dot{\\theta} }_{1,2} +{\\dot{\\theta} }_{2,3} \n\\end{array}\\right)\\\\\n\\mathrm{}\\\\\n\\textrm{where}\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_1 =L_3 \\,\\sin \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_2 =L_3 \\,\\cos \\left(\\theta_{0,1} +\\theta_{1,2} +\\theta_{2,3} \\right)\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_3 =L_2 \\,\\sin \\left(\\theta_{0,1} +\\theta_{1,2} \\right)\\\\\n\\mathrm{}\\\\\n\\;\\;\\sigma_4 =L_2 \\,\\cos \\left(\\theta_{0,1} +\\theta_{1,2} \\right)\n\\end{array}"}}
%---
%[output:342613f0]
%   data: {"dataType":"text","outputData":{"text":"4.3 ANÁLISIS DE SINGULARIDADES\n","truncated":false}}
%---
%[output:60d2903f]
%   data: {"dataType":"text","outputData":{"text":"------------------------------\n","truncated":false}}
%---
%[output:95c8807e]
%   data: {"dataType":"text","outputData":{"text":"Las singularidades representan configuraciones donde el manipulador pierde grados de libertad en el espacio cartesiano.\n\n","truncated":false}}
%---
%[output:3e805ef7]
%   data: {"dataType":"text","outputData":{"text":"Análisis de una configuración específica [π\/4, π\/6, π\/8]:\n","truncated":false}}
%---
%[output:54327b05]
%   data: {"dataType":"text","outputData":{"text":"- Determinante del Jacobiano: 0.037500\n","truncated":false}}
%---
%[output:4241bc34]
%   data: {"dataType":"text","outputData":{"text":"- Condición del Jacobiano: 33.362\n","truncated":false}}
%---
%[output:515698c9]
%   data: {"dataType":"text","outputData":{"text":"- Interpretación: Jacobiano invertible - configuración no singular\n\n","truncated":false}}
%---
%[output:1ffa7897]
%   data: {"dataType":"text","outputData":{"text":"Las singularidades deben evitarse durante la planificación de trayectorias para garantizar el control efectivo del manipulador.\n\n","truncated":false}}
%---
%[output:04dde8b8]
%   data: {"dataType":"text","outputData":{"text":"5. MODELADO DINÁMICO\n","truncated":false}}
%---
%[output:4d3e0363]
%   data: {"dataType":"text","outputData":{"text":"--------------------\n","truncated":false}}
%---
%[output:21d82da6]
%   data: {"dataType":"text","outputData":{"text":"El modelado dinámico describe las relaciones entre los pares aplicados y el movimiento resultante del robot, considerando efectos inerciales, centrífugos, de Coriolis y gravitatorios.\n\n","truncated":false}}
%---
%[output:7e423a3a]
%   data: {"dataType":"text","outputData":{"text":"5.1 FORMULACIÓN DE EULER-LAGRANGE\n","truncated":false}}
%---
%[output:4aafc8f4]
%   data: {"dataType":"text","outputData":{"text":"---------------------------------\n","truncated":false}}
%---
%[output:93f4ca30]
%   data: {"dataType":"text","outputData":{"text":"La formulación de Euler-Lagrange proporciona un método sistemático para obtener las ecuaciones dinámicas del sistema.\n\n","truncated":false}}
%---
%[output:162072b1]
%   data: {"dataType":"text","outputData":{"text":"Parámetros dinámicos considerados:\n","truncated":false}}
%---
%[output:75d0ff63]
%   data: {"dataType":"text","outputData":{"text":"- m_i: Masas de los eslabones\n","truncated":false}}
%---
%[output:27f0afb8]
%   data: {"dataType":"text","outputData":{"text":"- I_zzi: Momentos de inercia respecto al eje Z\n","truncated":false}}
%---
%[output:131f5225]
%   data: {"dataType":"text","outputData":{"text":"- x_i_Ci: Posiciones de los centros de masa\n","truncated":false}}
%---
%[output:36cc13e6]
%   data: {"dataType":"text","outputData":{"text":"- g: Aceleración gravitacional\n\n","truncated":false}}
%---
%[output:68afa7b1]
%   data: {"dataType":"text","outputData":{"text":"El Lagrangian del sistema se define como:\n","truncated":false}}
%---
%[output:5dc7fa59]
%   data: {"dataType":"text","outputData":{"text":"L = K - U\n","truncated":false}}
%---
%[output:19d9840b]
%   data: {"dataType":"text","outputData":{"text":"donde K es la energía cinética total y U la energía potencial.\n\n","truncated":false}}
%---
%[output:3426833b]
%   data: {"dataType":"text","outputData":{"text":"Aplicando las ecuaciones de Euler-Lagrange:\n","truncated":false}}
%---
%[output:508b1703]
%   data: {"dataType":"text","outputData":{"text":"d\/dt(∂L\/∂θ̇_i) - ∂L\/∂θ_i = τ_i\n","truncated":false}}
%---
%[output:14b86e76]
%   data: {"dataType":"text","outputData":{"text":"se obtiene el modelo dinámico completo del manipulador.\n\n","truncated":false}}
%---
%[output:9e269e4e]
%   data: {"dataType":"text","outputData":{"text":"5.2 FORMA MATRICIAL CANÓNICA\n","truncated":false}}
%---
%[output:82583a2c]
%   data: {"dataType":"text","outputData":{"text":"----------------------------\n","truncated":false}}
%---
%[output:3742639a]
%   data: {"dataType":"text","outputData":{"text":"El modelo dinámico puede expresarse en la forma matricial estándar:\n\n","truncated":false}}
%---
%[output:82dd3c17]
%   data: {"dataType":"text","outputData":{"text":"M(θ)θ̈ + C(θ,θ̇)θ̇ + G(θ) = τ\n\n","truncated":false}}
%---
%[output:78613e4c]
%   data: {"dataType":"text","outputData":{"text":"Componentes del modelo:\n","truncated":false}}
%---
%[output:8120e8b0]
%   data: {"dataType":"text","outputData":{"text":"- M(θ): Matriz de inercia (simétrica y definida positiva)\n","truncated":false}}
%---
%[output:52bbac2b]
%   data: {"dataType":"text","outputData":{"text":"- C(θ,θ̇): Matriz de términos centrífugos y de Coriolis\n","truncated":false}}
%---
%[output:85bf56aa]
%   data: {"dataType":"text","outputData":{"text":"- G(θ): Vector de pares gravitatorios\n","truncated":false}}
%---
%[output:16726e8e]
%   data: {"dataType":"text","outputData":{"text":"- τ: Vector de pares aplicados en las articulaciones\n\n","truncated":false}}
%---
%[output:8b43522b]
%   data: {"dataType":"text","outputData":{"text":"Representación expandida:\n","truncated":false}}
%---
%[output:88d21120]
%   data: {"dataType":"text","outputData":{"text":"┌             ┐ ┌       ┐   ┌     ┐   ┌     ┐   ┌    ┐\n","truncated":false}}
%---
%[output:6f2664a3]
%   data: {"dataType":"text","outputData":{"text":"│ M₁₁ M₁₂ M₁₃ │ │ θ̈₁    │   │ C₁  │   │ G₁  │   │ τ₁ │\n","truncated":false}}
%---
%[output:2f36d74c]
%   data: {"dataType":"text","outputData":{"text":"│ M₂₁ M₂₂ M₂₃ │ │ θ̈₂    │ + │ C₂  │ + │ G₂  │ = │ τ₂ │\n","truncated":false}}
%---
%[output:70786719]
%   data: {"dataType":"text","outputData":{"text":"│ M₃₁ M₃₂ M₃₃ │ │ θ̈₃    │   │ C₃  │   │ G₃  │   │ τ₃ │\n","truncated":false}}
%---
%[output:3e628312]
%   data: {"dataType":"text","outputData":{"text":"└             ┘ └       ┘   └     ┘   └     ┘   └    ┘\n\n","truncated":false}}
%---
%[output:0376c69c]
%   data: {"dataType":"text","outputData":{"text":"6. IMPLEMENTACIÓN COMPUTACIONAL\n","truncated":false}}
%---
%[output:4d036ca4]
%   data: {"dataType":"text","outputData":{"text":"--------------------------------\n","truncated":false}}
%---
%[output:6ce51958]
%   data: {"dataType":"text","outputData":{"text":"La implementación en MATLAB permite la validación numérica de los modelos desarrollados y su posterior utilización en simulaciones.\n\n","truncated":false}}
%---
%[output:668b4606]
%   data: {"dataType":"text","outputData":{"text":"Características de la implementación:\n","truncated":false}}
%---
%[output:743f4d14]
%   data: {"dataType":"text","outputData":{"text":"- Utilización del Symbolic Math Toolbox para derivación analítica\n","truncated":false}}
%---
%[output:2817af2f]
%   data: {"dataType":"text","outputData":{"text":"- Simplificación algebraica de expresiones complejas\n","truncated":false}}
%---
%[output:05ea29ce]
%   data: {"dataType":"text","outputData":{"text":"- Validación numérica con parámetros específicos\n","truncated":false}}
%---
%[output:9e6edd2c]
%   data: {"dataType":"text","outputData":{"text":"- Preparación para integración con algoritmos de control\n\n","truncated":false}}
%---
%[output:01b8c8be]
%   data: {"dataType":"text","outputData":{"text":"7. CONCLUSIONES\n","truncated":false}}
%---
%[output:6bbdbfce]
%   data: {"dataType":"text","outputData":{"text":"---------------\n","truncated":false}}
%---
%[output:3ca02d8c]
%   data: {"dataType":"text","outputData":{"text":"El desarrollo de este examen ha permitido consolidar los conocimientos teóricos adquiridos en la asignatura mediante su aplicación práctica en el modelado completo de un robot.\n\n","truncated":false}}
%---
%[output:7612dfee]
%   data: {"dataType":"text","outputData":{"text":"LOGROS PRINCIPALES:\n","truncated":false}}
%---
%[output:3b968271]
%   data: {"dataType":"text","outputData":{"text":"1. Dominio del modelado cinemático mediante transformaciones homogéneas\n","truncated":false}}
%---
%[output:41d693d9]
%   data: {"dataType":"text","outputData":{"text":"2. Comprensión profunda del Jacobiano y su papel en el análisis de velocidades y singularidades\n","truncated":false}}
%---
%[output:1bceee1e]
%   data: {"dataType":"text","outputData":{"text":"3. Aplicación exitosa de la formulación de Euler-Lagrange para la obtención del modelo dinámico\n","truncated":false}}
%---
%[output:6719a7f5]
%   data: {"dataType":"text","outputData":{"text":"4. Implementación computacional efectiva utilizando MATLAB\n\n","truncated":false}}
%---
%[output:264a4fb5]
%   data: {"dataType":"text","outputData":{"text":"CONTRIBUCIONES DEL TRABAJO:\n","truncated":false}}
%---
%[output:26cc3385]
%   data: {"dataType":"text","outputData":{"text":"- Demostración de competencia en el análisis de sistemas robóticos\n","truncated":false}}
%---
%[output:65d10089]
%   data: {"dataType":"text","outputData":{"text":"- Base sólida para el desarrollo de estrategias de control avanzado\n","truncated":false}}
%---
%[output:1265bd51]
%   data: {"dataType":"text","outputData":{"text":"- Preparación para enfrentar problemas de robótica industrial real\n","truncated":false}}
%---
%[output:9770714f]
%   data: {"dataType":"text","outputData":{"text":"- Desarrollo de habilidades en modelado matemático y computacional\n\n","truncated":false}}
%---
%[output:973ef29f]
%   data: {"dataType":"text","outputData":{"text":"PERSPECTIVAS FUTURAS:\n","truncated":false}}
%---
%[output:9f36f4eb]
%   data: {"dataType":"text","outputData":{"text":"El modelado presentado constituye la base para investigaciones futuras, planificación óptima de trayectorias y simulación de sistemas mecatrónicos complejos, representando un avance significativo en la formación como ingeniero. El rigor matemático aplicado y la metodología sistemática empleada evidencian el nivel de excelencia académica alcanzado en el dominio de los principios fundamentales de la robótica moderna.\n\n","truncated":false}}
%---
