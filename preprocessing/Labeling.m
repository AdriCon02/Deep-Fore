function [labelData] = Etiquetado(imds,etiquetas,anots,data_size,roi_size,etiq_dir)
%Esta función devuelve una tabla con todos los bounding boxes de los
%centroides que forman parte de las anotaciones extraídas. Dicha tabla
%contendrá información separada sobre cada clase.

%Creamos los groundTruth para todas las clases 
num_datos = size(anots,2);

%Al principio, inicializamos los GT como celdas vacías
tumorTruth = cell(num_datos,1);
notumorTruth = cell(num_datos,1);
mitosisTruth = cell(num_datos,1);
apoptosisTruth = cell(num_datos,1);
lumenTruth = cell(num_datos,1);
nolumenTruth = cell(num_datos,1);

for i = 1:num_datos

%Extraemos las coordenadas de los centroides de cada clase

%TUMOR
if ~isempty(anots{i}.anotaciones_tumor)
    cell_tumor=struct2cell(anots{i}.anotaciones_tumor(:))';
else
    cell_tumor=num2cell(anots{i}.anotaciones_tumor(:))';
end

%Convierto a arrays para poder coger parejas x-y de centroides
centr_tumor=cell2mat(cell_tumor);
num_bbox_tumor=size(centr_tumor,1);
bboxTruth_tumor = cell(num_bbox_tumor,1);


%NO TUMOR
if ~isempty(anots{i}.anotaciones_no_tumor)
    cell_no_tumor=struct2cell(anots{i}.anotaciones_no_tumor(:))';
else
    cell_no_tumor=num2cell(anots{i}.anotaciones_no_tumor(:))';
end

%Convierto a arrays para poder coger parejas x-y de centroides
centr_no_tumor=cell2mat(cell_no_tumor);
num_bbox_no_tumor=size(centr_no_tumor,1);
bboxTruth_no_tumor = cell(num_bbox_no_tumor,1);


%MITOSIS
if ~isempty(anots{i}.anotaciones_mitosis)
    cell_mitosis=struct2cell(anots{i}.anotaciones_mitosis(:))';
else
    cell_mitosis=num2cell(anots{i}.anotaciones_mitosis(:))';
end

%Convierto a arrays para poder coger parejas x-y de centroides
centr_mitosis=cell2mat(cell_mitosis);
num_bbox_mitosis=size(centr_mitosis,1);
bboxTruth_mitosis = cell(num_bbox_mitosis,1);

%APOPTOSIS
if ~isempty(anots{i}.anotaciones_apoptosis)
    cell_apoptosis=struct2cell(anots{i}.anotaciones_apoptosis(:))';
else
    cell_apoptosis=num2cell(anots{i}.anotaciones_apoptosis(:))';
end

%Convierto a arrays para poder coger parejas x-y de centroides
centr_apoptosis=cell2mat(cell_apoptosis);
num_bbox_apoptosis=size(centr_apoptosis,1);
bboxTruth_apoptosis = cell(num_bbox_apoptosis,1);


%LUMEN
if ~isempty(anots{i}.anotaciones_lumen)
    cell_lumen=struct2cell(anots{i}.anotaciones_lumen(:))';
else
    cell_lumen=num2cell(anots{i}.anotaciones_lumen(:))';
end

%Convierto a arrays para poder coger parejas x-y de centroides
centr_lumen=cell2mat(cell_lumen);
num_bbox_lumen=size(centr_lumen,1);
bboxTruth_lumen = cell(num_bbox_lumen,1);

%NO LUMEN
if ~isempty(anots{i}.anotaciones_no_lumen)
    cell_no_lumen=struct2cell(anots{i}.anotaciones_no_lumen(:))';
else
    cell_no_lumen= num2cell(anots{i}.anotaciones_no_lumen(:))';
end

%Convierto a arrays para poder coger parejas x-y de centroides
centr_no_lumen=cell2mat(cell_no_lumen);
num_bbox_no_lumen=size(centr_no_lumen,1);
bboxTruth_no_lumen = cell(num_bbox_no_lumen,1);

if ~isempty(centr_tumor)

    % Transformo los centroides a coordenadas en píxeles de la imagen
    centr_tumor(:,1)=centr_tumor(:,1)*data_size(1);
    centr_tumor(:,2)=centr_tumor(:,2)*data_size(2);

for j=1:num_bbox_tumor

    bboxTruth_tumor{j}=[];

        % Calcular las coordenadas de esquina inferior izquierda del rectángulo
    x_rect_tumor_ii = centr_tumor(j,1) - roi_size(1) / 2;
    y_rect_tumor_ii = centr_tumor(j,2) - roi_size(1)/ 2;

    % Calcular las coordenadas de esquina sup izq del rectángulo
    x_rect_tumor_si = centr_tumor(j,1) - roi_size(1) / 2;
    y_rect_tumor_si = centr_tumor(j,2) + roi_size(1)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_tumor_sd = centr_tumor(j,1) + roi_size(1) / 2;
    y_rect_tumor_sd = centr_tumor(j,2) + roi_size(1)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_tumor_id = centr_tumor(j,1) + roi_size(1) / 2;
    y_rect_tumor_id = centr_tumor(j,2) - roi_size(1)/ 2;

    % Añado los bounding boxes como GT de la clase
    bboxTruth_tumor{j}=[x_rect_tumor_ii y_rect_tumor_ii; x_rect_tumor_si y_rect_tumor_si; x_rect_tumor_sd y_rect_tumor_sd;x_rect_tumor_id y_rect_tumor_id];

end
    tumorTruth{i}=bboxTruth_tumor;
end

   
if ~isempty(centr_no_tumor)

    % Transformo los centroides a coordenadas en píxeles de la imagen
    centr_no_tumor(:,1)=centr_no_tumor(:,1)*data_size(1);
    centr_no_tumor(:,2)=centr_no_tumor(:,2)*data_size(2);

for j=1:num_bbox_no_tumor

    bboxTruth_no_tumor{j}=[];

        % Calcular las coordenadas de esquina inferior izquierda del rectángulo
    x_rect_no_tumor_ii = centr_no_tumor(j,1) - roi_size(2) / 2;
    y_rect_no_tumor_ii = centr_no_tumor(j,2) - roi_size(2)/ 2;

    % Calcular las coordenadas de esquina sup izq del rectángulo
    x_rect_no_tumor_si = centr_no_tumor(j,1) - roi_size(2) / 2;
    y_rect_no_tumor_si = centr_no_tumor(j,2) + roi_size(2)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_no_tumor_sd = centr_no_tumor(j,1) + roi_size(2) / 2;
    y_rect_no_tumor_sd = centr_no_tumor(j,2) + roi_size(2)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_no_tumor_id = centr_no_tumor(j,1) + roi_size(2) / 2;
    y_rect_no_tumor_id = centr_no_tumor(j,2) - roi_size(2)/ 2;

    % Añado los bounding boxes como GT de la clase
    bboxTruth_no_tumor{j}=[x_rect_no_tumor_ii y_rect_no_tumor_ii; x_rect_no_tumor_si y_rect_no_tumor_si; x_rect_no_tumor_sd y_rect_no_tumor_sd;...
        x_rect_no_tumor_id y_rect_no_tumor_id];

end
    notumorTruth{i}=bboxTruth_no_tumor;

end

if ~isempty(centr_mitosis)


    centr_mitosis(:,1)=centr_mitosis(:,1)*data_size(1);
    centr_mitosis(:,2)=centr_mitosis(:,2)*data_size(2);

for j=1:num_bbox_mitosis

    bboxTruth_mitosis{j}=[];

        % Calcular las coordenadas de esquina inferior izquierda del rectángulo
    x_rect_mitosis_ii = centr_mitosis(j,1) - roi_size(3) / 2;
    y_rect_mitosis_ii = centr_mitosis(j,2) - roi_size(3)/ 2;

    % Calcular las coordenadas de esquina sup izq del rectángulo
    x_rect_mitosis_si = centr_mitosis(j,1) - roi_size(3) / 2;
    y_rect_mitosis_si = centr_mitosis(j,2) + roi_size(3)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_mitosis_sd = centr_mitosis(j,1) + roi_size(3) / 2;
    y_rect_mitosis_sd = centr_mitosis(j,2) + roi_size(3)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_mitosis_id = centr_mitosis(j,1) + roi_size(3) / 2;
    y_rect_mitosis_id = centr_mitosis(j,2) - roi_size(3)/ 2;

    % Añado los bounding boxes como GT de la clase
    bboxTruth_mitosis{j}=[x_rect_mitosis_ii y_rect_mitosis_ii; x_rect_mitosis_si y_rect_mitosis_si; x_rect_mitosis_sd y_rect_mitosis_sd;...
        x_rect_mitosis_id y_rect_mitosis_id];

end
    mitosisTruth{i}=bboxTruth_mitosis;
end

if ~isempty(centr_apoptosis)

    % Transformo los centroides a coordenadas en píxeles de la imagen
    centr_apoptosis(:,1)=centr_apoptosis(:,1)*data_size(1);
    centr_apoptosis(:,2)=centr_apoptosis(:,2)*data_size(2);

for j=1:num_bbox_apoptosis

    bboxTruth_apoptosis{j}=[];

        % Calcular las coordenadas de esquina inferior izquierda del rectángulo
    x_rect_apoptosis_ii = centr_apoptosis(j,1) - roi_size(4) / 2;
    y_rect_apoptosis_ii = centr_apoptosis(j,2) - roi_size(4)/ 2;

    % Calcular las coordenadas de esquina sup izq del rectángulo
    x_rect_apoptosis_si = centr_apoptosis(j,1) - roi_size(4) / 2;
    y_rect_apoptosis_si = centr_apoptosis(j,2) + roi_size(4)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_apoptosis_sd = centr_apoptosis(j,1) + roi_size(4) / 2;
    y_rect_apoptosis_sd = centr_apoptosis(j,2) + roi_size(4)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_apoptosis_id = centr_apoptosis(j,1) + roi_size(4) / 2;
    y_rect_apoptosis_id = centr_apoptosis(j,2) - roi_size(4)/ 2;

    % Añado los bounding boxes como GT de la clase
    bboxTruth_apoptosis{j}=[x_rect_apoptosis_ii y_rect_apoptosis_ii; x_rect_apoptosis_si y_rect_apoptosis_si; x_rect_apoptosis_sd y_rect_apoptosis_sd;...
        x_rect_apoptosis_id y_rect_apoptosis_id];

end
    apoptosisTruth{i}=bboxTruth_apoptosis;
end

if ~isempty(centr_lumen)

    % Transformo los centroides a coordenadas en píxeles de la imagen
    centr_lumen(:,1)=centr_lumen(:,1)*data_size(1);
    centr_lumen(:,2)=centr_lumen(:,2)*data_size(2);

for j=1:num_bbox_lumen

    bboxTruth_lumen{j}=[];

        % Calcular las coordenadas de esquina inferior izquierda del rectángulo
    x_rect_lumen_ii = centr_lumen(j,1) - roi_size(5) / 2;
    y_rect_lumen_ii = centr_lumen(j,2) - roi_size(5)/ 2;

    % Calcular las coordenadas de esquina sup izq del rectángulo
    x_rect_lumen_si = centr_lumen(j,1) - roi_size(5) / 2;
    y_rect_lumen_si = centr_lumen(j,2) + roi_size(5)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_lumen_sd = centr_lumen(j,1) + roi_size(5) / 2;
    y_rect_lumen_sd = centr_lumen(j,2) + roi_size(5)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_lumen_id = centr_lumen(j,1) + roi_size(5) / 2;
    y_rect_lumen_id = centr_lumen(j,2) - roi_size(5)/ 2;

    % Añado los bounding boxes como GT de la clase
    bboxTruth_lumen{j}=[x_rect_lumen_ii y_rect_lumen_ii; x_rect_lumen_si y_rect_lumen_si; x_rect_lumen_sd y_rect_lumen_sd;...
        x_rect_lumen_id y_rect_lumen_id];

end
    lumenTruth{i}=bboxTruth_lumen;
end

if ~isempty(centr_no_lumen)

    % Transformo los centroides a coordenadas en píxeles de la imagen
    centr_no_lumen(:,1)=centr_no_lumen(:,1)*data_size(1);
    centr_no_lumen(:,2)=centr_no_lumen(:,2)*data_size(2);

for j=1:num_bbox_no_lumen

    bboxTruth_no_lumen{j}=[];

        % Calcular las coordenadas de esquina inferior izquierda del rectángulo
    x_rect_no_lumen_ii = centr_no_lumen(j,1) - roi_size(6) / 2;
    y_rect_no_lumen_ii = centr_no_lumen(j,2) - roi_size(6)/ 2;

    % Calcular las coordenadas de esquina sup izq del rectángulo
    x_rect_no_lumen_si = centr_no_lumen(j,1) - roi_size(6) / 2;
    y_rect_no_lumen_si = centr_no_lumen(j,2) + roi_size(6)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_no_lumen_sd = centr_no_lumen(j,1) + roi_size(6) / 2;
    y_rect_no_lumen_sd = centr_no_lumen(j,2) + roi_size(6)/ 2;

    % Calcular las coordenadas de esquina sup der del rectángulo
    x_rect_no_lumen_id = centr_no_lumen(j,1) + roi_size(6) / 2;
    y_rect_no_lumen_id = centr_no_lumen(j,2) - roi_size(6)/ 2;

    % Añado los bounding boxes como GT de la clase
    bboxTruth_no_lumen{j}=[x_rect_no_lumen_ii y_rect_no_lumen_ii; x_rect_no_lumen_si y_rect_no_lumen_si; x_rect_no_lumen_sd y_rect_no_lumen_sd;...
        x_rect_no_lumen_id y_rect_no_lumen_id];

end
    nolumenTruth{i}=bboxTruth_no_lumen;
end
end

hold off;

i=1;

imshow(imds.Files{i})

for j = 1:length(tumorTruth{i})

    bbox = tumorTruth{i}{j};
    rectangle('Position', [bbox(1,1) bbox(1,2) bbox(3,1)-bbox(1,1) bbox(3,2)-bbox(1,2)], 'EdgeColor', 'r', 'LineWidth', 2);
end

for j = 1:length(notumorTruth{i})

    bbox = notumorTruth{i}{j};
    rectangle('Position', [bbox(1,1) bbox(1,2) bbox(3,1)-bbox(1,1) bbox(3,2)-bbox(1,2)], 'EdgeColor', 'g', 'LineWidth', 2);
end

for j = 1:length(lumenTruth{i})

    bbox = lumenTruth{i}{j};
    rectangle('Position', [bbox(1,1) bbox(1,2) bbox(3,1)-bbox(1,1) bbox(3,2)-bbox(1,2)], 'EdgeColor', 'b', 'LineWidth', 2);
end

for j = 1:length(nolumenTruth{i})

    bbox = nolumenTruth{i}{j};
    rectangle('Position', [bbox(1,1) bbox(1,2) bbox(3,1)-bbox(1,1) bbox(3,2)-bbox(1,2)], 'EdgeColor', 'y', 'LineWidth', 2);
end

for j = 1:length(mitosisTruth{i})

    bbox = mitosisTruth{i}{j};
    rectangle('Position', [bbox(1,1) bbox(1,2) bbox(3,1)-bbox(1,1) bbox(3,2)-bbox(1,2)], 'EdgeColor', 'k', 'LineWidth', 2);
end

for j = 1:length(apoptosisTruth{i})

    bbox = apoptosisTruth{i}{j};
    rectangle('Position', [bbox(1,1) bbox(1,2) bbox(3,1)-bbox(1,1) bbox(3,2)-bbox(1,2)], 'EdgeColor', 'm', 'LineWidth', 2);
end
% % %Crea un directorio para las imagenes con los bounding boxes
% if ~exist(etiq_dir, 'dir')
%          mkdir(etiq_dir);
%  end
% 
% % % Genera un nombre de archivo único para cada iteración
% nombre = sprintf('image_labeled_%03d.png', i);
% 
% % % Extrae la figura
% f=gcf;
% 
% % %Combina la ruta y el nombre del archivo
% ruta_guardado = fullfile(etiq_dir, nombre);
% 
% % %Guarda la figura con todas las superposiciones
% saveas(f, ruta_guardado, 'png');
% 
% % %Cierra la figura si ya no la necesitas
% close(f);

%Construye la tabla del labelData
labelData = table(tumorTruth,notumorTruth,mitosisTruth,apoptosisTruth,lumenTruth,nolumenTruth,'VariableNames',etiquetas);

end