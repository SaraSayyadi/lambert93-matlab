% Example 1: single point conversion using Lambert-93
lat = 48.8566;
lon = 2.3522;
[E, N] = lambertproj.convert(lat, lon);
fprintf('Paris -> E = %.3f m, N = %.3f m\n', E, N);

% Example 2: table conversion
T = table([48.8566; 45.7640], [2.3522; 4.8357], ...
    'VariableNames', {'Latitude', 'Longitude'});
Tout = lambertproj.convert_table(T, "Latitude", "Longitude");
disp(Tout)

% Example 3: original repository custom preset
params = lambertproj.preset("repo_custom");
[E2, N2] = lambertproj.convert(64.1466, -21.9426, params);
fprintf('Custom preset example -> E = %.3f m, N = %.3f m\n', E2, N2);
