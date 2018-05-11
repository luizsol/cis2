
--
-- Definition of  fsm_main
--
--      05/11/18 15:06:17
--
--      LeonardoSpectrum Level 3, 2017a.2
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.adk_components.all;

entity fsm_main is
   port (
      clk : IN std_logic ;
      res : IN std_logic ;
      cnt_rdy : IN std_logic ;
      cmp_food_flag : IN std_logic ;
      fsm_i_done : IN std_logic ;
      fsm_f_done : IN std_logic ;
      fsm_s_done : IN std_logic ;
      fsm_s_game_over : IN std_logic ;
      con_sel : OUT std_logic_vector (1 DOWNTO 0) ;
      fsm_i_start : OUT std_logic ;
      fsm_f_start : OUT std_logic ;
      fsm_s_start : OUT std_logic) ;
end fsm_main ;

architecture arch of fsm_main is
   signal fsm_s_start_EXMPLR, fsm_f_start_EXMPLR, fsm_i_start_EXMPLR, nx4,
      nx12, nx16, nx274, nx28, STATE_2, nx34, nx38, nx42, nx50, nx64, nx82,
      nx284, nx288, nx292, nx295, nx298, nx300, nx302, nx304, nx307, nx310,
      nx312, nx315, nx317, nx321, nx323, nx326: std_logic ;

begin
   con_sel(0) <= fsm_f_start_EXMPLR ;
   fsm_i_start <= fsm_i_start_EXMPLR ;
   fsm_f_start <= fsm_f_start_EXMPLR ;
   fsm_s_start <= fsm_s_start_EXMPLR ;
   ix95 : nor02_2x port map ( Y=>con_sel(1), A0=>fsm_f_start_EXMPLR, A1=>
      fsm_i_start_EXMPLR);
   ix83 : nand02 port map ( Y=>nx82, A0=>nx284, A1=>nx317);
   ix285 : nand04 port map ( Y=>nx284, A0=>cmp_food_flag, A1=>
      fsm_s_start_EXMPLR, A2=>nx302, A3=>nx315);
   ix65 : nand02 port map ( Y=>nx64, A0=>nx288, A1=>nx312);
   ix289 : nand03 port map ( Y=>nx288, A0=>STATE_2, A1=>cnt_rdy, A2=>nx302);
   ix51 : nand02 port map ( Y=>nx50, A0=>nx292, A1=>nx304);
   ix293 : oai21 port map ( Y=>nx292, A0=>nx42, A1=>nx38, B0=>nx302);
   ix43 : nor02_2x port map ( Y=>nx42, A0=>cnt_rdy, A1=>nx295);
   reg_STATE_2 : dff port map ( Q=>STATE_2, QB=>nx295, D=>nx50, CLK=>clk);
   ix39 : nor02_2x port map ( Y=>nx38, A0=>nx298, A1=>nx300);
   ix299 : inv01 port map ( Y=>nx298, A=>fsm_f_done);
   reg_STATE_1 : dff port map ( Q=>fsm_f_start_EXMPLR, QB=>nx300, D=>nx82,
      CLK=>clk);
   ix303 : inv01 port map ( Y=>nx302, A=>res);
   ix305 : nand02 port map ( Y=>nx304, A0=>nx274, A1=>nx34);
   ix79 : nor03_2x port map ( Y=>nx274, A0=>nx307, A1=>res, A2=>
      fsm_s_game_over);
   reg_STATE_3 : dff port map ( Q=>fsm_s_start_EXMPLR, QB=>nx307, D=>nx64,
      CLK=>clk);
   ix35 : nor02_2x port map ( Y=>nx34, A0=>cmp_food_flag, A1=>nx310);
   ix311 : inv01 port map ( Y=>nx310, A=>fsm_s_done);
   ix313 : nand02 port map ( Y=>nx312, A0=>nx274, A1=>nx28);
   ix29 : nor02_2x port map ( Y=>nx28, A0=>cmp_food_flag, A1=>fsm_s_done);
   ix316 : inv01 port map ( Y=>nx315, A=>fsm_s_game_over);
   ix318 : oai21 port map ( Y=>nx317, A0=>nx16, A1=>nx12, B0=>nx302);
   ix17 : nor02_2x port map ( Y=>nx16, A0=>fsm_f_done, A1=>nx300);
   ix13 : nor02_2x port map ( Y=>nx12, A0=>nx321, A1=>nx323);
   ix322 : inv01 port map ( Y=>nx321, A=>fsm_i_done);
   ix5 : nand02 port map ( Y=>nx4, A0=>nx326, A1=>nx302);
   ix327 : nand02 port map ( Y=>nx326, A0=>nx321, A1=>fsm_i_start_EXMPLR);
   reg_STATE_0 : dff port map ( Q=>fsm_i_start_EXMPLR, QB=>nx323, D=>nx4,
      CLK=>clk);
end arch ;

