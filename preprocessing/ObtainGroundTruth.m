function [gTruth] = ObtenerGroundTruth(imds,labelData,etiquetas)

%Esta función crea un objeto del tipo Ground Truth tomando como información
%la fuente de las imágenes y las anotaciones correspondientes en formato de
%tabla.

%Inicializamos el etiquetador
ldc = labelDefinitionCreator();

for i = 1:length(etiquetas)

    %Definimos que el etiquetado serán rectangulos comprendiendo un área
    %determinada de la imagen
    addLabel(ldc, etiquetas{i}, labelType.Polygon);

end

%Inicializamos un objeto etiquetador
labelDefs = create(ldc);

%El ground truth estará vinculado a la fuente de donde provengan las
%imágenes
dataSource= groundTruthDataSource(imds.Files);

%Creamos finalmente el objeto tipo GroundTruth
gTruth = groundTruth(dataSource,labelDefs,labelData);

end