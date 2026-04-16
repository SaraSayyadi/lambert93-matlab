function [E, N] = convert(phi, lambda, params)
%LAMBERTPROJ.CONVERT Convert geographic coordinates to Lambert Conformal Conic.
%
%   [E, N] = lambertproj.convert(phi, lambda)
%   converts latitude/longitude in degrees to Lambert-93 coordinates using
%   the built-in Lambert-93 preset.
%
%   [E, N] = lambertproj.convert(phi, lambda, params)
%   converts latitude/longitude in degrees using a custom Lambert Conformal
%   Conic parameter structure.
%
% Inputs
%   phi     - latitude in degrees (scalar, vector, or array)
%   lambda  - longitude in degrees (same size as phi)
%   params  - structure with fields:
%             falseEasting
%             falseNorthing
%             latitudeOfOrigin
%             centralMeridian
%             standardParallel1
%             standardParallel2
%             semiMajorAxis
%             flattening
%
% Outputs
%   E       - Easting in meters
%   N       - Northing in meters
%
% Example
%   [E, N] = lambertproj.convert(48.8566, 2.3522);
%
% See also lambertproj.preset, lambertproj.convert_table

    if nargin < 3 || isempty(params)
        params = lambertproj.preset("lambert93");
    end

    validateattributes(phi, {'numeric'}, {'real', 'nonempty'}, mfilename, 'phi', 1);
    validateattributes(lambda, {'numeric'}, {'real', 'nonempty'}, mfilename, 'lambda', 2);

    if ~isequal(size(phi), size(lambda))
        error('lambertproj:SizeMismatch', 'phi and lambda must have the same size.');
    end

    requiredFields = [ ...
        "falseEasting", "falseNorthing", "latitudeOfOrigin", ...
        "centralMeridian", "standardParallel1", "standardParallel2", ...
        "semiMajorAxis", "flattening"];

    for k = 1:numel(requiredFields)
        if ~isfield(params, requiredFields(k))
            error('lambertproj:MissingField', ...
                'Parameter structure is missing field "%s".', requiredFields(k));
        end
    end

    % Convert degrees to radians
    phiRad = deg2rad(phi);
    lambdaRad = deg2rad(lambda);
    phi1 = deg2rad(params.standardParallel1);
    phi2 = deg2rad(params.standardParallel2);
    phif = deg2rad(params.latitudeOfOrigin);
    lambdaf = deg2rad(params.centralMeridian);

    Ef = params.falseEasting;
    Nf = params.falseNorthing;
    a = params.semiMajorAxis;
    f = params.flattening;

    e2 = (2 .* f) - (f.^2);
    e = sqrt(e2);

    m1 = cos(phi1) ./ sqrt(1 - e2 .* sin(phi1).^2);
    m2 = cos(phi2) ./ sqrt(1 - e2 .* sin(phi2).^2);

    t = local_t(phiRad, e);
    t1 = local_t(phi1, e);
    t2 = local_t(phi2, e);
    tf = local_t(phif, e);

    n = (log(m1) - log(m2)) / (log(t1) - log(t2));
    F = m1 / (n * (t1^n));

    r = a .* F .* (t.^n);
    rf = a .* F .* (tf.^n);
    theta = n .* (lambdaRad - lambdaf);

    E = Ef + r .* sin(theta);
    N = Nf + rf - r .* cos(theta);
end

function t = local_t(phi, e)
    t = tan(pi/4 - phi/2) ./ (((1 - e .* sin(phi)) ./ (1 + e .* sin(phi))).^(e/2));
end
