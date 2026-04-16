function tests = test_convert
% Run with: results = runtests('tests')
    tests = functiontests(localfunctions);
end

function testOutputSize(testCase)
    lat = [48.8566; 45.7640; 43.2965];
    lon = [2.3522; 4.8357; 5.3698];
    [E, N] = lambertproj.convert(lat, lon);
    verifySize(testCase, E, size(lat));
    verifySize(testCase, N, size(lat));
end

function testLambert93Finite(testCase)
    [E, N] = lambertproj.convert(48.8566, 2.3522);
    verifyTrue(testCase, isfinite(E));
    verifyTrue(testCase, isfinite(N));
end

function testTableConversion(testCase)
    T = table([48.8; 45.7], [2.3; 4.8], 'VariableNames', {'lat', 'lon'});
    Tout = lambertproj.convert_table(T, "lat", "lon");
    verifyTrue(testCase, ismember('Easting', Tout.Properties.VariableNames));
    verifyTrue(testCase, ismember('Northing', Tout.Properties.VariableNames));
end
