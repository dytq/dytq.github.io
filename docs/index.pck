GDPC                                                                               <   res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex�      �      &�y���ڞu;>��.p   res://default_env.tres  �      �       um�`�N��<*ỳ�8   res://icon.png  �1      �      G1?��z�c��vN��   res://icon.png.import   p
      �      ��fe��6�B��^ U�   res://project.binary�>      �      �91d�bC1�����   res://scenes/MainPage.tscn         a      �y�ZE;��13D�U�P;   res://scenes/Page.tscn  �      E      ��ͤ#�X2m�E�^    res://scripts/Camera2D.gd.remap 1      +       {����s�c {��X��   res://scripts/Camera2D.gdc  �*            4�&]Ф#�)��\p    res://scripts/MainPage.gd.remap @1      +       &�;�sĠH�`�+�v<   res://scripts/MainPage.gdc   ,      {      ���p���"�0�TG"h   res://scripts/Page.gd.remap p1      '       Ҕ����p(>�җ�   res://scripts/Page.gdc  �/            yyC���GS!Ƽ���    res://widget/ButtonMainMenu.tscn�0      z       ���jq3�����6[gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
             GDST@   @            �  WEBPRIFF�  WEBPVP8L�  /?����m��������_"�0@��^�"�v��s�}� �W��<f��Yn#I������wO���M`ҋ���N��m:�
��{-�4b7DԧQ��A �B�P��*B��v��
Q�-����^R�D���!(����T�B�*�*���%E["��M�\͆B�@�U$R�l)���{�B���@%P����g*Ųs�TP��a��dD
�6�9�UR�s����1ʲ�X�!�Ha�ߛ�$��N����i�a΁}c Rm��1��Q�c���fdB�5������J˚>>���s1��}����>����Y��?�TEDױ���s���\�T���4D����]ׯ�(aD��Ѓ!�a'\�G(��$+c$�|'�>����/B��c�v��_oH���9(l�fH������8��vV�m�^�|�m۶m�����q���k2�='���:_>��������á����-wӷU�x�˹�fa���������ӭ�M���SƷ7������|��v��v���m�d���ŝ,��L��Y��ݛ�X�\֣� ���{�#3���
�6������t`�
��t�4O��ǎ%����u[B�����O̲H��o߾��$���f���� �H��\��� �kߡ}�~$�f���N\�[�=�'��Nr:a���si����(9Lΰ���=����q-��W��LL%ɩ	��V����R)�=jM����d`�ԙHT�c���'ʦI��DD�R��C׶�&����|t Sw�|WV&�^��bt5WW,v�Ş�qf���+���Jf�t�s�-BG�t�"&�Ɗ����׵�Ջ�KL�2)gD� ���� NEƋ�R;k?.{L�$�y���{'��`��ٟ��i��{z�5��i������c���Z^�
h�+U�mC��b��J��uE�c�����h��}{�����i�'�9r�����ߨ򅿿��hR�Mt�Rb���C�DI��iZ�6i"�DN�3���J�zڷ#oL����Q �W��D@!'��;�� D*�K�J�%"�0�����pZԉO�A��b%�l�#��$A�W�A�*^i�$�%a��rvU5A�ɺ�'a<��&�DQ��r6ƈZC_B)�N�N(�����(z��y�&H�ض^��1Z4*,RQjԫ׶c����yq��4���?�R�����0�6f2Il9j��ZK�4���է�0؍è�ӈ�Uq�3�=[vQ�d$���±eϘA�����R�^��=%:�G�v��)�ǖ/��RcO���z .�ߺ��S&Q����o,X�`�����|��s�<3Z��lns'���vw���Y��>V����G�nuk:��5�U.�v��|����W���Z���4�@U3U�������|�r�?;�
         [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://icon.png"
dest_files=[ "res://.import/icon.png-487276ed1e3a0c39cad0279d744ee560.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
              [gd_scene load_steps=3 format=2]

[ext_resource path="res://scripts/MainPage.gd" type="Script" id=1]
[ext_resource path="res://scripts/Camera2D.gd" type="Script" id=2]

[node name="Control" type="Control"]
script = ExtResource( 1 )

[node name="Camera2D" type="Camera2D" parent="."]
anchor_mode = 0
current = true
script = ExtResource( 2 )

[node name="BackGround" type="Node" parent="."]

[node name="ColorRect" type="ColorRect" parent="BackGround"]
margin_right = 1920.0
margin_bottom = 1080.0
color = Color( 0, 0, 0, 1 )

[node name="ViewportContainer" type="ViewportContainer" parent="."]
margin_left = 1920.0
margin_right = 3900.0
margin_bottom = 1080.0

[node name="Viewport" type="Viewport" parent="ViewportContainer"]
size = Vector2( 1920, 1080 )
handle_input_locally = false
render_target_update_mode = 3

[node name="Front" type="Node" parent="."]

[node name="ColorRect" type="ColorRect" parent="Front"]
margin_left = 16.0
margin_top = 16.0
margin_right = 1904.0
margin_bottom = 184.0

[node name="Title" type="Label" parent="Front"]
margin_left = 816.0
margin_top = 32.0
margin_right = 844.0
margin_bottom = 46.0
rect_scale = Vector2( 10, 10 )
custom_colors/font_color = Color( 0, 0, 0, 1 )
custom_colors/font_outline_modulate = Color( 0, 0, 0, 1 )
text = "Title"

[node name="Profils" type="Node" parent="."]

[node name="ColorRect" type="ColorRect" parent="Profils"]
margin_left = 16.0
margin_top = 200.0
margin_right = 952.0
margin_bottom = 1008.0

[node name="Title" type="Label" parent="Profils"]
margin_left = 264.0
margin_top = 208.0
margin_right = 338.0
margin_bottom = 222.0
rect_scale = Vector2( 5, 5 )
custom_colors/font_color = Color( 0, 0, 0, 1 )
custom_colors/font_outline_modulate = Color( 0, 0, 0, 1 )
text = "Description"

[node name="Description" type="Label" parent="Profils"]
margin_left = 40.0
margin_top = 280.0
margin_right = 328.0
margin_bottom = 515.0
rect_scale = Vector2( 3, 3 )
custom_colors/font_color = Color( 0, 0, 0, 1 )
custom_colors/font_outline_modulate = Color( 0, 0, 0, 1 )
text = "xxxxxxxxxxxxx
xxxxxxxxxxxxx
xxxxxxxxxxxxx
xxxxxxxxxxxxx
xxxxxxxxxxxxx
xxxxxxxxxxxxx
xxxxxxxxxxxxx
xxxxxxxxxxxxx"

[node name="ListLink" type="Node" parent="."]

[node name="ColorRect" type="ColorRect" parent="ListLink"]
margin_left = 968.0
margin_top = 200.0
margin_right = 1904.0
margin_bottom = 1008.0

[node name="Title" type="Node" parent="ListLink"]

[node name="ColorRect" type="ColorRect" parent="ListLink/Title"]
margin_left = 984.0
margin_top = 216.0
margin_right = 1888.0
margin_bottom = 328.0
color = Color( 0, 0, 0, 1 )

[node name="Title" type="Label" parent="ListLink/Title"]
margin_left = 1376.0
margin_top = 232.0
margin_right = 1404.0
margin_bottom = 246.0
rect_scale = Vector2( 5, 5 )
text = "Title"

[node name="List" type="Node" parent="ListLink"]

[node name="ScrollContainer" type="ScrollContainer" parent="ListLink/List"]
anchor_left = 0.5
anchor_top = 0.5
anchor_right = 0.5
anchor_bottom = 0.5
margin_left = 24.0
margin_top = -196.0
margin_right = 928.0
margin_bottom = 452.0

[node name="ListLinks" type="VBoxContainer" parent="ListLink/List/ScrollContainer"]
margin_right = 66.0
margin_bottom = 140.0
alignment = 1

[node name="ButtonIA" type="Button" parent="ListLink/List/ScrollContainer/ListLinks"]
margin_right = 66.0
margin_bottom = 20.0
text = "Example"

[node name="ButtonSecu" type="Button" parent="ListLink/List/ScrollContainer/ListLinks"]
margin_top = 24.0
margin_right = 66.0
margin_bottom = 44.0
text = "Example"

[node name="ButtonRAS" type="Button" parent="ListLink/List/ScrollContainer/ListLinks"]
margin_top = 48.0
margin_right = 66.0
margin_bottom = 68.0
text = "Example"

[node name="ButtonData" type="Button" parent="ListLink/List/ScrollContainer/ListLinks"]
margin_top = 72.0
margin_right = 66.0
margin_bottom = 92.0
text = "Example"

[node name="ButtonJeu" type="Button" parent="ListLink/List/ScrollContainer/ListLinks"]
margin_top = 96.0
margin_right = 66.0
margin_bottom = 116.0
text = "Example"

[node name="ButtonJeu2" type="Button" parent="ListLink/List/ScrollContainer/ListLinks"]
margin_top = 120.0
margin_right = 66.0
margin_bottom = 140.0
text = "Example"

[node name="Foot" type="Node" parent="."]

[node name="ColorRect" type="ColorRect" parent="Foot"]
margin_left = 16.0
margin_top = 1024.0
margin_right = 1904.0
margin_bottom = 1064.0

[connection signal="pressed" from="ListLink/List/ScrollContainer/ListLinks/ButtonIA" to="." method="_on_Button_pressed"]
               [gd_scene load_steps=4 format=2]

[ext_resource path="res://widget/ButtonMainMenu.tscn" type="PackedScene" id=1]
[ext_resource path="res://scripts/Page.gd" type="Script" id=2]
[ext_resource path="res://icon.png" type="Texture" id=3]

[node name="PageModel" type="Control"]
anchor_right = 1.0
anchor_bottom = 1.0
script = ExtResource( 2 )

[node name="BackGround" type="Node" parent="."]

[node name="ColorRect" type="ColorRect" parent="BackGround"]
margin_right = 1920.0
margin_bottom = 1080.0
color = Color( 0, 0, 0, 1 )

[node name="Front" type="Node" parent="."]

[node name="ColorRect" type="ColorRect" parent="Front"]
margin_left = 16.0
margin_top = 16.0
margin_right = 1904.0
margin_bottom = 192.0

[node name="Button" parent="Front" instance=ExtResource( 1 )]
margin_left = 40.0
margin_top = 56.0
margin_right = 152.0
margin_bottom = 76.0

[node name="Label" type="Label" parent="Front"]
margin_left = 800.0
margin_top = 40.0
margin_right = 840.0
margin_bottom = 54.0
rect_scale = Vector2( 10, 10 )
custom_colors/font_color = Color( 0, 0, 0, 1 )
custom_colors/font_outline_modulate = Color( 0, 0, 0, 1 )
custom_colors/font_color_shadow = Color( 0, 0, 0, 1 )
text = "Title"

[node name="Body" type="Node" parent="."]

[node name="Description" type="Node" parent="Body"]

[node name="ColorRect1" type="ColorRect" parent="Body/Description"]
margin_left = 16.0
margin_top = 208.0
margin_right = 952.0
margin_bottom = 1000.0
rect_pivot_offset = Vector2( 416, 304 )

[node name="Title" type="Label" parent="Body/Description"]
margin_left = 400.0
margin_top = 216.0
margin_right = 428.0
margin_bottom = 230.0
rect_scale = Vector2( 5, 5 )
custom_colors/font_color = Color( 0, 0, 0, 1 )
custom_colors/font_outline_modulate = Color( 0, 0, 0, 1 )
custom_colors/font_color_shadow = Color( 0, 0, 0, 1 )
text = "Title"

[node name="RichTextLabel" type="RichTextLabel" parent="Body/Description"]
margin_left = 40.0
margin_top = 288.0
margin_right = 262.0
margin_bottom = 462.0
rect_scale = Vector2( 4, 4 )
custom_colors/default_color = Color( 0, 0, 0, 1 )
custom_colors/selection_color = Color( 0, 0, 0, 1 )
custom_colors/font_color_selected = Color( 0, 0, 0, 1 )
custom_colors/font_color_shadow = Color( 0, 0, 0, 1 )
text = "xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx
xxxxxxxxxxxxxx"

[node name="Image" type="Node" parent="Body"]

[node name="ColorRect2" type="ColorRect" parent="Body/Image"]
margin_left = 968.0
margin_top = 208.0
margin_right = 1904.0
margin_bottom = 1000.0
rect_pivot_offset = Vector2( 416, 304 )

[node name="TextureRect" type="TextureRect" parent="Body/Image"]
margin_left = 984.0
margin_top = 224.0
margin_right = 1888.0
margin_bottom = 984.0
texture = ExtResource( 3 )
expand = true

[node name="Bottom" type="Node" parent="."]

[node name="ColorRect" type="ColorRect" parent="Bottom"]
margin_left = 16.0
margin_top = 1016.0
margin_right = 1904.0
margin_bottom = 1064.0

[connection signal="pressed" from="Front/Button" to="." method="_on_Button_pressed"]
           GDSC         	   .      �����ׄ򶶶�   ��������������ض   �������ض���   �������Ŷ���   ����׶��  ffffff�?                   
                        +      ,   	   3YY;�  T�  YY0�  P�  QV�  &P�  T�  QV�  T�  �  P�  RT�  RQ�  Y`               GDSC            �      ������ڶ   �����������Ӷ���   ����������ض   �����϶�   �����������������Ҷ�   ��������������������Ӷ��   �������Ӷ���   ������¶   ����������������Ķ��   �������¶���   ��������Ҷ��   �����ׄ򶶶�   ��������������ض   �������ض���   ϶��   �������������ö�   ζ��   �����������Ҷ���   ���������Ӷ�      res://scenes/Page.tscn            return_to_menu     �                                                             	      
   !      )      -      5      @      J      [      \      b      k      l      r      |      �      3YY;�  �L  PQYY;�  �  YY0�  PQV�  -YY0�  PQV�  &P�  �  QV�  �  PQ�  �  �  T�  PQ�  �  T�  P�  RR�  Q�  W�  �	  T�
  P�  Q�  W�  T�  �  P�  RW�  T�  T�  QYY0�  PQV�  W�  T�  T�  �  YY0�  PQV�  W�  �	  T�  P�  Q�  �  T�  PQY`     GDSC         
         ������ڶ   �������������ö�   �����϶�   �����������������Ҷ�   ����������ڶ      return_to_menu                                                      	      
   3YYB�  YY0�  PQV�  -YY0�  PQV�  �  PQY`             [gd_scene format=2]

[node name="Button" type="Button"]
margin_right = 112.0
margin_bottom = 20.0
text = "Menu Principal"
      [remap]

path="res://scripts/Camera2D.gdc"
     [remap]

path="res://scripts/MainPage.gdc"
     [remap]

path="res://scripts/Page.gdc"
         �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx��ytTU��?�ի%���@ȞY1JZ �iA�i�[P��e��c;�.`Ow+4�>�(}z�EF�Dm�:�h��IHHB�BR!{%�Zߛ?��	U�T�
���:��]~�������-�	Ì�{q*�h$e-
�)��'�d�b(��.�B�6��J�ĩ=;���Cv�j��E~Z��+��CQ�AA�����;�.�	�^P	���ARkUjQ�b�,#;�8�6��P~,� �0�h%*QzE� �"��T��
�=1p:lX�Pd�Y���(:g����kZx ��A���띊3G�Di� !�6����A҆ @�$JkD�$��/�nYE��< Q���<]V�5O!���>2<��f��8�I��8��f:a�|+�/�l9�DEp�-�t]9)C�o��M~�k��tw�r������w��|r�Ξ�	�S�)^� ��c�eg$�vE17ϟ�(�|���Ѧ*����
����^���uD�̴D����h�����R��O�bv�Y����j^�SN֝
������PP���������Y>����&�P��.3+�$��ݷ�����{n����_5c�99�fbסF&�k�mv���bN�T���F���A�9�
(.�'*"��[��c�{ԛmNު8���3�~V� az
�沵�f�sD��&+[���ke3o>r��������T�]����* ���f�~nX�Ȉ���w+�G���F�,U�� D�Դ0赍�!�B�q�c�(
ܱ��f�yT�:��1�� +����C|��-�T��D�M��\|�K�j��<yJ, ����n��1.FZ�d$I0݀8]��Jn_� ���j~����ցV���������1@M�)`F�BM����^x�>
����`��I�˿��wΛ	����W[�����v��E�����u��~��{R�(����3���������y����C��!��nHe�T�Z�����K�P`ǁF´�nH啝���=>id,�>�GW-糓F������m<P8�{o[D����w�Q��=N}�!+�����-�<{[���������w�u�L�����4�����Uc�s��F�륟��c�g�u�s��N��lu���}ן($D��ת8m�Q�V	l�;��(��ڌ���k�
s\��JDIͦOzp��مh����T���IDI���W�Iǧ�X���g��O��a�\:���>����g���%|����i)	�v��]u.�^�:Gk��i)	>��T@k{'	=�������@a�$zZ�;}�󩀒��T�6�Xq&1aWO�,&L�cřT�4P���g[�
p�2��~;� ��Ҭ�29�xri� ��?��)��_��@s[��^�ܴhnɝ4&'
��NanZ4��^Js[ǘ��2���x?Oܷ�$��3�$r����Q��1@�����~��Y�Qܑ�Hjl(}�v�4vSr�iT�1���f������(���A�ᥕ�$� X,�3'�0s����×ƺk~2~'�[�ё�&F�8{2O�y�n�-`^/FPB�?.�N�AO]]�� �n]β[�SR�kN%;>�k��5������]8������=p����Ցh������`}�
�J�8-��ʺ����� �fl˫[8�?E9q�2&������p��<�r�8x� [^݂��2�X��z�V+7N����V@j�A����hl��/+/'5�3�?;9
�(�Ef'Gyҍ���̣�h4RSS� ����������j�Z��jI��x��dE-y�a�X�/�����:��� +k�� �"˖/���+`��],[��UVV4u��P �˻�AA`��)*ZB\\��9lܸ�]{N��礑]6�Hnnqqq-a��Qxy�7�`=8A�Sm&�Q�����u�0hsPz����yJt�[�>�/ޫ�il�����.��ǳ���9��
_
��<s���wT�S������;F����-{k�����T�Z^���z�!t�۰؝^�^*���؝c
���;��7]h^
��PA��+@��gA*+�K��ˌ�)S�1��(Ե��ǯ�h����õ�M�`��p�cC�T")�z�j�w��V��@��D��N�^M\����m�zY��C�Ҙ�I����N�Ϭ��{�9�)����o���C���h�����ʆ.��׏(�ҫ���@�Tf%yZt���wg�4s�]f�q뗣�ǆi�l�⵲3t��I���O��v;Z�g��l��l��kAJѩU^wj�(��������{���)�9�T���KrE�V!�D���aw���x[�I��tZ�0Y �%E�͹���n�G�P�"5FӨ��M�K�!>R���$�.x����h=gϝ�K&@-F��=}�=�����5���s �CFwa���8��u?_����D#���x:R!5&��_�]���*�O��;�)Ȉ�@�g�����ou�Q�v���J�G�6�P�������7��-���	պ^#�C�S��[]3��1���IY��.Ȉ!6\K�:��?9�Ev��S]�l;��?/� ��5�p�X��f�1�;5�S�ye��Ƅ���,Da�>�� O.�AJL(���pL�C5ij޿hBƾ���ڎ�)s��9$D�p���I��e�,ə�+;?�t��v�p�-��&����	V���x���yuo-G&8->�xt�t������Rv��Y�4ZnT�4P]�HA�4�a�T�ǅ1`u\�,���hZ����S������o翿���{�릨ZRq��Y��fat�[����[z9��4�U�V��Anb$Kg������]������8�M0(WeU�H�\n_��¹�C�F�F�}����8d�N��.��]���u�,%Z�F-���E�'����q�L�\������=H�W'�L{�BP0Z���Y�̞���DE��I�N7���c��S���7�Xm�/`�	�+`����X_��KI��^��F\�aD�����~�+M����ㅤ��	SY��/�.�`���:�9Q�c �38K�j�0Y�D�8����W;ܲ�pTt��6P,� Nǵ��Æ�:(���&�N�/ X��i%�?�_P	�n�F�.^�G�E���鬫>?���"@v�2���A~�aԹ_[P, n��N������_rƢ��    IEND�B`�       ECFG      application/config/name         dytq.github.io     application/run/main_scene$         res://scenes/MainPage.tscn     application/config/icon         res://icon.png     display/window/size/width      �     display/window/size/height      8     display/window/stretch/mode         viewport+   gui/common/drop_mouse_on_gui_input_disabled         )   physics/common/enable_pause_aware_picking         $   rendering/quality/driver/driver_name         GLES2   %   rendering/vram_compression/import_etc         &   rendering/vram_compression/import_etc2          )   rendering/environment/default_environment          res://default_env.tres    