function get_measurement_data(obj, v_obj)
    % キューの長さに関するmapの作成
    nos       = v_obj.Net.QueueCounters.GetMultiAttValues('No');
    Qlens     = v_obj.Net.QueueCounters.GetMultiAttValues('QLen(Current,Last)');
    [m_num,~] = size(nos);
    for m_idx = 1:m_num
        no_v                   = nos{m_idx,2};
        Qlen_v                 = Qlens{m_idx,2};
        if isnan(Qlen_v) 
            obj.queue_no_map(no_v) = 0;
        else
            obj.queue_no_map(no_v) = Qlen_v;
        end
    end

    % 遅延時間に関するmapの作成
    nos    = v_obj.Net.DelayMeasurements.GetMultiAttValues('No');
    delays = v_obj.Net.DelayMeasurements.GetMultiAttValues('VehDelay(Current,Last,All)');
    vehs   = v_obj.Net.DelayMeasurements.GetMultiAttValues('Vehs(Current,Last,All)');
    [m_num,~] = size(nos);
    for m_idx = 1:m_num
        no_v = nos{m_idx,2};
        delay_v = delays{m_idx,2};
        vhe_v = vehs{m_idx,2};

        if isnan(delay_v)
            tmp_struct.delay = 0;
        else
            tmp_struct.delay = delay_v;
        end

        if isnan(vhe_v)
            tmp_struct.num_veh = 0;
        else
            tmp_struct.num_veh = vhe_v;
        end
        
        obj.delay_no_map(no_v) = tmp_struct;
    end

end