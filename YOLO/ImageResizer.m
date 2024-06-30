function ImageResizer(inputFolder,outputFolder,targetSize)

 % Esta función redimensiona las imágenes contenidas en 'inputFolder' dado
 % el tamaño deseado 'targetSize' para luego adjuntarlas a la carpeta
 % especificada en la dirección 'outputFolder'.
    
    %Crea la carpeta si esta no existe
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end
    
    % Extraigo todas las imágenes del 'inputFolder'
    imageFiles = dir(fullfile(inputFolder, '*.tif')); 
   
    
    % Bucle para redimensionar y guardar las imágenes
    for i = 1:length(imageFiles)

        % Leer la imagen original
        originalImage = imread(fullfile(inputFolder, imageFiles(i).name));
    
        % Redimensionar la imagen
        resizedImage = imresize(originalImage, targetSize);
    
        % Nombre del archivo de salida
        outputFileName = fullfile(outputFolder, [num2str(i) '.png']);
    
        % Guardar la imagen redimensionada en la carpeta de destino
        imwrite(resizedImage, outputFileName);
    end
end