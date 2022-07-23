% shishi = zhixian([0,0],[1,1],1);
% % shishi2 = zhixian([0,1],[1,0],1);
% shishi2 = zhixian([0,1],shishi,'PtoLine');
% jiaodian = shishi.get_jiaodian(shishi2);
% huatu2(shishi.visual(-1,1));
% huatu2(shishi2.visual(-1,1));
% huatu2(jiaodian);
% 
% yuanxin = get_yuanxin(shishi,shishi2,0.5,[0.5,1.1]) ; 
% huatu2(yuanxin);

huatu2(uv_top_r2);huatu2(uv_bot_r2);
huatu2(uv_top_r);huatu2(uv_bot_r);
huatu2(line_top.visual(-0.1,0.1));huatu2(line_bot.visual(-0.1,0.1));
huatu2(uv_yuanxin2);huatu2(uv_yuanxin);
huatu2(line_top_chuizhi.visual(-0.1,0.1));huatu2(line_bot_chuizhi.visual(-0.1,0.1));
huatu2(xyzS1);huatu2(xyzS2) ; 