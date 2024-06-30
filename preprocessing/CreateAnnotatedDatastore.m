function [imds,anots] = CrearDatastoreAnotado(ruta_dir,dir_anots)

% Crea un imageDatastore
imds= imageDatastore(ruta_dir,"FileExtensions",'.png');

% Obtiene los nombres de archivo
nombres_archivo = imds.Files;

% Extrae los números de los nombres de archivo
numeros = cellfun(@(x) str2double(regexp(x, '\d+', 'match')), nombres_archivo, 'UniformOutput', false);

% Ordena las imágenes según los números en los nombres de archivo
[~, indices_ordenados] = sort(cellfun(@min, numeros));

% Reordena el ImageDataStore
imds.Files = nombres_archivo(indices_ordenados);

% Obtiene la lista de archivos JSON en el directorio
json_files = dir(fullfile(dir_anots, '*.json'));

% Inicializa una celda para almacenar las anotaciones
anots = {};

% Itera sobre cada archivo JSON
for i = 1:length(json_files)
    % Construye la ruta completa del archivo JSON actual
    json_file = fullfile(dir_anots, json_files(i).name);

    try
        % Lee el contenido del archivo JSON actual
        datos = jsondecode(fileread(json_file));

        % Accede a las anotaciones de la imagen actual
        anots_tumor = datos.tumor;
        anots_no_tumor = datos.non_tumor;
        anots_mitosis = datos.mitosis;
        anots_apoptosis = datos.apoptosis;
        anots_lumen= datos.lumen;
        anots_no_lumen= datos.non_lumen;

        % Printea por pantalla las anotaciones extraídas
        disp(['Anotaciones para la imagen ', json_files(i).name, ':']);
      
        % Agrega las anotaciones al conjunto total
        anots{end+1} = struct('nombre_imagen', json_files(i).name, 'anotaciones_tumor',...
            anots_tumor, 'anotaciones_no_tumor',...
            anots_no_tumor,'anotaciones_mitosis',...
            anots_mitosis,'anotaciones_apoptosis',...
            anots_apoptosis,'anotaciones_lumen',...
            anots_lumen,'anotaciones_no_lumen',...
            anots_no_lumen);

    catch
        %Error por si la información no puede ser extraída
        warning(['Error al leer el archivo JSON: ', json_files(i).name]);
    end
end
end