# lambert93-matlab

A small MATLAB package for converting geographic coordinates (latitude/longitude in degrees) to Lambert Conformal Conic projected coordinates.

This package is organized so it can be used more easily from GitHub, reused in other projects, and extended later into a MATLAB toolbox.



The original repository contains:

- a script called `covert.m`
- a function called `lambert2.m`
- a minimal README



## Package structure

```text
lambert93-matlab/
├── +lambertproj/
│   ├── convert.m
│   ├── convert_table.m
│   ├── convert_excel.m
│   └── preset.m
├── examples/
│   └── example_convert.m
├── tests/
│   └── test_convert.m
└── README.md
```

## Presets included

### 1) `lambert93`
Standard Lambert-93 preset for metropolitan France:

- False Easting: 700000 m
- False Northing: 6600000 m
- Latitude of origin: 46.5°
- Central meridian: 3.0°
- Standard parallels: 44.0° and 49.0°

### 2) `repo_custom`
A preset that matches the parameters currently used in your original repository:

- False Easting: 500000 m
- False Northing: 500000 m
- Latitude of origin: 65.0°
- Central meridian: -19.0°
- Standard parallels: 64.25° and 65.75°

## Basic usage

Add the repository folder to your MATLAB path, then run:

```matlab
[E, N] = lambertproj.convert(48.8566, 2.3522);
```

That uses the Lambert-93 preset by default.

## Use a custom preset

```matlab
params = lambertproj.preset("repo_custom");
[E, N] = lambertproj.convert(64.1466, -21.9426, params);
```

## Convert columns in a table

```matlab
T = table([48.8566; 45.7640], [2.3522; 4.8357], ...
    'VariableNames', {'Latitude', 'Longitude'});

Tout = lambertproj.convert_table(T, "Latitude", "Longitude");
```

## Convert an Excel file

```matlab
outTable = lambertproj.convert_excel(
    "input.xlsx", ...
    "output.xlsx", ...
    "Latitude", ...
    "Longitude");
```

## Suggested next step inside MATLAB

If you want a downloadable toolbox file, open MATLAB and use:

- **Home -> Add-Ons -> Package Toolbox**

Then package this folder as a `.mltbx` file.
