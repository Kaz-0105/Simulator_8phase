function make_road_prms(obj, maps)
    % intersection構造体の取得
    intersection_struct_map = maps('intersection_struct_map');
    intersection_struct = intersection_struct_map(obj.id);

    % road構造体の辞書型配列を取得
    road_struct_map = maps('road_struct_map');

    % モデル内の道路のパラメータを収納する構造体を定義
    north_road = [];
    south_road = [];
    east_road = [];
    west_road = [];


    % 東西南北の道路に対しそれぞれのパラメータを収納する
    for irid = intersection_struct.input_road_ids
        if strcmp(intersection_struct.input_road_directions(irid), "north")
            road_struct = road_struct_map(irid);
            north_road.D_b = road_struct.D_b; % D_b: 車線の分岐点から信号機までの長さ
            north_road.D_f = road_struct.D_f; % D_f: 先行車の影響圏に入る距離
            north_road.D_s = road_struct.D_s; % D_s: 信号機の影響圏に入る距離
            north_road.d_s = road_struct.d_s; % d_s: 信号機と停止線の間の距離
            north_road.d_f = road_struct.d_f; % d_f: 先行車と最接近したときの距離
            north_road.p_s = road_struct.p_s; % p_s: 信号機の位置
            north_road.v = road_struct.v*1000/3600; % v: 速度[m/s]

        elseif strcmp(intersection_struct.input_road_directions(irid), "south")
            road_struct = road_struct_map(irid);
            south_road.D_b = road_struct.D_b; % D_b: 車線の分岐点から信号機までの長さ
            south_road.D_f = road_struct.D_f; % D_f: 先行車の影響圏に入る距離
            south_road.D_s = road_struct.D_s; % D_s: 信号機の影響圏に入る距離
            south_road.d_s = road_struct.d_s; % d_s: 信号機と停止線の間の距離
            south_road.d_f = road_struct.d_f; % d_f: 先行車と最接近したときの距離
            south_road.p_s = road_struct.p_s; % p_s: 信号機の位置
            south_road.v = road_struct.v*1000/3600; % v: 速度[m/s]

        elseif strcmp(intersection_struct.input_road_directions(irid), "east")
            road_struct = road_struct_map(irid);
            east_road.D_b = road_struct.D_b; % D_b: 車線の分岐点から信号機までの長さ
            east_road.D_f = road_struct.D_f; % D_f: 先行車の影響圏に入る距離
            east_road.D_s = road_struct.D_s; % D_s: 信号機の影響圏に入る距離
            east_road.d_s = road_struct.d_s; % d_s: 信号機と停止線の間の距離
            east_road.d_f = road_struct.d_f; % d_f: 先行車と最接近したときの距離
            east_road.p_s = road_struct.p_s; % p_s: 信号機の位置
            east_road.v = road_struct.v*1000/3600; % v: 速度[m/s]

        elseif strcmp(intersection_struct.input_road_directions(irid), "west")
            road_struct = road_struct_map(irid);
            west_road.D_b = road_struct.D_b; % D_b: 車線の分岐点から信号機までの長さ
            west_road.D_f = road_struct.D_f; % D_f: 先行車の影響圏に入る距離
            west_road.D_s = road_struct.D_s; % D_s: 信号機の影響圏に入る距離
            west_road.d_s = road_struct.d_s; % d_s: 信号機と停止線の間の距離
            west_road.d_f = road_struct.d_f; % d_f: 先行車と最接近したときの距離
            west_road.p_s = road_struct.p_s; % p_s: 信号機の位置
            west_road.v = road_struct.v*1000/3600; % v: 速度[m/s]
        end
    end

    % 1つの構造体にまとめる
    obj.road_prms.north = north_road;
    obj.road_prms.south = south_road;
    obj.road_prms.east = east_road;
    obj.road_prms.west = west_road;

end