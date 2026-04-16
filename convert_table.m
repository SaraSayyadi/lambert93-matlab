function outTable = convert_table(inTable, latVar, lonVar, params)
%LAMBERTPROJ.CONVERT_TABLE Convert latitude/longitude columns in a table.
%
%   outTable = lambertproj.convert_table(inTable, "lat", "lon")
%   adds Easting and Northing columns using the Lambert-93 preset.

    arguments
        inTable table
        latVar {mustBeTextScalar}
        lonVar {mustBeTextScalar}
        params struct = lambertproj.preset("lambert93")
    end

    latVar = string(latVar);
    lonVar = string(lonVar);

    if ~ismember(latVar, string(inTable.Properties.VariableNames))
        error('lambertproj:MissingLatitudeColumn', ...
            'Latitude column "%s" not found.', latVar);
    end

    if ~ismember(lonVar, string(inTable.Properties.VariableNames))
        error('lambertproj:MissingLongitudeColumn', ...
            'Longitude column "%s" not found.', lonVar);
    end

    [E, N] = lambertproj.convert(inTable.(latVar), inTable.(lonVar), params);

    outTable = inTable;
    outTable.Easting = E;
    outTable.Northing = N;
end
