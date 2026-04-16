function outTable = convert_excel(inputFile, outputFile, latVar, lonVar, params)
%LAMBERTPROJ.CONVERT_EXCEL Read coordinates from Excel and write results.
%
%   outTable = lambertproj.convert_excel("input.xlsx", "output.xlsx", "lat", "lon")

    arguments
        inputFile {mustBeTextScalar}
        outputFile {mustBeTextScalar}
        latVar {mustBeTextScalar}
        lonVar {mustBeTextScalar}
        params struct = lambertproj.preset("lambert93")
    end

    tbl = readtable(inputFile);
    outTable = lambertproj.convert_table(tbl, latVar, lonVar, params);
    writetable(outTable, outputFile);
end
