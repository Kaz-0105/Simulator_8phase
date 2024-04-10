function make_link_DC_measurement_map(obj)

    % キー：DataCollectionPointのID、バリュー：リンクIDのディクショナリを作成
    DC_point_link_map = dictionary(int32.empty, int32.empty);

    DC_points_obj = obj.vis_obj.Net.DataCollectionPoint;

    for DC_point_obj = DC_points_obj.GetAll()'
        DC_point_obj = DC_point_obj{1};

        DC_point_id = DC_point_obj.get('AttValue','No');

        link_id = DC_point_obj.get('AttValue', 'Lane');
        link_id = str2double(link_id(1 : strlength(link_id) -2));

        DC_point_link_map(DC_point_id) = link_id;
    end

    % キー：リンクID、バリュー：DataCollectionMeasurementのIDのディクショナリを作成
    DC_measurements_obj = obj.vis_obj.Net.DataCollectionMeasurement;

    for DC_measurement_obj = DC_measurements_obj.GetAll()'
        DC_measurement_obj = DC_measurement_obj{1};

        DC_measurement_id = DC_measurement_obj.get('AttValue','No');


        DC_point_id = DC_measurement_obj.get('AttValue','DataCollectionPoints');
        if ischar(DC_point_id)
            DC_point_id = str2double(DC_point_id);
        end
        % pointが2つ以上あるとエラー吐くと思う。

        obj.link_DC_measurement_map(DC_point_link_map(DC_point_id)) = DC_measurement_id;
    end
end