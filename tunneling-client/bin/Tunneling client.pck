GDPC                �                                                                         P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn�      m      �$n��Kп�zԵ�k    P   res://.godot/exported/133200997/export-5af819b3dcd30bb5dc8d4dc3cb87af5b-math.scn0'      �      u���w��4"+��{d�    ,   res://.godot/global_script_class_cache.cfg  @H             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex@
      �      ����W�x�,�7_~       res://.godot/uid_cache.bin  PL      T       [c��o��$�[���(       res://button.gd         �      ����j?�t��xpOTf       res://calcEngine.gd �      K      ^01Ĳ��H3�5���       res://icon.svg  `H      �      �W|��/�\�pF[       res://icon.svg.import         �       �.=̌���yKY�zXL       res://login_button.gd   �      �      �d�*4w'���D       res://main.tscn.remap   `G      a       �J�Sw� ������       res://math.tscn.remap   �G      a       ��'aP���%�Y���       res://networking.gd �:      �      ge��3��+$�5.-       res://player.gd �?      �      �;G��,���S��[�       res://project.binary�L      �      ���V��ɺѩk���y       res://timer_label.gd�D      �      s�����m%�@��[    extends Button

@onready var correctLabel = get_node("../../CorrectLabel")
@onready var resultLabel = get_node("../Result")
var numLabels = [Label, Label, Label, Label]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in 4:
		numLabels[i] = get_node("../Num"+str(i+1)+"Label")
		
	CalcEngine.generateNew()
	resultLabel.set_text(str(CalcEngine.result).pad_decimals(2))
	
	for i in len(numLabels):
		numLabels[i].set_text(str(CalcEngine.numbers[i]))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _pressed() -> void:
	CalcEngine.setPlayerOps()
	if CalcEngine.checkPlayerCorrect():
		correctLabel.set_text("Správně!")
		correctLabel.set("theme_override_colors/font_color",Color(0.0, 1.0, 0.0 ))
	else:
		correctLabel.set_text("Chyba :(")
		correctLabel.set("theme_override_colors/font_color",Color(1.0, 0.0, 0.0 ))
	get_parent().visible = false
 extends Node

var numbers = [0, 0, 0, 0]
var operations = ['+', '+', '+']
var result = 0
var correct = false

var rng = RandomNumberGenerator.new()

var playerOps = ["+","+","+"]

static var maxValue = 12

	
func getExprString(nums, ops) -> String:
	var s = str(nums[0]) + ".0"
	for i in len(ops):
		s = s + str(ops[i]) + str(nums[i+1]) + ".0"
	return s

func getResult(nums, ops) -> float:	#TODO catch zero division
	var expression = Expression.new()
	var exprString = getExprString(nums, ops)
	expression.parse(exprString)
	var out = expression.execute()
	print(exprString)
	return out
	
func generateNew() -> void:
	for i in len(numbers):
		numbers[i] = rng.randi_range(0, maxValue)
		while numbers[i] < 1:
			numbers[i] = rng.randi_range(0, maxValue)
		if i > 0:
			operations[i-1] = randomOp()
	result = getResult(numbers, operations)
			
func randomOp() -> String:
	var rand = rng.randi_range(0, 3)
	match rand:
		0:
			return "+"
		1:
			return "-"
		2:
			return "*"
		3:
			return "/"
		_:
			return "+"
			
func setPlayerOps() -> void:
	var opBtn1 = get_tree().get_root().get_node("Math/Panel/CalculationPanel/OptionButton1")
	var opBtn2 = get_tree().get_root().get_node("Math/Panel/CalculationPanel/OptionButton2")
	var opBtn3 = get_tree().get_root().get_node("Math/Panel/CalculationPanel/OptionButton3")
	
	var op1 = opBtn1.get_item_text(opBtn1.selected)
	var op2 = opBtn2.get_item_text(opBtn2.selected)
	var op3 = opBtn3.get_item_text(opBtn3.selected)
	playerOps = [op1, op2, op3]

func checkPlayerCorrect() -> bool:
	if getResult(numbers, playerOps) == result:
		return true
	else:
		return false
     GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$I��&�[���Y��7��t@�?�uVc�`
D��F�$)��i�;�U׃;n����$�v�6��Az���>Unk���"�!�Kd��4@J%#2�ln�8�_�d���ڶm��%�#�p6���=�U���vֶm�6⤎��~���z��m�J�}����t�"<�,���`B�m�i-ﾗ�Kz@Q��XA�?��I������7\r2�B+�XUTQ:JW0�7<`��7l0)])��������� �
T� �p�:U� #d�R4�H&�h�H�V��5��~��!j$��,�˰(�t��.ˌvF�c�3���L�	�j"dᨑh;fw˲[�#��n�[�����Z0��sis��8I����E���<�͑�yF��%�*�� I=�<�/a��J�� �˷ɾ�T[*8�[�#����UL�1(ќZ�%Lf��͑�I1b����.V��2#+��W���Yig���H+��eX�2>.�y�0�ț��ސW֛�;0�ꜩYm.22hBs�*��f���ML�YZ)6�-�X��e.xg�=��'U��gO�����߉�D/t��@b�&�F2��S�17�BLk�U����G.��k�)�QVC+��I�2�$D%,�X`�$�|�V=f���w��`6����`�>���F+yd'���Ze.~�0>��*��u�\�,�T���~�XnO���*�{�l4��*�Zi�b��[��phŔ=ky�wbJ�T<�/k1Es��vſc+��F�w�$�&��H��ep��\�^��28g��"�<)H�*��
�}�;�J����aO�k��\ߚ�欒y�@['F5w�TK��L�y��]"/֛�cE��1V�Ey�^eQh%�;!"�9s�J5d7�{ʺf�-4�%�&sA�l��9iF�w"i[n�v�
�����{�^u@���\$	QI/�n�XHYW�*]aO@��Yo�#C+WZ3\^��h.��\M��'k��\4�㎛�<�X�̂+՜r���\6�Uon$9S#sA��=����.sA�'Z#���
F��t�Nde��K._�H��d��?T�׋+w��:w�M�V���ꋱ�ڡ	�2A>�߃�����X1�/[�s�Њe�YD+���
_h��V"
�S�Npe��qu�rx�_����J,��zm�NYMrZ�j,��t�6���U�1>Ξ�����bN�k2�G�SU�Yqo3����/@��/�K_���/g~�TcgP Ξ��͈�"��JA4��V� ��ۈs�+����f}�E�:O~��ETK�Ol'�#ZKtP�|���p?y�LU����J\��A ���*����\����pAl$��V�I��}�=�P%��1�DFbUlį�Zq�{}	@��ױ���E?�#|����k�E{��������}��������o@�� ����1�90.Dpf��!���/� �6
�;)&�8�H	0����D̅m,��q�l����^ �<O��.lb���+�����N-S�M� ��Ziw|�� Z
b�ob����`wPi7��&bH�7,EP&n�_����EL��*$�]��M}� �D�;D�쏪$'Ĺs}/����,ď�ؽ���ї +�Z)1�t���ܫV���HM�7;�A��3�ʂ�(Z����YE4JD��u�'0��n�Klu'A�AtA���w f�t24��ճ�_&�'`Q<���I<��0� �k��f������ ,��� ��z�П�0ܤ˱J�?�,@ ��ס��t�����G�&��_�e��>�.�O��J��.F�䛽+^�K:􅦔����L�[��3=4lK�m3�vG���ӯ�2��}�5G��V�L����:�zm94�Ot�>k��;����~�$b$N�y�nvu�X��[� ���^��u��<�:ê��D��D�?�|=�Pe�u�|�yY��ޗ���"���֠�Vk��'��(���_������H Ub�o���g���PE'�V�L_���o�e�}����a*Dm/�^���<|�$�yU�`�o��\���w�wD���GJ��^�;;<l���S��J,�%�卍���s1�	�!�����C���/�����j,O-��b�k:[�-�¦���Y'��a�\���x���l���(����L��a��q��E`�O6~1�9�L�d��{m+2�J���t,\��Yd$�,����a�(���X��-S�,�sb�E��o�?B7�B��6�͍􉖔(��X���m�wЈ�P��v��5jwP���aY�o��6�_'8[ҟ`��L %���8���=+��N﫱<�JO�]A��v���/��I��.n�6k�t����}f����n�~���_<Γo�*�f����[ʺ�UH� Zr}/0�����*�ˆ7�E!߸K-��4�������<������eU+�������?.O���u}/�_ϋ������2�:�����^�15�:�<*�_��������� y]ߋ���"=0.v�Mߠk�F�1l�7�u�;G�H���H�Y��|�6�[rx���Рϕ���v�J��R_i��PI]�~��ѝ~�y�%�|}x�������i;|����ks<������V����g���=��?����ޞO����x�������7��x����Q_�x��w�#�$~ϙ�~�[�Ǵ_⢠�XЏ�BahmWE��:�����[u:���yk��tA�<�'\�.
�fa�m��֕jv�𳊦F��y���?n���l�T�<�����veaح1V�O��5�Z�����8[U�=r����̜�s�~�=y�Mß�Y(��rg����y�aYf���5�E���Up��eYD��yܮLږ��&e�$Fuܮ�>��˲�"q���JUy�l��l�1팬�3"p�eFV�F7.���.Y9�b`��L�eeR�����얓e7��t�t���v��dw���Q�QE�{�KF�s�T[*����I�|�w�d`/�RQDE?/A�λ�K����K�D:��@�L��q.��j�%�
�  �Y�9�n�f$f5�F:2�Bb�C���.���vƼ�ˤ ^K��D\2��=� ���K��r�S��l�^���:T$&AJ�pd�R-���X��2�ӯ ��.��n\��>����k����,��.� [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bt1ekugmk1x8"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 extends Button
var password
var id
var err = false
var time = 0


@onready var passBox = get_node("../LoginInputContainer/PassBox")
@onready var idBox = get_node("../LoginInputContainer/IDBox")
@onready var errLabel = get_node("../ErrLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if errLabel.get_text() != "":
		time = time + delta
	if time > 2:
		errLabel.set_text("")
		time = 0
		err = false

func _pressed() -> void:
	password = passBox.get_text()
	id = int(idBox.get_text())
	Player.login(id, password)
	
      RSRC                    PackedScene            ��������                                            "      resource_local_to_scene    resource_name    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size    script    default_base_scale    default_font    default_font_size 	   _bundled       Script    res://login_button.gd ��������      local://StyleBoxFlat_0eavi �         local://Theme_nikc8 +         local://Theme_ppiux A         local://PackedScene_g5p0w W         StyleBoxFlat          ���=��H?��v?  �?         Theme             Theme             PackedScene    !      	         names "   #      LoginScreen    layout_mode    anchors_preset    anchor_right    anchor_bottom    offset_left    offset_right    grow_horizontal    grow_vertical    Control    Background    theme_override_styles/panel    Panel    LoginContainer    anchor_left    anchor_top    offset_top    offset_bottom    LoginButton    theme    script    Button    Label    text    horizontal_alignment    vertical_alignment    LoginInputContainer    VBoxContainer    IDBox    placeholder_text 	   LineEdit    PassBox 	   ErrLabel !   theme_override_colors/font_color $   theme_override_font_sizes/font_size    	   variants    !                    �?     ��                                  ?     ��     ��     �C     �B     `B     ��     �C     �A                         LOGIN            $B      �     �C     PB      ID       Heslo            @�                     �?          �?            node_count    	         nodes     �   ��������	       ����                                                                   
   ����	                                                                          ����                                          	      
                                            ����                                                                                                        ����	                                                                          ����	                                                                          ����                                ����                                 ����                                                         !      "                             conn_count              conns               node_paths              editable_instances              version             RSRC   RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size    script 	   _bundled       Script    res://timer_label.gd ��������   Script    res://button.gd ��������      local://StyleBoxFlat_apjpt �         local://StyleBoxFlat_140jx !         local://StyleBoxFlat_mmat5 V         local://PackedScene_mmxo5 �         StyleBoxFlat          ���>���>���>  �?         StyleBoxFlat          ���>���>���>  �?         StyleBoxFlat          ��(>��0>��8>  �?         PackedScene          	         names "   3      Math    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    Control    Panel    theme_override_styles/panel    CorrectLabel    offset_left    offset_top    offset_right    offset_bottom $   theme_override_font_sizes/font_size    text    horizontal_alignment    vertical_alignment    Label    IDLabel !   theme_override_colors/font_color    theme_override_styles/normal 
   TimeLabel    TimerLabel    script    CalculationPanel    OptionButton1 
   alignment    icon_alignment    expand_icon    item_count    popup/item_0/text    popup/item_0/id    popup/item_1/text    popup/item_1/id    popup/item_2/text    popup/item_2/id    popup/item_3/text    popup/item_3/id    OptionButton    OptionButton2    OptionButton3 
   Num1Label 
   Num2Label 
   Num3Label 
   Num4Label    Result    EqualsButton    Button    Equals    	   variants    P                    �?                                 �HD    �5D    ��D    ��D   �         :)    
        C     �A     '�    �D   ���=��H?��v?  �?   h                 NUM      �B    �D    � E    @FD   ���>  �?  �?  �?   �         1/10 17:00     `�D     oC     �D   ��V?          �?   �         99                LB    ��D    @�D              sC     �B    ��C     IC   2                     +       -       *       /      D     6D    �zD     WC    ��C   ��?��?��?  �?      88     ��C    �D   �`?�`?�`?  �?    �;D    �qD    @�D     �D    �D    �E   s� >��>��>  �?      1234.56     ��D     �B    ��D     ZC              �A     4�     �B      C   K9�>j��>'��>  �?      =       node_count             nodes     �  ��������       ����                                                          ����                                       	                    
   ����	                        	      
                                            ����                                                                                                        ����
                                                                                ����
                                     !      "                  #                    ����            $            %      &   	   '              (      ����            (      )      *      +      ,                  -      .       /   !      "   0   #      $   1   %      &   2   '                  (   )   ����            3      )      4      +      ,                  -      .       /   !      "   0   #      $   1   %      &   2   '                  (   *   ����            5      )      
      +      ,                  -      .       /   !      "   0   #      $   1   %      &   2   '                     +   ����            6      7      8            9                             ,   ����	            :      ;      7      <            9                             -   ����	            =      >      7      8            9                             .   ����	            ?      @      7      8            9                             /   ����            A      B      7      C            D                    1   0   ����            E      F      G      H      I                 2   ����
            J      K      L      M      N            O                         conn_count              conns               node_paths              editable_instances              version             RSRC           extends Node

var address = "192.168.0.105:8080"
var http_request
var login_request
func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	login_request = HTTPRequest.new()
	add_child(login_request)
	login_request.request_completed.connect(loginPlayer)

func sendLoginRequest(id, password):
	var body = JSON.new().stringify({
 	"user_id": id,
 	"password": password,
	})
	var adr = "http://"+address + "/api/user/login.php"
	print(adr)
	print(body)
	login_request.request(adr, [], HTTPClient.METHOD_POST, body)

func print_err(code:int):
	var ErrLabel = get_tree().get_root().get_node("LoginScreen/Background/LoginContainer/ErrLabel")
	if code == 403:
		ErrLabel.set_text("Špatné ID nebo heslo!")
	elif code == 405:
		ErrLabel.set_text("TBS našla tvůj tunel! Zkus to později.")
		
func loginPlayer(_result, response_code, _headers, _body):
	print(response_code)
	if response_code == 200:
		
		Player.login_success()
		
	else: print_err(response_code)
		
func sendResult(id: int, password: String, success: bool) -> void:
	var body = JSON.new().stringify({
 	"user_id": id,
 	"password": password,
	"success": str(success)
	})
	print(body)
	
	http_request.request("http://"+address + "/api/game/insert.php", [], HTTPClient.METHOD_POST, body)
              extends Node

var firstName = ""
var lastName = ""
var id = -1
var password = ""
var loggedIn = false

var timeLimit = 60
var time = timeLimit
var timerLabel
var timerReady
var Networking
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Networking = get_node("/root/Networking")
	print(Networking.name)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if loggedIn and timerReady:
		time = time - delta
		timerLabel.set_text(str(int(time)))
		if time<0:
			logout()

func login(ID: int, passWord: String):
	id = ID
	password = passWord
		
	Networking.sendLoginRequest(ID, passWord)
	CalcEngine.generateNew()

func login_success():
		get_tree().change_scene_to_file("res://math.tscn")
		time = timeLimit
		loggedIn = true
	
func logout() -> void:
	loggedIn = false
	timerReady = false
	sendResult()
	get_tree().change_scene_to_file("res://main.tscn")
	
func sendResult() -> void:
	var success = CalcEngine.checkPlayerCorrect()
	Networking.sendResult(id, password, success)
		
func _setTimerReady() -> void:
	timerReady = true
	timerLabel = get_tree().get_root().get_node("Math/Panel/TimerLabel")
             extends Label

@onready var nameLabel = get_node("../IDLabel")
@onready var timeLabel = get_node("../TimeLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Player._setTimerReady()
	
	nameLabel.set_text(str(Player.id))
	
	var timeDict = Time.get_datetime_dict_from_system()
	var minute = ""
	if timeDict["minute"] < 10:
		minute = "0" + str(timeDict["minute"])
	else: minute = str(timeDict["minute"])
	var timeStr = str(timeDict["day"]) + "/" + str(timeDict["month"]) + "   " +str(timeDict["hour"]) + ":" + minute
	timeLabel.set_text(timeStr)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
            [remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
               [remap]

path="res://.godot/exported/133200997/export-5af819b3dcd30bb5dc8d4dc3cb87af5b-math.scn"
               list=Array[Dictionary]([])
     <svg xmlns="http://www.w3.org/2000/svg" width="128" height="128"><rect width="124" height="124" x="2" y="2" fill="#363d52" stroke="#212532" stroke-width="4" rx="14"/><g fill="#fff" transform="translate(12.322 12.322)scale(.101)"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042" transform="translate(12.322 12.322)scale(.101)"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></svg>                 g��'lX�   res://icon.svg��*7�l.	   res://main.tscn��V,#Y   res://math.tscn            ECFG      application/config/name         Tunneling client   application/run/main_scene         res://main.tscn    application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     autoload/Player         *res://player.gd   autoload/CalcEngine         *res://calcEngine.gd   autoload/Networking         *res://networking.gd"   display/window/size/viewport_width      p  #   display/window/size/viewport_height      �     display/window/size/mode            display/window/stretch/mode         viewport   display/window/stretch/aspect         expand     dotnet/project/assembly_name         Tunneling client           