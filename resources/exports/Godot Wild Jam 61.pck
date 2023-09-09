GDPC                @	                                                                         \   res://.godot/exported/133200997/export-06633fdef9cfd93aa6de8bfde056a1af-SimpleLicense.res   @0     �      `��O��2��E�^Kx    X   res://.godot/exported/133200997/export-519f25f0647bff362aaec36756b0d6fe-LicenseGUI.scn  �=      (      ��C1�~0$����o    X   res://.godot/exported/133200997/export-57541083bd4f9efeb254d7f28843258b-test_scene.scn  p-     �      *�R{V�j���]��?W    `   res://.godot/exported/133200997/export-cab212ca14e0231956191525e5cfcf33-mod_1_license_link.res  �I      �      -uS�Ue�� �,M4�    ,   res://.godot/global_script_class_cache.cfg  @B     �      .X���&ĝ��U�Һ��    D   res://.godot/imported/Icon.png-451064bd72ea26ed7eb00aedd926556f.ctex�L      �P      �)�F��-�di$��    D   res://.godot/imported/Icon.svg-62b5bc5b7872f9c089f3b98f0084a03c.ctex��      <�      �q5=N��V�|    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�2     �      �Yz=������������       res://.godot/uid_cache.bin  �G           J�%�f�V�¶��2�7    ,   res://addons/simplelicense/GUI/LicenseGUI.gd .      �      �v���jE��퀸)    4   res://addons/simplelicense/GUI/LicenseGUI.tscn.remap�@     g       �ӽKʀ�\��VGq�    ,   res://addons/simplelicense/Icon.png.import  Н      �       ϗ}���?lPWN�`Z�    ,   res://addons/simplelicense/Icon.svg.import  �+     �       ��m�2`�$�u=h�m�    ,   res://addons/simplelicense/api/License.gd           �      f�9m��������m    0   res://addons/simplelicense/api/LicenseLink.gd   �      �      ��D@��T}�ʜجٯ    0   res://addons/simplelicense/api/LicenseManager.gd0      �      �4RtX�}��4#<?>�    \   res://addons/simplelicense/mod_example/licenses/license_links/mod_1_license_link.tres.remap �@     o       p��U�?9�Ba2/    0   res://addons/simplelicense/mod_example/mod_1.gd �L             ;��/ѳk\��R"
    $   res://addons/simplelicense/plugin.gd�,     �       mc匫=ɞ�5�1D�        res://code/test_scene.tscn.remap`A     g       �//�r�z��_b���[       res://icon.svg  D     �      C��=U���^Qu��U3       res://icon.svg.import   �?     �       k���Ω��D�2tH       res://project.binary�J     �      ���m���$���X    @   res://resources/licenses/license_links/SimpleLicense.tres.remap �A     j       �@d�0,�Nf,���    �m$���t�-class_name License
extends Resource
## Holds AUTO GENERATED License information

## SPDX-License-Identifier or similar to it.  CASE SENSITIVE[br]
## Like "CC0-1.0"[br]
## See [url=https://spdx.org/licenses/]SPDX Identifier List[/url]
var identifier: String = ""

## The License's Name. [br]
## Like "CC0 1.0 Universal"
var name: String = ""

## License Terms; The text of a license file
var terms: String = ""

## Returns a string containing this license's information, formatted to [url=https://spdx.dev/resources/use/]SPDX Standards[/url]
func to_formatted_string() -> String:
	return "License: {identifier}\n{terms}".format({
		'identifier': identifier,
		'terms': _add_line_padding(terms)
		})


# wouldn't recomend using this, unless you know what your doing
# but if you do, this loads and parses all licenses (.txt files) in a directory, 
# plus Godot's built-in Licenses
static func _load_licenses_in(dir: String):
	var dict = {}
	
	# get game licenses
	var names = DirAccess.get_files_at(dir)
	if names.size() == 0:
		print_verbose("\nSimple License: No License files found in dir\n", dir, "\nif you have no license files there, then this can be ignored\n")
	for _name in names:
		var ext = _name.rsplit('.', false, 1)
		if ext.size() == 0 or ext[-1] != 'txt':
			continue
		
		var l = new()
		l.identifier = _name.split('.', false, 1)[0]
		l.name = l.identifier
		l.terms = FileAccess.open(dir.path_join(_name), FileAccess.READ).get_as_text()
		dict[l.identifier] = l
	
	# get licenses built into the Godot Engine
	var tmp = Engine.get_license_info()
	for id in tmp:
		if dict.has(id):
			continue
		
		var l = new()
		l.identifier = id
		l.terms = tmp[id]
		dict[id] = l
	
	return dict


# this is for formatting individual lines accoring to SPDX standards
static func _add_line_padding(combined_lines: String, padding: String = " ") -> String:
	if combined_lines.is_empty():
		return combined_lines
	
	var lines = combined_lines.split("\n")
		
	var s = ""
	for i in len(lines):
		if lines[i].is_empty() or lines[i] == "\n":
			if i+1 < len(lines):
				s += padding + "." + "\n"
			else:
				s += '\n'
		else:
			s += padding + lines[i] + "\n"
	s = s.strip_edges(false)
	s += '\n'
	return s
]جa_�class_name LicenseLink
extends Resource

## Files that are under this license [br]
## [color=red]WARNING[/color] DO NOT put in any file that Godot Cannot load, via Resource.load() [br]
## or it will prevent the game from launching. files like .txt .csg etc
@export var link_files: Array[Resource]

## Directories that are under this license [br]
## The given file's Parent Directory will be tracked [br]
## [color=red]WARNING[/color] DO NOT put in any file that Godot Cannot load, via Resource.load()  [br]
## or it will prevent the game from launching. files like .txt .csg etc
@export var link_dirs: Array[Resource]

## Files that are under this license [br]
## Note: These paths are [b]NOT[/b] automatically tracked, [br]
## you will have to, manually keep these paths up to date 
@export var link_paths: Array

## Example: Godot_Icon, Custom Font Name, Your Games Name, etc
@export var componet_name: String = ""

## Gets included in [method to_formatted_string] right after [member componet_name] [br]
## as part of the "Comment:" Section of the SPDX format
@export var extra: String = ""

## SPDX-License-Identifier or similar to it.  CASE SENSITIVE[br]
## Like "CC0-1.0" or more complex entries like [br]
## "CC0-1.0 or MIT" [br]
## "CC0-1.0 and MIT" [br]
## See [url=https://spdx.org/licenses/]SPDX Identifier List[/url]
@export var license_identifier: String = "" : set = _set_identifier

## who and when was the copyright was created [br]
## example [br]
## 2022, John Doe [br]
## (next entry) [br]
## 2022-2023, Jim Stirling, Corp xyz [br]
@export var copyright: Array[String]

var license: License

## Unlike [member license_identifier] this contains [b]ONLY[/b] the identifiers [br]
var license_identifiers: Array[String]

## Either "Godot Engine" or "Game" [br]
## This value is AUTO GENERATED [br]
## [b]DON'T SET THIS VALUE MANUALLY[/b], IT CAN BREAK THINGS
var component_of: String = ""


func _init() -> void:
	_set_identifier(license_identifier)


func _set_identifier(v: String):
	license_identifier = v
	
	var tmp = v.replace(' and ', '!break!').replace(' or ', '!break!').split('!break!', false)
	for x in tmp:
		license_identifiers.append(x)


func _to_string() -> String:
	return self.to_formatted_string()

## Returns a string containing this link's information, formatted to [url=https://spdx.dev/resources/use/]SPDX Standards[/url]
func to_formatted_string(hide_files: bool = false):
	var _files = ""
	if not hide_files:
		for x in link_files:
			_files += x.resource_path.replace("res://", " ./").strip_edges() + "\n"
		for x in link_dirs:
			_files += (
				x.resource_path.replace("res://", " ./").rsplit("/", false, 1)[0].strip_edges()
				+ "/*\n"
			)
		for x in link_paths:
			_files += x.replace("res://", " ./").strip_edges() + "\n"
	_files = _files.strip_edges()

	var _comment = ""
	if not componet_name.is_empty():
		_comment += componet_name
		if not extra.is_empty():
			_comment += "\n"
	if not extra.is_empty():
		_comment += extra

	return "Files:{files}\nComment:{comment}\nCopyright:{copyright}\nLicense:{identifier}\n".format(
		{
			"files": _add_line_padding(_files, " "),
			"comment": _add_line_padding(_comment, " "),
			"copyright": _add_line_padding("\n".join(copyright), " "),
			"identifier": _add_line_padding(license_identifier, " "),
		}
	)


# wouldn't recomend using this, unless you know what your doing
# but if you do, this loads and parses all links (LicenseLink Resource files) in a directory, 
# plus Godot's built-in Licenses
#
# exclude engine: excludes loading Godot's built-in license information
# this is for mods, in which the main game will have already shown the Godot Engine's Licensing
static func _load_links_in(dir: String, exclude_engine: bool = false):
	var dict = {
		'array': [],
		'by_identifier': {},
		'by_parent': {},
	}
	
	if not DirAccess.dir_exists_absolute(dir):
		printerr('Simple License: LicenseLinks directory is missing! ', dir)
		return dict
	
	
	# get Game license links
	var names = DirAccess.get_files_at(dir)
	if len(names) == 0:
		print_verbose("\nSimple License: No LicenseLinks found in dir\n", dir, "\nif you have no LicenseLinks there, then this can be ignored\n")
	for name in names:
		name = name.replace('.remap', '')
		var path = dir.path_join(name)
		var res = ResourceLoader.load(path)
		if res is Resource and res.get("copyright") != null:
			if res.component_of.is_empty():
				res.component_of = "Game"
			
			dict.array.append(res)
			
			dict.by_identifier[res.license_identifier] = res
			
			if not dict.by_parent.has(res.component_of):
				dict.by_parent[res.component_of] = {}
			dict.by_parent[res.component_of][res.componet_name] = res
	
	# Get Engine license links
	if not exclude_engine:
		for a in Engine.get_copyright_info():
			var l = new()
			l.componet_name = a.name
			l.component_of = "Godot Engine"
			l.link_paths = a.parts[0].files
			
			l.license_identifier = a.parts[0].license
			l.copyright.append_array(a.parts[0].copyright)
			
			dict.array.append(l)
			
			dict.by_identifier[l.license_identifier] = l
			
			if not dict.by_parent.has(l.component_of):
				dict.by_parent[l.component_of] = {}
			
			if not dict.by_parent[l.component_of].has(l.license_identifier):
				dict.by_parent[l.component_of][l.componet_name] = l
	
	return dict

# this is for formatting individual lines accoring to SPDX standards
static func _add_line_padding(combined_lines: String, padding: String) -> String:
	if combined_lines.is_empty():
		return combined_lines
	
	var lines = combined_lines.split("\n")
		
	var s = ""
	for i in len(lines):
		if lines[i].is_empty() or lines[i] == "\n":
			if i+1 < len(lines):
				s += padding + "." + "\n"
			else:
				s += '\n'
		else:
			s += padding + lines[i] + "\n"
	s = s.strip_edges(false)
	return s
A*|��?��class_name LicenseManager
extends Node

## loads license information from this directory and the sub-directory "license_links"
@export var load_dir: String = "res://resources/licenses"

## export license information to this directory and the sub-directory "licenses"
@export var export_dir: String = "user://"

## This disables loading Godot's built-in license information [br]
## this is for mods, in which the main game will have already shown the Godot's built-in Licensing
@export var exclude_engine: bool = false

## contains all loaded [License]s [br]
## key = identifier [br]
## value = [License]
var licenses := {} 

## contains all loaded [LicenseLink]s [br]
## with searching in mind [br]
## "array" [] [br]
## "by_identifier" {} license identifier [br]
## "by_parent" {} parent component name [br]
var license_links := {
	'array': [],
	'by_identifier': {},
	'by_parent': {},
}


## Loads license information from [member load_dir] [br]
func load_license_information():
	licenses.clear()
	license_links.array.clear()
	license_links.by_identifier.clear()
	license_links.by_parent.clear()
	
	if not DirAccess.dir_exists_absolute(load_dir):
		printerr("Failed to find license directory ", load_dir)
		return
	
	licenses = License._load_licenses_in(load_dir)
	if licenses.has('Expat') and not licenses.has('MIT'):
		var l = licenses['Expat'].duplicate() as License
		l.identifier = 'MIT'
		licenses['MIT'] = l
	
	license_links = LicenseLink._load_links_in(load_dir.path_join('license_links'), exclude_engine)


## Returns a single string "file", that is formatted in the SPDX Standard [br]
## that contains all licensing information, contained in this instance, [br]
## if only_links, then the returned data will omit the licensing term files
func get_combined_copyright(only_links: bool = false) -> String:
	var lines = ""
	
	var used_licenses = {}
	
	# Links
	for link in license_links.array:
		if link is LicenseLink:
			lines += link.to_formatted_string(link.component_of == 'Godot Engine')
			lines += '\n'
			used_licenses.merge(get_all_valid_licenses(link))
	
	lines += '\n\n'
	
	if only_links:
		return lines
	
	# License Terms
	var values = used_licenses.values()
	for i in len(values):
		if i+1 < len(values):
			lines += values[i].to_formatted_string() + '\n'
		else:
			lines += values[i].to_formatted_string()

	return lines

## Returns all licenses that are "valid"/exist [br]
## Sometimes license files are missing, or Identifiers are incorrectly spelled, this helps with that.
func get_all_valid_licenses(link: LicenseLink) -> Dictionary:
	var d = {}
	for x in link.license_identifiers:
		if licenses.has(x):
			d[x] = licenses[x]
	return d

## export all license information to [member export_dir] and the sub-directory "licenses"
func export(directory: String = ""):
	if directory.is_empty():
		directory = export_dir
	
	var licenses_path = directory.path_join('licenses')
	if not DirAccess.dir_exists_absolute(licenses_path):
		DirAccess.make_dir_recursive_absolute(licenses_path)
	
	# Export the combined license file
	var f = FileAccess.open(directory.path_join('COPYRIGHT.txt'), FileAccess.WRITE)
	if f is FileAccess:
		f.store_string(self.get_combined_copyright())
	
	# Export the slim license file
	f = FileAccess.open(directory.path_join('COPYRIGHT_SLIM.txt'), FileAccess.WRITE)
	if f is FileAccess:
		f.store_string(self.get_combined_copyright(true))
	
	
	# Export the individual license files
	
	var used = {}
	for i in license_links.array.size():
		var license = license_links.array[i] as LicenseLink
		var ids = self.get_all_valid_licenses(license)
		used.merge(ids)
		
		for id in ids:
			var license_path = licenses_path.path_join(id)+'.txt'
			f = FileAccess.open(license_path, FileAccess.WRITE)
			f.store_string(licenses[id].to_formatted_string())
`�H�extends Control


@export var load_locations: Array[String]
@export var export_locations: Array[String]

@onready var tree: Tree = $Tree
@onready var text: TextEdit = $Text
@onready var license_manager: LicenseManager = $LicenseManager
@onready var op_locations: OptionButton = $op_locations


var root: TreeItem
var engine: TreeItem
var game: TreeItem
var licenses: TreeItem

var copyright: String

var location_index: int = 0

# key = identifier
# value = TreeItem
var licenses_dict = {}

func _ready() -> void:
	if not DirAccess.dir_exists_absolute("res://resources/licenses/license_links/"):
		DirAccess.make_dir_recursive_absolute("res://resources/licenses/license_links/")
	
	refresh_after_location_change()
	reload_license_manager()


func refresh_after_location_change():
	text.clear()
	
	if load_locations.size() == 0:
		load_locations.append('res://resources/licenses')
		export_locations.clear()
		export_locations.append('user://licenses/game/')
	
	location_index = 0
	op_locations.clear()
	for i in load_locations.size():
		op_locations.add_item(load_locations[i])


func reload_license_manager():
	text.clear()
	license_manager.exclude_engine = location_index > 0
	tree.clear()
	
	license_manager.load_dir = load_locations[location_index]
	license_manager.export_dir = export_locations[location_index]
	license_manager.load_license_information()
	
	copyright = license_manager.get_combined_copyright()

	root = tree.create_item()
	var combined = tree.create_item(root)
	combined.set_text(0, "All Components")
	combined.set_meta('mode', 'combined')

	game = tree.create_item()
	var _name = 'Game' if location_index == 0 else 'Mod'
	if _name == 'Game' and ProjectSettings.has_setting('application/config/name'):
		_name = ProjectSettings.get_setting('application/config/name')
	game.set_text(0, _name)
	game.set_meta('mode', 'parent')

	if not license_manager.exclude_engine:
		engine = tree.create_item()
		engine.set_text(0, 'Godot Engine')
		engine.set_meta('mode', 'parent')

	licenses = tree.create_item()
	licenses.set_text(0, 'Licenses')
	licenses.set_meta('mode', 'parent')

	var item: TreeItem
	
	var used_licenses = {}

	for parent_component in license_manager.license_links.by_parent:
		for link in license_manager.license_links.by_parent[parent_component].values():
			if link is LicenseLink:
				match parent_component:
					"Game":
						item = tree.create_item(game)
					"Godot Engine":
						item = tree.create_item(engine)
				var valid_ids = license_manager.get_all_valid_licenses(link)
				for id in valid_ids:
					used_licenses[id] = valid_ids[id]
				item.set_text(0, link.componet_name)
				item.set_meta('mode', 'link')
				item.set_meta('link', link)

	for license in used_licenses.values():
		if license is License:
			item = tree.create_item(licenses)
			item.set_text(0, license.identifier)
			item.set_meta('mode', 'license')
			item.set_meta('license', license)
			licenses_dict[license.identifier] = item


func _on_tree_item_selected() -> void:
	var item = tree.get_selected()
	var mode = item.get_meta('mode')
	match mode:
		'combined':
			text.text = copyright
		'parent':
			pass
		'link':
			var link = item.get_meta('link') as LicenseLink
			text.text = link.to_formatted_string(link.component_of == 'Godot Engine')
		'license':
			var license = item.get_meta('license') as License
			text.text = license.terms


func _on_tree_item_activated() -> void:
	var item = tree.get_selected()
	var mode = item.get_meta('mode')
	match mode:
		'parent':
			item.collapsed = not item.collapsed
		'link':
			var link = item.get_meta('link') as LicenseLink
			for id in link.license_identifiers:
				if licenses_dict.has(id):
					var to = licenses_dict[id]
					to.select(0)
					tree.scroll_to_item(to)
					break


func _on_btn_open_data_dir_pressed() -> void:
	OS.shell_open(OS.get_user_data_dir())


func _on_button_pressed() -> void:
	license_manager.export()


func _on_op_locations_item_selected(index: int) -> void:
	location_index = index
	reload_license_manager()
��RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script -   res://addons/simplelicense/GUI/LicenseGUI.gd ��������   Script 1   res://addons/simplelicense/api/LicenseManager.gd ��������      local://PackedScene_s5f1d l         PackedScene          	         names "   1      LicenseGUI    custom_minimum_size    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    load_locations    export_locations    Control    LicenseManager    Node    background    Panel    Label    anchor_left    offset_left    text    metadata/_edit_use_anchors_    Tree    anchor_top    size_flags_horizontal 
   hide_root    Text 	   editable    scroll_smooth    minimap_draw 	   TextEdit    btn_open_data_dir $   theme_override_font_sizes/font_size    Button    btn_save_licenses    op_locations    item_count    popup/item_0/text    popup/item_0/id    popup/item_1/text    popup/item_1/id    OptionButton    _on_tree_item_activated    item_activated    _on_tree_item_selected    item_selected    _on_btn_open_data_dir_pressed    pressed    _on_button_pressed    _on_op_locations_item_selected    	   variants    &   
     �C  �C                 �?                            res://licenses    1   res://addons/simplelicense/mod_example/licenses/             user://licenses/game/       user://licenses/mods/mod_1/                   ����   e�>   �q�>   �X$=     8      License Info          /��;   0�==   v�>   ��|?   �8�>   �8~?      �                 �?   �EJ;   �82?   ��*=            Open Data Directory    *��>   m?      Save Licenses    ��0>      a       b       node_count    	         nodes     �   ��������       ����
                                                    	      
                        ����                           ����      	                                                   ����	      	      
                                                               ����
      	      
                                                                     ����      	      
                                                                                              ����
      	      
                                                                   !   ����
      	      
                   !                        "                     (   "   ����      	      
                  #               #      $   $   %      &   %   '   	                   conn_count             conns     #          *   )                     ,   +                     .   -                     .   /                     ,   0                    node_paths              editable_instances              version             RSRC�`�����_RSRC                 	   Resource            ��������   LicenseLink                                             
      resource_local_to_scene    resource_name    script    link_files 
   link_dirs    link_paths    componet_name    extra    license_identifier 
   copyright       Script .   res://addons/simplelicense/api/LicenseLink.gd ��������   Script 0   res://addons/simplelicense/mod_example/mod_1.gd ��������      local://Resource_jy81s �      	   Resource                                                                Mod 1       9   extra info shown in the comment section of the link text          mod_1_license_identifier 	            3   copyright year, (comma) name, (comma) company name RSRC�extends Node
7PwGST2   �  `     ����               �`       �P  RIFF�P  WEBPVP8L�P  /��W��m�G���J��;����bG��ӆ�S|ڰ�
�*����¶l2�y��������<2�$�E`��]"{Ll�?Nww��=�ur��v�����1�3֌��"*H�(�"(حآX؁6��{)H�$H�<F�W��LO� U.��G��gD�DF3X���Æ��FKJxP���2?�ːz�8�o�/Գ����R�P>�/|�3=��e�)d�@�0�GI:A��Ox�����!,�p�N��:����·z��U���1aŌ��V@�p2M=yDq�?�|�g8��
3�uŭ�ϲ?���q�=ʛ�jթ]���UK�n��
G��3�G۝�Y������ɦ�
z��������������/$�4�_�;�0�Q�f��&�V�~�J�Q��:t��ۢ��ɥ�~��A�X�ќ�w<�-�$�lP�4���bŗNN!}�ʠZ�qG�~rwӃ�C�)g�mP.Vi��C>��<���/��ء|uܮ�MB��K&�ru�9�'䍰eQ�Q3�N�;/���%��%Ov�x-h�q���ӔP����\���]!�Cg��C��rKs�h&�p���<�U�%��OUt7%
�e:���2��ɬ�	��K�gS�4NP&�,�����O9���A ���سj�G�~rjZu�O�>��T�݆�a��	�m~̙.O��+w��H'�+?������Q�>N�\a:�Hy����v�:Rz�e��,u��Ǜ��3].�XX�p���l�`�������I�0}�]㪘��7mGʝ�>	]�>.f��Mo��vO�m�����n��^~m��ӯia�%w>������>L��1 ��ܧ���p�}~����f2,< ����W�v2K�����4M>���a}Bߔ3���J���R@���Vp��l0��x�x�e:@a�����g�����Y��-(AW��A�F;b��x����� @"����~�=,�BV5
3Cڑ��:�����M���&���M���8�%�c �8�=�>K�	˔j������������VX����g�+�u�n̠�Ҝ9������Ϭx�/Mm��.�*!? �^^fNҲKZ5?4��aq6�:3̧�t��|�.���;�����r��54n�&?剙p� @0��˳�A$�
;\�a�;x%�\�J�7��,Y��4{�ۋ7V��b�
+�#&�+�̷93c᧨C�6>��C��S=R���\�zaL��ȵ�˾T=[uS+��@��N/*؄s�W�.gg|�<<��Q�C{�(r����\h��
o_��S|[�E���6�(>��)#�(��k��'g <EǠ(���W�,�,�eX�dS�l��d�٢_���׫�Y�J��A*�%��x�_����G,��ȫ�B��7��Rk�V���5i8����yͭ�u#6�"N��9�r�w����t�/h 0r�����N^.e#���
���B�AY)�.�0�'��m���?=V�LM&\ Ix�`�Z��p��y���T����e���vA��(T��*����T!l<��%�nɮ)5�ȏq�g����?P��5� Q�3E+�d��m��w~��9]E\1K�@����� ;|��[�,�L�a��}��'y��ɯ�짽��mA>e�c� ɂ`�z�D@\�^��|�����aS�x �NE�p�u��5�B��)0p��7��I���J�!�W��X�9}R�1�҆3��EFd¸·��o�6�t�Il/����V���;���{R�)p�.���<0y�*]�n�^H�#���ǩ7��4bdt \l2M/u��%�pn���[�ó���<�����`��t���"!L�s�66��6Y5%m�dXr��C�yV�id�u�m}h�;{0d���`�)(VG��mȑ�@����"O��'�,��n��z�	���/�o=U��b�	k8A�����T"	�"o�'~��y��`p<�[G�>�N'�p��+�0��t���ӎ�-�#-H?�x]sNvP����gy�K����	�8A'��s�e�b�w�ȸ�kεi��ӑ���+�Ԧ��W��6k�e���Ӗ�ԕ�7D�s��wS?�<��>c!�t0�:v��j���4ɕBXy�����d�a@
����-B�\2˘u��o�v�|0���o�>��"�l�ib�5�A�)hj����\�Du&�+r�.a[!�ԏ�6�Wr�"�jsY�{��?�ό�YO1o�QI��@����W4(�
����(̎��s���� ��n��t�Ŭ?��|�:w?�+���9�g)h��*�(���w���Nf��CQp� � ��#� h��uf �F&�Bw�N��qRyU|����3�弍��e�Ut3š3 ���Wx�!�������WYEI�8��a \[���t��:s�G&������n���.������?p������a�46���t
�(���c�����>�';��3\$�P�GD��E}�?���<v8�e����8а���GC��e�2��p�ք������<�QkV���$�9s�#8��`Y�W�o��)��9��]Z�S3�&��%�/��4ޑ�N�Y� ho�������K��hӜt2�,T eȆ���k���WW��^����o5�[G��kqM�H���� wj��<u���P����n��7(�߶d�������K�����s�P�a�l�{�U�S�Ί��#f�`MU���C7���®�V�w�5������"y�H��a�xK$�V���Lc����t�}�qy)p}�Аg!��+��	/�C���e}G� ۙ�(Q�S>���ȫ��&�}"2io_��fz�b͞�'���Rk}fۋyZPS6��P��i\ln	ՀЍtR��b��/��	FNg�!,=^p�b�J�5���� ������K��K�9�ɤy4�׫0��"��1�.fbj��*�
���0V<�h�ҭ��Fm��oi �?=⭇�B�ɶ�־�����zb^�@���b�\B���Kk<�Z|Ah�e|&,�fG9�:��|:�Ӵ����u!^>���!𭍓Y��cA�"�6�P;����e|v��I;,3�:���S�������a�~u�#�j�k]�w-��ķR�*0Pj��丷��|�}!��������u�7�"2�ǿ:� IXq�Ojȭ�":���gɘ�b�������ѿ�\
���^P��v�qM�Yٱ~x��Wm�X{A��&���@��7zr��b��$�	A�ͧ;�&�ρ�s2������QBZ��g$샩�$�ȗ�� ��:=�A��,��fz-��)1��Uz^�Qv�F�j��w�a�_N(wMh��c�̾����跑k����cճ��Q[e���!�w3��Qe�kj62���f��S�!�L�Y�AV�@37(r���c
��0�3R������i1h=qO�$uxFS�_�֐PG�&[�a S%��j����͞�p��6�e�Amx\W�R����u�1n"�1���x�u�nGM*�tH��4l[oфX������B~o,im� �l���pcM&J�'�߀��h��K�0XW4��١e;5����nl�1;��OV-kA雺�B'��(1InѨ֎��VH��w��^�X���+��gq�-���[Ft�1���4�h�b�.�[�{�Vv�a�u�  q� �:׋���PX�tY;I3L�G�'�Hc��6�6�X�J�����$Hk���f��P9g�s��)d���k�qӆ�O
��pB��%��Kʿ�ڒb��t_��r{�PBZZe F_�Vc����8̝Z��P�W������04�M�մ�Yka�0���l�4�����e�4!���v����r��J�c�����v�2`0�1Ӛ�@�ab�Tjt'��mF�~�2;��[ne�����hG��[��H�A`�V������;A8���Y����rf:�x����b4��5a����s=,p�����v/`n���hkw
 ���g�]��2פ��=��B����x�� zI����{?���â����jR�*��\!��f��־�a��;��2!�Yt���6�XL��z�dv���\��AY�97�D��KD���x"��ɰ�^0(N�kk�_)�]u�[�)h��jG���Wt, �g-��_n�}���tw����ٱ���`9|�|�l�v�*�ŶT����g���>�ş�{ ��8�$�w%ہ q��[�5�j�.�_��1����J  �}_��W�*�)�!,!��"��Zbt?��W*%oc����D.M�H_�`
�'o���v��<�n��}�����>s�! t˗ƙ�� )�rW�oҿ"�����`�>�^)->�'<�d4k��.��{��CjU з�h�� A�GG�"i����̂�v
�D|����t�4B�HqhH�_w3��V�arUɱDw��J�d���g�ګ�gu#����B����q,��-��;����Ϫ]�)����L��R�P=rb1�W,���Y��:(����c,�5Z0�S�A0Y���Zk�Iv0c���zyj�&���͊��e���*�L���.:j�f�O�Qk�F
�df���yU��s�w�$C�E��:�e���$�BD,I��r�\{�?��`;��o��js�h�?����C�j���ށ�%|l(�+惆D�!�s2�m���*H��?L�Fk=Y�}B�z(P���*E��L��̅0�,7����Y�Ό�+�y%�p{\}��n����׫"���<5����"��x+A�d��o$���.������A�Ց�3h}F.ܑ�4d���&µXv��Fm�����1�v���Ѝի%�JsWDi���Z0���SM/�:�N�����QZ��+:?}V�qd]��w0> υ�id]�A\�����I��I����r_x�d[sir�&��T�֗�a����:�S�?�^?�.RUƉ0�_VZ8�c���\�~�u<��|�t.fQI� ���t!�3l}�@(횐�66�#����t�H�H�*Y:������䨊7�Z�k�зw�$!r�ⱗ5F��r�s�����U]k)t����ڢ����e�mM���*+��b<�֭��d�]\�4�+B��Q���
�	�y�G�<_�Fy��.�4��P�zgk
��*��h�`T��4ʐ��T"�X;ӄ�w�|���U�,֖d��B�9j!L�5����c��cq�j!��Q���":,�V��WV�f�8��YY:�+��o��Y��v�ɺ�����tP	*CgN*�x����E�r�:cu16s,6��Xc�ε�"YkoX��8�1�1�궎��Z���QdUB�;'���&�VBF�����˨�9{Ed� �֒��Ӛ��N�Iܙ�ȿi�`+�/kLñ��N*lk�Í4��^��z��������P(0��@1������~��u�>��*�KLY�����lQ�ϖ}{� ���H*� �!5h�
�P���~�1��z*����_�b*p�a4ZH��XK��"��Œ
���P(�*����&�80�S�Vec�5��v�P�N���9~�umt�lu��5�.�#G��-��Z��B�2�b)�]�_S�]k�ò�˵׋#ׄ*˚رH�#y"��z�|L���\�&5ֿ�ZR��&��{8���^D���@���=`�P�Q�x��lf���X��SUW���Y�'�W�w+���W��5p�>�i��ަ,�	k�Z(�>�G�p��Jk	/����Y�z�P�^������os���&��b`�K	w$�W�����L�����n��L��l1.�B5!�c�+�����Å��YkscIC��"M�(�Ȗ�����o��a�ßR �Z^(T��\쁣N�"M�]S#�x'���@g-��{�>~�)y��*k#+�'�mK��O(�2g��'�sQ���YU�}�r�o
ȬwY�!��,hN�z��ؾ\\ ����!�i��'��`-�G�0���p��FksV��ʼ����
�r!����X����w�������:��0/ ��@͕v�x�Ь��V��2�@A�0ZK91t<��o�ME��ڒG��)s��B��,`�+G۵%��υ�Ю��L�!,$	�^gV&T(���<Oj����n}<�u`�>&&+��`-Ob��p�.*|���^O�"� ���!ոaK�����˹�`��;������*��~��ky�c�t4̆EW��}�LB�ʆ����Y����`Y���3X�W��f�������#-�-��䨫��/X����:b���0)�����7//)GG2kNiU���9'���>�|��@�
ဂ������9"�wk��c-��*U���88�]�+����ZU%��y˪��c�yw��aH�Ƙ�qB�����X�6�&D%b`ТU��v�l�m�����&��\,V��7�Y�TJ�c�ELܻ~*����~�N���;.I$*�X� 6W�P)��Ă���Xo3��5.d��9�U��X�v�bȿ8�zS�ck�-!��Qކ������+�����%з��X��33[���v��\�M�'��6��@����I!�Wn\~_�([�Z����c�2.�4��(��Di
 ����9��~�ݩ�`�Sxq���l�^�f�ز�FJ�\�'�E���ĭ[�\&�����K��N��-u�8��U��7N��;�W�j�z͍i{�kh����u��8aqn�Q�|g���Q��N��G5��c�W��)`���R���q�T�a������U?T�6,B�.�$�T�j^�\��a��g�hoDX��O�g�&��r�s�[q4O�C�&ä�b��g��s�=�y�.�P�a�C�̥\�)��&tR�D|O�����X'
�˳:�l����Y�J㖵P$B�^r|�	𭪖9�<��{�B�/#�q�J�rN�zM�k�/�[����]�h������xAm�k��R]�r���R�D�9�ڗ7�/{��5��y�dʹ��(T��4��
lBkS�W��XoЅ*������M9�h�B��ܨkƊ8�Gi�����?E�\����̑u6ؽ��}L�`}6?�%;;��^ʵ~�]��{��?R��rO���.iFj'��N�Ȥ}y�w���naJCgc�,_��!�Ai�\�Ѻ.��Hʬ��8�/��3���,��'H�8�+7����T� �zWn���Y���9��Ҝ�ՒP�R _/�����U"T3�,L�NVE��k�*c��2ؔ9�A�ß厓���P���4>k�sA��Ƨ���:֘`j�Ҏ,8\�j)���q~�},qx�$~��*Z�4�8j�����r�c� c]�g_���:�#��|K$�Z'e��O�t7�)�z/�C&��%_ ���[��~��9��Uk_^��e�Zy��׭��'��h�M���t�se��
�7u9���z�-�C�2���gL�ʦ�fq�o��U�O�\�Ob�Ÿ��v��D��<E�n1���9r�0%�	q9K�Ku���9\�N�"�L��L���`����L~!U�9\�R9pfj���1�-�K��:�Ra�����hN��g���g1�Ų��r�=�mD���F�|���2��s�F���Yq���r�[��q|�R��Q��)�S�ۏl�
�������l���P��]��r�qs��7�è�#�3���.d�׸֜�
I�}�!����	�Q��*~�Z�.\<Q
?���\�;���r�/�J00�1�aX�kb�c׹�ع^����yQޕ\k�EHkϒC�te7!<��>�z��"6~V
�>�N�J7I��a�P�ٟd�͋!�l�u�6֑DoVW>�����j>�c[V���j.;�7E����{"*mw���@���M�/��{��IK���O������\�f G�uE�qd��ˬ�+��5�0���@�ei�o�`�[i�Q�Pg�*����V}P+�c�6��Z|�o�X�#�ʲ��p*W�`[e ��⬭��Z0��se**=�Q Ĳ+2VY�_
����dU��I�����-`�'��47G��62��;"������Ei��6C���P��И�>�C��J��
m������n��̆EO|�-[�Ry:^��7�"���m0�ڗS(ky5�%?��!:-���#�"�vz�8�?!���}������6�G���p��1|�=y��6��-���]�B�T��g0�!c��28iU�bn��0�����"�00��w�vE��dN��K?�oi�B}b�����#�)�hQ]�4��wJ ƺ=I�>�-��6 �aר�j7씐V kJ�	"0��i/j���(�����E:�R�E��m��Oq���	�y<P���)sx����1Ӏp*�ih�~
�'�B��t�L(�6�@��O�g�&�K����'��S�E��N5z�)N���:��qY�:\�^c�h�t 	�>.�$Y��
<^T��քRiqiKp��5��B�>&w��ǼR��< -g?�������8��`!/��1ʭ���^Ƥ�`N���P%k��7g��\�-o{rgdl�u<#��dB�@�zYuդ	��x�ڝ�d���z�D�\�o���W�<�F�="�P��ز����{�l-�IL|��U9SL���� ���잶�Hξ>�"��q�Z�*b:�6"�U���e�WB�1c��E=a����pX�*sy/�t�$d{l7�IƔiU.�Ъ7��rdɪ�3��B�nS�+�#�~�0d�4w������'O��g�`}���h$�2��{�N	ϊܖX~��'R;C��?��ii��^��hX���U�E6����Qoͧ���hrw�[�w�Qe]J�Z���g���GS�*�����Y�z6X$��,�ǘ�� ��ɚdčkQw��{'{oɟd�|��,+%K��}SљTC�֡��Ѻ�ԭ�Iʡ��w��E�L��C�}|���X�g�L:Ƚ��2�:�z"!����l�E�شh_H�z�}*�r����/S#�qi���XAaؙ�>4R���D�SɄK%:Lx�8�ag��׋��x�Ak>6d�O�?1�/���6 ?�9���U���!�iy�1���8�_�s�}� I5ǧ|m
�)���m����ʕgP��X �?Q�%!���Sd�[k�֢���X�1�ۭD?��|y��w�+B��zw��t$������Кk��,�I�|�4��N�6�����4�:J3kֺ���/���Ͳ	l���Ϗ"�m�M���j�]�L��W�i�M܎�Q�`l�g�����dXm^�~,����B�^T���K��f�&:}����H���*��di�fz5+��E䬼B�:���kQg�`mg�C��#)�>�z2r"S����x����_U�S�z�k�״��l������#M�:&��ԾP�~e:<�Ķ�AU]%w6�1.ٟ�z���sG� �Ic���V�0#4_�9B�vs7����.LӮp���`P^����ZPG.����W�"c*pc�ռV�af0K�A�֟�C��l
ӕ*8v�cqx�Z�!��d�g�Se.%��[�����'	>uL������a�h@i-�����l�X���K�i��4�n�SQ�ތғ_{ZАZÊ����=9_���z,sM�`|�h1��>~QͲ��R����Z�סd>(YQ�n ���lP���=Pl�0
b�XbJ*�3|{���J��c�|�l�,�~��B�v�%���:��y�Y޻�u%5-�8Xn>��[��ݟUj��A�8��u&�^�"�韧|��7�j�3N�՚����ovxz������17�o�?�8D��4'�y[2Zz=
k�������0G��j]���� �?�m���4q~
�2���-΋�[N035w`]��ͯ�|R�{�Ѫ��f�&t$�l����3Fz�PV�ݢ/��4�Θ��jz��a�n4���kh�e���}o�	���qu֜�iC.a���3�
7��g���q*�֖�D�������,�=���I>I�Ȗ\��Wd��d���N�)i�����ѐ�B��-oF`Ⱥ�z��':�E�jp��^̱d^1��v+5ыi���.��V_���52i�W�k�m9B/F˨��o"�z;�'#��t���ڗޓ��q��������v`F~.����LR�Z��+�`D����y��"�բF���|�:/O�sk�P���Qg�( �z0�G#���a��VF�����h�݌^ͩ��W��N��j2*6��[�^MVʈ�B�NT׫� ���[��|�W�}����xۢM��a��`Ջ��ټs�! �dk[��	qH�omL�ݴ��X(���ތ��HĢEw��wq�u�b�ľu0�w�5���օ�ލ�s��/�#�����D9�6�?[�$���wx+�w-VT��9�p3�k���p�����h�|g4������Z��f���D4�����Y��7�LR1eQ ���HN�	�C\� �,� m��Η�=��e���� 4�jV򛱆�A�9�4���;?K���C�LZ��b=�N���&+�s׎����Ƙ��	�z<��$W=���)�I����6���㴲�GJp�i���e�<6��c��89��.y����I��dj���b���N�~"'��o�V���-�Y�g�ݒ��.я��;|	X�)�}����V����cA��8����j�Kt*���O�����`ׅ�dC\���/? `y\"t�iw��\d$v��-{/��`? 8���E��c�d�:#��N�9���*��ΐ�k�:�6%��i�$v�pM��ب"�<y������8\�����p�w�/�w���p�O$B�i�Jw�dq�M��yQH�X#��M�cMB7���-f�,,�4��,����;�� �n,�P"��]��nauH���"������Dd�c#�f�v���R-��Ȳ���e��{~&���l|��e[t�N,����TDo���?X�X4���asxI����d�7,�-����4ȾÛ��\�p�j�nQ����Y�.�+3*�����Ł���(M�!��淫5=�iGZi�m���^5\�<3z��ܹ���'���Q��%�5p�"i�%*KL6&�e�ִ7���"t���؟]���K#������nX�ʼ��b�B*M���Z�C]զ��/��I-A���y����0�̐)�F���e� �%_�a��>�J�uaj��z��LK{�s��5\'�tp@1�Ķ�g�����ߟzo*�rt�l��������m����`ϝ��u��k[��T���y���)�<���E���ش�����j����<�'YOfN�%��=��~0�zB}��l� (Q�d���m�ngf� |�kj��mN���R~��
^M����q��t� _���BZ�Y�I����ݒw�����wY�&�?�%�����j&v(�U���˘0a�

[ب�"����� o��a*f @m�@���h{?wn+S��<C�x:i6���|����tx��r�M�+�V?��R����DT�X�q/�Y[p���^.t��x����]�" �LoIr�f/,�j��+�[��>�� �T.�����~�'a��VZirq��7��q��]R��t�Y�oR~2�,�I��INB�#�� *�k�j��4�6{�W�oN���Wa���S��\D ej��
W��D�T�ڥ��rZ�29���}�C�s�� j���B�S�������8Y�Ud%������Yc�.d-��y���	�����bi��,�#'e��U�4��x-
�H�W���HLC��렦�>x�<`��'�H�Ԝ� ��6�"{�U��u�j�X�q~�n��[2Y������F����O��'�L��!	6E�Ѓ���^�oG*�F_/�o@;QTY��^0��</I�`p]�HL����≸R<� v6�2~�7�1d 0ܐƍ$�x����s���A��'��2(hnK��,��8 ��k�K�9y[�Yf�,[|SCr���\s��Xֺ>(Sm����L���
�vV��LLz�~q�|�\� ���-
�NT�m  6/��%�y͹�Y]�\��u)oVG�~��O>���k����y��E��K2		��ϴ�4�`%dnq�Ox�7x��!	U��~�6*�B���nM&Mm�����Xދ��Ǐ��]��~\_�'�k��}��x�~�"Y��9�5]����~���  �5������|Οx�SF5�-ZjV�,�K�@�%���,���ӾL�V�$��J�>VԄ�!��nQ��Ԛ޶���Ñ�7/ҹ�> ��a��O}Zd�}\��^������ڤ�����+�󏅩���zǺ�i~��yh,,�sR�;�g>���MU�Z��fB��(ip�7�9��Ϙ����^b����#;��>  ��XQ�����6�"�}����E�������GK}��}њc���X�m��Mm�S�C:99M�i�j�<�f�I5�����E�(�w6Yr���w�dE��*����QY�5�@h[}We�u��mIb��ؚ�Ü~��>Vf�?	�g�Ɍ��� ^ V>���d��j�k�T�&�(7ص0(65��שּׁN,oc��=#�����2��^b�S��@#U(�T�����a��&X��cC�o����E2#��G��j�G�u1�]or���I��N4�r��<,5R��nKLZ���Rc~��h��x�w^�q)w%Y�3�(В@�{�r;�E�?ke�sGP*Z�7���M��9��j��^�>��
N!�Ay�ʚ�8�����7��+�B<������V��Z(���l�G��:;�c�y�)���6�@'��/1������j���b�`��|�%l�9���֝_:Ue��^�����)��~�6J��ec�v�����hT�|4�l������d$+�Q.��\\���8K��U�=,w��6-<����Ls��BZ�c��9��Do��2WU湣�Y���"���W� �w��H�P�Ä�;��*Z�c"<�Ȕ5��<`�Xk%�����S���2��o���� ����2����_��F�`�=��YB	���*.!_�x�	0U�z�Y(�)ѣ9|��r��NO��'=lg����͡B	�}j�/�qU�Lw�]uο'�N"p���ʪXt~�[p�|������E��+_at�-�dPW^����?��[������ib�0e���6b�2���͎O������:�"�&pJ��%h�1o*3
U�g�ÿ�(u��4������T���՝�+rNژ/�3�Q߂�2���/�>j�Q�U������s7�֦�D�B&4��hB�4' �/3�sψ�A(���Cg[y��F��7�˪��^���b��6ofrH��St�O�;��H���jyZ*c��"(|�1����X�2F[�J	������"����}����{?��!��_^�gť���|/o4�����m��5���F��ȝ��y�i�j����>؇�x�P��e E����,�\��l��J¶�:���������&[Iz2�{k<^u�iT&���NG��ʪu�d�ǤϚ$z5� 8�P�C��$�k���Y�ܹX�`QZY)����B��ڞ�Xs���]���&��MG�<�6~�K�,�%���M��\��ǯ���3q�zj)�E&��p�`�	!��`QB�����.�*�jش�q�L��H���$-)�q��Q0�.��q".V轹��o��7���]f�G��O�
<�r~ ���j�iA(d'ni����z������^HD����R��;;�i��YgۭнO}���j9+W�1a��0z�T���D�2���mY��Ne�
����K3\�8̒�ܖ��(smd�pV�H��/�_����f��i[�z��͢������ZF��yC�V.c��pD�]7ʙcw��Y��Һ�r	�E�F�,)tN�y,�� �q�"gL$om�r�MP�
�Q��B���R���Ƌ�2�&��Ei���퀀g�ΫA�z�� ��[��U�E5yjw2�����YݪB��FS��1�W�������&�01��N�m|�aV-���)g�*1LΛ��T�J���o��i��_҄Z��=<t���:��S�q�|qs,b��e���#�iD��T���w?%���StE����K�Ѓ�<�	R��I�w��$�K�k���R�2���7j:��Bw+�wRZ$�wg*fJ�f�]*����Ɏ�l#b8�Tƺ��8*V���1-�*L��� �n����&-�@GZ��\L�Zpm�-�������P���*X��+�;i�Xt�&�s�da(j�ֱJ���;�-���'L϶&;��Ƽs<+5բq�-�?c�y900�}�����_�����R���P � uy������=E��|y�2���S����9���6ڝ��SS+R�y�%����l	����S��F�a~磬?�s\���)t��P\�Thbg,�	d��L��{Z:��p���Rfjy/�~+P�i��<���x��V�"-�	������%t���{��B���xڛT~ �3�e]"�>�k�ig�b��G:������Hwn�KM#d9�'��f� !Гj8�S�-�D��P����J��4�΀V�Bp�؉�8�l2v<�s�6UC�I�e��V��\�&[j� ��G�<�X�,hm�8}*��4d�PϚ������Fg�
�K�#����p��^�wt��5iZ�2��Z�h�g��5%�� �%�P���hE�(W�E7WҊ����������V��������Z�o�1]b�<�-�T���Bv,�m|�0��ĴD��3/O��[�SA�avs�
lnSq�ր\�)�qD3t�|���>�Z�F~N�l�~*���c>�y9桸5��h�a��G��z���]���:��/&cs�ꤕVڼ\����81��"T<O�8���|d��6qb/M��8�����f�U3e���KV�%&�?���<��Γ�A:�(��y�31"/�:~U���	V�XY'(��=!��W�&���:<#��a��$&@�u��6�[=N�Ҕ����B$��3���_��NGjazQ7��6�\����B|���xi��<�F[� ��w/�T��cf�����l���'B&4���5"�]Ֆ�����d������֪�����f�P��5kxz�u�w���d�$n��	��/11ٹ�/�3�\I��fv�sM���G_g�;�y��Y��d���j��?��+�PL��m�y0m4_��=kg�Nz��ǣ����</-�&kZ�a���A��9�	Y�G0��t^�ML~��Er���4�9��dw���ciH�}p�K��?��3�!|)�����;Lw9�'[��&us����oؒu%O������r��ul*X,3�ӿ�#�M/����0S1���AUru�+�V�\Ѐ��oC�,L�x�y�������w6�*�h�~�w����8�#On����ίE����g��95k���~�<T{�(�;�`t��=�5���_~L���?�(j��V�-��sͳ�A�����($H��ţ &����:uU��qo���mo��ғ�g[.�\�m�*x,Ht�y�6��3��T^�m�s���B�+��w&]�2�˜�e��i���w��Y��v���������+���x�dB�U�5�z���Q
��Ώ�^[����o���*|U���}��%�T�o-��C �jև*/(����=��aP>��p��
���z�_d1������k�'��ΐ���.y�W��pݟ%�P�����R��kyO� ���϶i;����W��WIX�x�m��^�t���k~���'�P�7���������
���D�3�,N�8ήƊ��\{��(G�BjY���s�����S婪��B�d�T�dU`+a�q4_�PE�F8�m�k�u����o$2�|�����Ng�{IG6U_�~���.[�ѭ�����d�r�����bghP�D���+ҼWv�c�Hg�pו���Y2
�lo�C��T�:ۣ{5ʻ�T��D_݁�i�	����U)�Ё��Ԛ�j�b~�t!S
MVb�,o�2��TsP�쿅�K�//��Q���Y�J���<r�5�v�&�Hk{�w0=)y���K֔0㕭jZ.��ɮ�4�Ƞ}��5��ۀ� �BZ��K��E{i�"ͤ{2�'t���â� ܡO��~f�P�h*x$�����T�jie�IV�[OB�����[�O�o(�T�K<�����S׶���}��9q2n8q�2�=�o�����[�|�]O���v�F��:�p�}�8t�v�K����]�@��ϙ�~����*:�S4�oI�-�B7M&��7(t�Ss��ek��n��1�V,�kR�N��N�0^4�r�M�@�iAu-��!�7�X/n*��lM�ʆ��=��4�X�2�M�,B�Mn�0�p�'T ��N�2�$��u77����A8O�z�nu�i@bѩ�����|�!�B�P���t�	�/Y��TRO�� ��[�u�jO�P�	���ʛ��r�;�Y�Xu��T/G!�-Z�Fsq/'{̑ŠC��o8���QY��t�7p�r��#F�y���8�T�pr=�$����Ñ�:�-�lG���Q5��K������)��{|���q�&���3y�XrhUC�&�l��;�G�{7%��Y�;����ލf`8|��^=[{=-Cu���)6�Tѳ��d��C*��\b�FV���u��G=�y��� ����z5���� HL:�Rz�7�X�o���w��jD��Y�y�d���C��WCx�������:�a�IR`�*���c��K�3�[�s�)�Z(o�B'$[�
"�C��8�>�XPe��x��`�B������������+��z���kVS��7�}(;a���Wd)֚z��1կ���Ih��J"<�E)t�s�(h`��ӓ�3C�+���;��G����_�j~��a �ǒ-� �N�EKH�٪����R+;"���'K��=h���_x_�X�ל3��&Ĵ��?��=�@���`���Z���q�Fg�)�锄���l�琷���.�l��f\�ob`<-L��S:��{�`��F!~X���#G���H�Y����ހ�^��k��Z��$:=Fr�s�L��L!����/{�t��m1.���e�)���1���V +�1�H��q�gY����ưZkC�ș����{~��Dwb�!��L��m���z����?���ͯ����
٢4ϰ�1�����-|#����Jפ����m��7/$��������hOd`���=Y��� 
��q`��R������!�c���ZD/!�g����(�H����2.����؏%x,���ĸ�`��y/�_(}I�n�75GkG�e-#�1X���e'��<�-\�(�/�f��͓�]09�?�B��j��j�i"ڿ���8$��*4q��A�!�`���^�]*��U[xC��H�3,Bc��ĳ�����ɻ􁷇��j�o*�b�?ƒ;��J��ǂĵ��Lsա1� <��7�_�[��%�[��ڒ���W��	�eH�8�P`l&��7�ƃ�;?�ZM�:�`�V�XU�G)z6AQOf��e:0ȍ������z1L),;����lOkl�{�;�Ԭ_6A�WSR(�7	����C�b�R,�(|Pܯ˲�w��W��&):>#nŕ|L��<���i�aM��Vgp�e���-���A�wF��V#Jx@&VzT\0����[�a:PP�!���(!���b�j!(��o�Ț�T��R� `����A-�}���;닼^)�S��E� e1fѫ���o׃v�Ks�|5�����|����T2~���K��H���Bw��Q�F=Q�������1v5��keA"��͝��\���r�Sw���)qCIK�w�?H{K�6Z!��i��`Te�,�����:���GN��w�?h"	���˃��9):�ߓ?�a=̚]����c��=�H��:gzC��8��)E�.|ӒxjFe}�%t�橜��q�ƈsY2˞9[��$ Q]t,JЌ߾�bp���Rմi��bꝉ� )��xHi�e�
����N�OC��H�Х��\_�đ�U;�5p����ÙD �����c��j�Z=��7�٭��£J�q�Qe�>$xy.r0��)Y\�(8�|�}4�l��n�'R⃛����XߖyYtL��_!%�$P���*��d4h[����Z]�>&'�cdAX��aG�_��~f��HICTt0���mQ� ?�7٘�Vr�3� E�>��{��]������RZ����`�H �eu�$��~(���f
�Rh�ku�!�����������ۚ�YZX>�^|GkE�΄�5[��Q�wT�n���;����Њ������0m<�V��b�8(e �yRG��£6�nf�D���췪@ ���D�AY$mC��1C��'5̰���:��
cs�ht�&{4���A ��ǭxy<��)���Z3�L������s�e�xAqW���ϤZ�Z�+�P�?=��R�-_���u�Y��_f���&'��H����y��0,��L�*r"I*�v����8A�/�����c���'�h�����S��8��g�����z����\�"U�5iN�����8
~�T��*�{2�k|�,��hyu�����Ȍ|��%H�w��q�0Jh��|������DIԮey��w�UԷAA8��@��mn�ƝWօ�B=  zxR��E�R�`-����|}(a�&�t2������}�D�qR��Iޢ 3HV��	�c���Ǽ�k�J���m]����b���T�8�K�G�<H��W�.y)�����25k�[�Mtl(��axRu�˼K<%��tq���%��i�'��f�j�d�N��We�P�erx�4���w�RD��A�8d��9y��?&J��2uiY�.��Eϱ���X�be�N��[��W|���>A����$V�,��SӗwG�ɿ�/�g�Ӥ����<uS&�� t�2�i��s���<"�������-�oN�"�X�$K
�*oAK-��X����h�mH3I�⛼ȇ܁��V�D��0�}�ۨ��N:�6���5 ��;YU}4cc*��|~i���|����8x40�	H[S=T���z�oig�ܬJ2�w��oY���Y�Jv�	�>��f��
/�1`�a 3~���(�}k�/�~�r$�:+��ES:��\��@���Zm`���Ҍg�.�p�0(�a	H.V�lN�����we�`�s��:5���e�'E���\��O��4s�7x��)Z�9���<�(�r�R^H�"�@�UJ�;u�-��,Y���{T���B�]T�MH7�x���:�	��-��d���u����2�Sw��a�b�H�%����6k�"�U�E�����}	4�8�O�C^���"�#[ �%�5��A4����r��R/�'9*V�F�:�=�t�a�.���~.�C�~���9�g��]n�ڙb$;�RO��u�O'�7~w�	�5˖\�IG3	kR��sW����Ĉ�pO�fȼ��C��Ɠ|�?�>7�'�R:�>� ����z���V2�O1���]�é�3&X�@�� ��ӐZ�{U��&�̣���_��\ꙋ� �F7,��sNA���|�?�׈$)��$�L�Krr���g<Fy9�)?��ϸ�5��	�P�:d�IfY�ٵ�y��J�|QZg�����'=�L�b�b�>r�ί9��/�K^�"���D�(�8@G��&F�5�:k�ִ�')�P�S?L�6}7}?�0�$�<�R�h�;��/��R��\�i��Nd�):�� C�+����չ:����<c<�Z���c�#�� �G<^?H&>*�1���#$����.(�����[\�>d�P�el�U��bŌ�cڡmGj�hC1��aL�XÊg�/�-�Λ|Rw��=~�����A&)�tad���ZD$p��_H]d����?��L�Qӄ�qLX�L��d�z
�p����oA��)��#���"�$2Ɇ�5h��"&�v�,3�-�(��Cn���+��H�A��K|��k^�%^���s\��L0��'�b��Y4��aL}&b�&�6��%.q��/�+~��8i��1}��@�9���R[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://duvmbh55cyvev"
path="res://.godot/imported/Icon.png-451064bd72ea26ed7eb00aedd926556f.ctex"
metadata={
"vram_texture": false
}
 6�+ik��o}�I�hGST2   �  2     ����               �2       �  RIFF��  WEBPVP8L�  /�B��mۖ�iu͒(�5�B���
�.Poq)�w��x�d�w��>��Or�o�����I2?EP��}��+���R=���BQA���F3��a4�����=��{_��m[i3��5�b���D&) m�O\��X�O*�4��(V؃
�h`Æ2�,1��QB6�D����(���� �%2�Hi�1�@�IsЁ���8�����!���T��e�_rm"ha�:��d�
�A��;n�C����^�O>�LSp���K0�s��fw�HA8�C�`�u�E/���C�󜚱m����+�h�LL�D��P�)�W��,��E?�`�LSM��p���onf�'x�!��<P�f�q�f�^�h��vza�9�lq 6Чp�ń`�;�s���f<���O���]ƨ!���Wkݫ����{͵�-�3R�eVXiu��Ά�d�����R�)P�%�^�O���~Z��*�Q߮�� [|�"�
��A�>�q`C��pL�ܬhs��򔖍�Cc�<�Ln�zR렉�g�3�"�m�S��F$guG��GO߼�2�@W�(��i ��T�1"�É���2M&^��QA�e*�Y����ˊ�S��r�#�{,K��h���Oo����>��31�VgGL�('#�����f���?+�V}$bz��{B��8��}�7��8���/޿t�ޠ��4B��U��	�� !�j�m�Y<B�J��/1�x�/�["9�<��	��|�R�)$Y(������d�"��t�)!}^��,�W�qM̘�@���o�`�\aR"�Y�Sz�JzI���W�B��T��./9�zs3�G�B ��D-�^�|�}�O�r����YalrT%=��������j��b�
c�/83{�\�&?(AS�2�����S�0񑑦�N1�(�r���ň`J�C�2�`A��s~�l$�x���C��ew�H�NS%�9`A�O#���
M�ɡ���@3L>�h�_Zo�D��c	h�ubO;$f�k�ܴdKJ�5)���yE�I���&� 1Dި�O�7���}J��V^��0�"�qˍH�� q�VDS�l� /�xď�GO\q�*`-A��AB9�h��m�X�RU��)L��e�9���>���E#�(���O�'Ty��7w�y��O£�T�e5�r�~/�~g��Jm�0�%��m�J���NY��5}G�G
��"�~���a�^�pG�'�+8A���  �����)�#A�J�c'gf�1�{��\�7V��T~��E���`s��O^��_�o�D�� �qd�]2Y���'�[�a�����da�F���5�����=jg�v�9HS m^�{�͝������Q\��͐'���1P���
S;��cf������v�9(�(&}����r��G|�uc�n�&_p�3���⁔A���$�,���~�KM�<;�t&)'c�r��'p��pm��ѐ�[�U���Rs� ��$"��T�Bv�<bz��W'���j"1�=9r���L�_d�)k�0On�z�B��6y.\8�D�k�����Սv�;��'k$����K��
�1|�����
�7<ɿ�r_�p,�|�6����_��wނ&��V:��H3)���#~9��_�ßd7�����4^0�F����,Rɡ��?'
ǲ�m����G݁:�=�t��<e�c�G��e���x��O�1(A�A�U�hE���G%s�q�e;��[(0�sV8F��
y����t��6�&o�x�_����q�FL'����� ܡ�Qָ�w��b���x
+;#�I˗��������4:�@ �L�����;�*9v>�<ȡ�n(!Y���  3a:H'���[|��ن��請-Dq�O��Ŕ��]J|+�/�׆nH���.6p��b�(��ȱ�`	p-��8L�ؓu3>;�$� |Ƙ R8�b�L�5��>���Q���˘�"�9��tZX�txi%*<�7�Z9=�Ɓl�K�$!� `> ��w�9�����qϾ���b��~���F�]*T��Z�p��A��G[�Z�Ɗ�s�>[�&\�l�����B�et���P8N�ǆ%����3|{�\1c�ԑ����:߂�;ڦ�#�� Aa���tR�~�g^N�B�uԆN��3"˙Tu 鵐{��C;k����)H�>p�@*m����D�J�I�$A���|{v^,%
̠&��p��$�\NM+)�?�{c�I1T2	�,P �4ƈs��A�f
>��m����7h��NvB���p����&nڕ0�C���-l�M/;@���<md�)���W��}��bhL'H*@ӻ�)�9ka�n�*E�떒��?�[᧦R�l���f�A*H�c�x�?|2]�7�q�3�ʅR)af�Ȍ}T��w��Hg�)\(����l��#WER�~��bԯ"�����a����&i"�`lPA��|R?��pkGb�W*��a���	(	����i��"�`����� ��B�㳸i�J�G���i����i40�<�Y��bA��G�q�� �d�n����}�+��ʛ.�J�!�MN������
ʤV,#��f
�u��BjJ)�^s���*�E?0�0�>��f�Z���y���A�K�o��h�u��f��!P�8�,=�����P&yQق�$F�k��<>sx��V��m	 ��`}d�饒4��Gqs��@:M��;����o�qv��ĂH���,�WԅB��E�4p>E	Ǚ��1+���}�?k_�3gM(XzY��$0YG�D�	
q�3��8]�8EG���a<#K����JS�o\�N2t���<s�iI8N�L�R�i�c��u���mՙ�'�Y��'8d�>j�%4v�"�w��oA�>�"GYrb	�B��S}�OKˮB���=�p�i��fN
Z~��w�k5p'���mQs�}�����}��>���]r�n\�@V\�����f�o-��!���ϑ��4�贪��/�ΖA�hc.����E�i��$q�����	���:�z�����R���,���prXY	
Y�x�}�\8.�$'m6�P�W5v(�N��9�I�b�h�m�s�2��PL
��`��x�E~�$H��5�To!���JCG�!�l��Z��;����)�G��Xc�~C������fcG[�� s��3'��4�e*ʹM�Jçf�-�rX_	
9�x��R�pi.ړJS���3�Wl�b{��v����SD���zCd��!�p#<�>6��H1�8�oD��"����~�*_8A��.:`M��v���x����y�<�0~�M�!G+dG .���ox�%��Uװ�WĎܥ(*ͻ��4���p����s܆rqP�猝�t��/�����{���'��)��P��	lXO5�D�@��8��i��73�H/5��3�_.N�"�uq6[`��./��g�#��m68�G"�43
20q���A�u?��{���_�ע���5�3~��Pꝗ&�ލN�"9-9�j�2L�e�wu��~���j����K�40�"$���,�I�X�@E��Π>y^�?~��{�'���s�7U%����W���W�ķH��%^D�CC,����`��t0G�1n3��}FEn7�I�E sU��6�]v�zs�N�,)�J�G���*���@mL��?�8�Y�.�Oh�� �}F2�	#��ñ���ޘ�7KN�#�u�Xh��d�4v*�C�G
�T��p"���g��NQ���v��NT�`���O��P��vfIyZ���;X��	z亓����T���a÷t����E�xK��ـU�|-A��L�:�@��`���#K3g�}o�kW�4^�0����3SxB��z��~���.���D �T��,����0!�:b��c�T�򇰫�'3{��?F���=)[�EDrZrȺ�mĪ�'/Z���{6:�� �\ez�\�H��x�j�o�^B��NR�:?z��V:�z�0q6�w	3�Hr�~���C�9����v7;��6��al����</b���D��@h+��@n�a�ďuWe�N���fl�3�F<�|%loqA�!�A�n҅��э��|F������Iɀ����{����W�va�T�Q��Z3��M����y/�L�)N�Y�W�7A�0��8�1:��H��C�QR�d >���������,%	��x�T�]�3|CB��^�`��Hm1�M)9�%�lr�(�=��t��Ы�� ��agjɅF���m��k���R�N~)��M�����r�ъ�K]z��3��>�e;gn�n�a�<a��W�3��=��c��W�Q֠�Avπ4����}a.����p��5Xk8ffC�/3v��'�zr�"��xQ�Yg�����Q����}��p����{*���纯�n���0�3��������<�]�O΍���h�p��@E��&4�l3�\��U�����������3ħW���������������|w�õOV>'�[^ڒz�'�2c#}��!\�u(�A,h���\ �n�	]���_�@����/l�6ti�w0�ᷚd��4��q�~$7b>���h���f�?\�dm�D����d�*c��˽^��������M�$w&#WX���l���\"gZ˞<R���r4�B�����[�3�9�7j���9E1�|�# �F�6����A���ւ�j�pB�U���EnPT:<ƒ�<�. �fM�F]��4P1�.l�pbf967A�N��qi�����Ȧ{�N����E����c��#ظ-)��-�B)d���X0!���]H1b/�Ñ_����_����K��!��E�:Lԏ��{X
\�!#������П� {+��͝:�T�W
p`��c�P@a��	�1E)T03��砂��	\~�d���M��y��V�c�g0��e�Đoԙ66'�)ƞ�o_P&��lqj窇n���m��)<9&���E/��3%�:��0�SY���B�[�;2l�83Hr8���Y����/�FNV�11�>��HsG����%�|4���ɓ��� �怜�R�����N�v������ᤸ�{nC��jMon���7�PJ��ms�4������K7]�k�m�X8ዂ�"s���1������cj�äW�L�=Qs�@3L|��M�9�x���uPd���qsK��B�X�%����NvN��S�� ?�,U8Qf9�<t�mA�����4!��b��
ˑ��H�f" ��U�M��9��w�쾯�Y�`���\^���o��n�ɍ�@�ʇO�I�\)`̜kj�ǽ���Eـ������Vw�<�F\E~�"k2	��8���RB��3�1��ԻNX����|�
�9mdiU�Kƌ�x�#���3'�����w�)�s�gd��[(�<�}��㓾@i8���Y��i`b��É�&a���j$-􊔡�%��  ��j��'}��{S�lm����m�Ћ{��ȷ�	����V����T۫e�+��l�˚HL�'0o~��W(�U�
>G"Fe@������B�q��U�#Kŗ�4�]����g.o*΃=�ݯ�~q%_�c�?h�P���o_� ���1���t�`얫N�S���$��C��E�,�R��N�'�Fp����]X θ�FV�]3��T�����}�p�8������X9S59��DJ�4a���"B�ޡrx���1p#X�Y���٭��<�L���F��}[<��z���~��iWE�	�!� k0���uW�߅|-�YW��K���\���������Va�[K�O%\yJ�V��]���=Se�w��憨O]Z��K@7�m_�ad��{�+��)$�7R���+��v��ל�Ӷ��|���G�:����#ԃ��W.�֩��j;T�q�
�=�E���{��qF��0�� �eI�7�#+zL�E�牧���yA]�5�GV�����}xJ8^�;�U�ގ1Z{�o�Eж��4Wa����O�Bݨ�`������C���IrLEY���)�g$�Z�����"��I�;�����boH]�	��-���7�)C�^��
AQ�>�<���i!��~�)ld�-��5Dn�*�F�&2���J�C��Z  9ր�l //o��v.�(ܕ�3����_�}*��ȿ��%�����"�0��J�Sk��}N��&��H��G�� ��! t2��sQ��>[isr�R������~��������1< 
��6�7�Џ!�lDHJ��w�Y��B��x��p��Ǖ8I{{@�<_:6�z�]5���+X��t.�@�5%�45I]��c�i�%!a�G)���������@c;{�g1,�����m�gh��Ve(	�B�F\)�	�ioUƛ&(  ,P�k��[�'��LX I�L��3{�(
��E�~Ӄ�b$5��5�B�H�;��`d~�O�i��N�_�p�^UW3�D`q��=K󊳜�R�2��,�޴���@9c��Y��N������kgg��4���|6�,t��Ȯ��sz�f�����+�����w���E���7��gm8��d,�fU?	"�.=w��t�>�:����c�AIt�U���ǆs�+ѯ��A @ܠZ�͔�����6E4���p�?����|A�e�+R��Q���^�<��H����"<w�7���Z�&��ܯ[�'�Cggfj�wh�O��GG���Z��X�u[t�k�;{�6��/��U�0�x�����@aX��CJ���6��|����뽻RB<��7��Qw��I2kW��Эa�:i*k]���F{��־r���T��\e���>�-��?���6?������B��=�n�ɖ�휤�b�v�3�4��]:n�:��0\�~�k�{ﲒ����CZ���5S��7�/t�V�ڌf�	���̹Ĉ-�,0^���>]����<"�9��D+"�@d�&
�%n���_�?�e���� W�4a���z�C9��IK|Ȭ���B�H}!^� Ln$�������d��Z[�Q.�/K!P�����z�������Ro�{:u_�p�Cν}m����$�1�[X��22�>9x��7��zw�=	��=����J��ؿ:�O�d�%7cXud����N!d,�`6�a;a
�e9D�+�7�,1րٔ�T56��̀��῕l������ApW��-�3`���s�o�㑡Q6�%Lh߃"���n��0���?��a|z0t���#4��}(�^����h��ȫ%�R
��i#ObW�ks#�_�B  �v����/7X����&9#EfC�� �E)��\�",YO��5�Q��G?�d�r�X�J�{0�˩i����*\�ɞU��JG�LZ�Ծ���ck�W��Qa<�
1�=>��Z{���Ia���Dγ*����\�טc�?�Gj�<9\w�4 �Ӣܭ�B��n2��p����6k���iV��h�C�(�  �Q4��L��C�#<����.�����C��O��K��lX��3�5ަ�imdķ���z˩s���iU��U$�W�a\���АG�Xՙ~��<a��̅�s]Y�v�g��#~�򼬉�.:a�h�YY�vr�-S�Y��!@6s%�ב����r��ǐe'Z����O��&��~�a�I��m�W���cf3�C�X���p�۠ª�N;P���M�X�b�HV�N�0�#%�ц��`���7ᤂ�<��������/�@`����}��b�����i�{�0�m�������~�h�"�XQ�
Pe��4h��5(u��C�|��n����u)ۈ�:l���VQ�p �j��(�Z�k�w�#�itw�/
C�HR�
�i��K����&�Yi����+�!��B2O{V61{��hx[�W���A�U�B���r6.X��H9�=��@*-w��n.j &��|��a�ܛ��!ʺ��@dN��	ps��O�]��E6���>�R���V,�`���<���?[!$],��t���/���*[���i�����]9���}�Uk���8J����!�KL� /�el�����PJ����J�;�#[��LkЛ�І����D���J��[ZV�0r���;�18&caJ������5��$XN�ck�U�I"Jx���YLtrG�B���2��q������E�
���ٿ�)��í��.�n,�u�9',h{��!}Zp] g;6�p���UP�~2Y�W���UL:x�`�j����ƲO�n�mіUtp��l^�j�ć��tC�/���yN}�05rѻ/;!B��@�����L)0<�PjY1ٛ��1�ţ����7��׫巷bD(��o��X��JJ+Ɏ�Ȣ��8��0�dm���w1���W�"s��C}��M��ډ�:�>-���w~�f�f&�9�Z�����ݾ�Ɏ[�s����[  �WB'�O	V=x]��:�!���!���0,f2��tE�D.P�9OM(w�Y�}!��n2d�q{�-Bl&;�}��(�p�M�b�,BKr섌����H��!����7v�3���3�� �? $�@�_"�ȷ�=9�'��h��Ǻ��N���_���Kٝ�]ڂI�D����XQ_ӄ����D���(�L��{��$"��Y��rsp-*��bn�_ko�ŝ$��
�k^<�մ�(È����N�[��ϝt]�T�$���F��Pl݄p,�	n#�ɓ�p[�&�`~9�X�9��7Z{�,D��B�����'3��=_>ܪo�(xB�85�
ً�@~��Ȝ�;�a�l�w�؉�<H�j)�6t+��G��͠ű��6Qj[��xj9ۉ�P�|�`&�L�y�\�.���f���Ŀ@�-aR88���>�յI�d�,�Kk�:�3(_(�ខ����5�q�N��R��G����J�����5�q�/L�(�P��Bo�
�� ��2R0a�(�{>-8Ļ���Y�t/��4���Y��vC�����^M-�'9 r�yX
d!8K�r��i#ٱ½# kp��LP�t�,��,2�\�W��H�<�x+�|�:,;���,�Aj�u$�b�a��9�a��E��Q��0m�z�kp��(�Y-LN�t��+�����"�%�6\�\�j[1�N�2y9����B\�:L�/u��XJ�9B�Q]��lx���a��]b6��5A�=+<��G.y4I��7B\jj�~���b�`Y������C��V�J��Р��b�U�G�q�>�7�G�#9a�pT�J�C|?r��0IYł�A�t��`�$�"s�!��B�o�_(�zAgp���oن�fY�9$�.�/�9_����X�o�7� j�u��������<m&LT���>��	5Ac5�3��~�7z٦����P�s�}�V�Z�?JCo��O@����J}�����K�!L!jǸ�	�5���U�����٧�L�X29�v%\�uH�]�1��jR��)���v.s�cTIB�� �^eש4���v�R�4��A��.��R���r�ΩI��pF����♶�a�.*g\me�k�1�Z��G�vVP��p�=������q�_�O#�¡;tEHvC���l3[���X�M���9�]��W�V�'�^���V�t�nP�締�XIJɿ��,*�:������i�J�B$5��	�#_�&��k�Yp�0)H�dF6Z�lg#:ľ���F�w�����ب��b@`���b�p�	��f
��Z�gI�ܙx��	�	\7��0[�� 9O�$>�k]���$Bl�֊;��d�ϓ��<:�dRG
�~��!F(f,&ԯ�>����`*���)�3H���eoa�\0�g;��3��މlm�e�ѩw�uK�}	/Y�j8z�J�]+�|]����#=f+�z�P(7T�(B�qս�B M#a:�f!x|��5xD�\����)[���w��6�2~.�-���iZK~;�L�nG?�8���Y�ET�$��YǱ�w���-��#Aߖڤ��xg���9�+]�8|���Hίl�g�O�&�SN�u�� 𽈶lC+B�m���3�Ǒ̸4��Nb���iR7nP=,l3��A'�}7k[ʄu��EΔ��/�xWX�l�&2�o�(;���q5)�`8�F�����.�%O�K�R^�*�3s�p�E���p�޸��&1`�{Q�V�ٿBm��o'UaJI�CXv��D�0&3Þ���B⑻R;"=y�)>6׳+�-�i���VhɟCtZВ�4���hq" /i5�H���NSm��P����6-͟V���D7�XB�;�<�	�2vЗ/�A^',�Y���x;���G�ݞm]u6D�ؖl�
����r.P^u̪����;���5�a����fm��F��ʴ�� 6DMC���	�i�0��!_p֨Ҟ�V�Z<lI�׀ �b��~>Dy*jI��w3�L�_ޕ�&BK�k���=�iP��N������P����C�N�R�T1��߆
1���Y0����mk��c�껻8���qBK���嶶^�iq�:�䘏1�P�4Js��TԚԷ�14l����ෂBD����'5E�I���r�.�)r��+�p��v��8�ؔ���{B�9��"���K��:���/������=�VJ$4rn���YwC�XҺ�FT�;^��3B��o+�T7�T��n����VVT��'<��m��E�3Ǩ�q��m�G��6���dW"�����>�ف=�
ùNp^�1Sa�����`g�Sd���~��	miD[�/ޭ��8ڲ��[���G�bv�!˚�$��Dk�qo'���Lw)�+{�6-��\u�yGlOU�D��{�^6�@�)ջ�/�Zo�+dS�+ЁlؼE1M}0��B�<��݄I�s" r�q�'��Í0gw��O�#���v�����{_C�m�Q�FF�����8v�2ɍ?�7"��B�8�Z��ܭ�n)�z���[K8���N�S�ͩ��R���X��S�I�a�~�+���6�'�\=���;7���1�1E(i���U(@�P��rO�kZ!�Qm k0�0��������l8���U}� D�e�$����|�5�m~�a�lM*ct�X*U1!ҶVL�;��Q�:v��*������n� 8���3v�  �2M?���A4h���ׂ+~D�B4��K�@���u�C�'q��!�7�FjxjKK�dǲ��K�r�j��N�[���P��km�L�T՚m��`-�JY!B�]-�0񇵅`��?Ƹ&T���x�*_	u�N;��e��4�O��3e;����!2De'��c-LzL��0�Ӡf�z�f�u��R6a�����4CH[ݚ�S_q~�_*�����>�hO� �~y�J�P)T�8���0���ȱ��iՇ��	�ɍ>!]�sؑǌ���ޤ �0xн��@�����#Z��E���_�[p/m��zGJ���_O�@�>��`�B-/ՄX:r��O;b���p��a��>�1��E�g�^x�_q&?�f`�l˩՘Da�6�m�rdOb�+�!�X�^r�;F��ҡVv"�;^6Ξ_��'4  :1uN��G��#*{�6�A8b�����S~���̝e���|�g�4��@֠�ӂ)@�!ej�l���h�d�ym}� ���I%4ĳT�^�%8eը�Q�"蕌�3㙻��~t�,^mPwE�o{B���*{��C��$���>�r�;ݞ@���068+W�éB��<��@d�zO��)��*9�V�WN��+�Y�'����!���$�����S!��FP͓���zJ df���ZFK��s*D�o*{��+�9�@7����b����7}�|��n)�wO�y��;@_�Ka*D�믘����zr��"�{�^�Ex��!Bk�S↙B�� ���eDÎ �L��f�=/�Z;k�]L���m�rn]�U��[+��E�!s>���:����f/�b��jh�Xm�	)��ɍ7V�Ih���������,��^�c�DX��-�舼Y�s�6ĥ�R�V��(L�e�;��c'��(hL�j�3�`��{�������2X��z�1�2�b�Q�裝��ܓS��}=����	�?�ِ���/i93�h�3nH&7D�訏��;W�)gox�Q�$�p@�����r[K"P�lh�uZC\I�X&Ɔ�eV\��#��M�y�3���*t�����#�*{�6�Ny�{�c�K(�L6�j;Ҩ�nK�I~b���ϨGJy´�=g�����W��(�lwi���X��ҞD�B\7�w猀8߻#��A��$�/>h�ٜ�����Q t�z^<�:zY�� ��>���+A@�������K�)�ϖ����퍞�yơ�l-6�[��\`,ĭ"T�=�9Td�m�b�ɉ�M}�k�c��A��nr-���Ee�Ex�FM1c<���ȩf����́l6'ڒw�9  m5�u3���kqH��N�2�
)F|�(�U��ή]B�3$7����6Dy t��A�#�+S�a(�[���^G��k	�$��|�(����@"�v��A�n��t��'!���w)��xo��<�g���'+���d�/Qҧ�є� �OzV��7���o;�H�#�p/T��;�-����Lz~�s�ێ�xG6��i�o�@`�WR�؊/�	U�+�fƾ���o������iiր�ke�vd�
���ڞ��Y?�(؜�P���&O��P�-��܎��E~�*�$c�i�L��=l�x�����J�l���c�TG�h�B��B���Զ�	-��D�N�rSX\m�GHpH�.���dÂV����n���&'�tr��BK�*v�gP�ō�4
a	km4���J�9B׹BT��b�	Q�M-��q�2�#�d
S&N|�_f��� W�\~�^�[ݖ��F�Õ5��zgͫH)��`}���2�<{Iٲ>H|B���+���(��ǝi�h W�N����I�[r���)(� ��A��m��3��`;k!rG�u&�(�`8�,�g��'���:%�"� Dp�_ݾ��F|ԝVV��C����� �ema�dd�F����r)���M(�%��F.�
5�_�RG��m>t�>w>�z���W�{���|��T'uCq�-��R�(�fu�)�`
�B����l��J��A{�T�)��Ӫ��e ̫Nu<�	d«�\���y��79B��w�Z?�
�B����D�\Eܛi����x��L���[O\a9�6�ߖ�]����h��"�˫�����8�/���I������D�?�'nБ-H'�)u�=!D}]TD��=�Q�:�\ :-/����F��z���Ua9���`^iiЕmt���9�Ѝ���|�A���͂���{:�EX��X���Q�N� �[���яlsZ�}�U�+�B�	��SgH��  ����Ku#�{=r.��䄼��#�i ��(m*y%"$�˚�%�-�M)rv��È�eD�yƦ-ɏܟQ��e����{5�	ϯ�#w㟪�ڪ���)6A�tP�_Ef��&SɁt 7k�]�N��)7=�d�-��;߲�xޖo؉�)���������
���a�<_$9z8E?2O�)� nw`u`0�?Z?���a�J@��.$�B�V����.j]}1�H�m��- ���u���P�L�Z֨�a@I ��;D�E���\O�v���?�dC������:}!\/TBaؒuuj���eƀL^3-a'���|�c��@�lͭ��#M�\@�]�j[%�K:�'wl���T_�W��[ʀl���a�䤜Y5����0���������^�I���^hC�!m��"�����;��[�sJFU��AX�SǑ༁ed~�G΁�-��{R�f��iқBn��{��� �=�A	�s��旴��
�7�iA���<��4���zM���,�$L{ù�Zr�/F���G��
9�:!��H ��/FO�D�_ N��k ���ӌ]���y�#O��F'r�(�|O��+�2Y�Wq���^ٗV.�#�����깩̉�N�:��Kd��G��d*���á��|���m�:>J�p�
�5XG�1w��3�2��\�kE\dV��I�_���'YB=2�鐯3C_�`F��.��+��GO[�%�\�3���#��ǨMf����@64����J	�R���Ω��
��8+2OO¢~�G��R�/)B �}��:�.'_i���'�����ZYz���/�������E{伥[#�H�*ȇ�O�?e8�RT�*���A�T#x���|����˨Z��Pfip]2\� ���R�=?>_m��Wd���{I��7���ٷ��r���BC������NW��.�������s5!����Qa�1�ؠLv��g�?j;[�^P�+r+����T�����j_[w�؝���*I(�#D�Ӷ������X�!���/\�_�>�FS�kOc[
���A� #�y��̛ٕI������}�Bgk�S/q����^�A�5�U�!��k/�~c�T���,NՂL��4%N9��;�C_��R&�c�xY����"���^�]w�� �6y���I駯ep���w/�
B�?�-�x=��
@���Ӂig��H���l���9PjA�a-�%��U�]>�(ɠ�s�n� &�P�#�h�ܬ�]�m�+
�8玼rmzXJ��7�����:i�N
�&�NrN��%8�PZiۋ��6V';����9�E����;a%�����9$���,G�r��J��Y��x��G��i'aH�4v�OX ���zoC�O>����;�,� ���D*���<�F;K���'z������7%�M]<8U	_��?R�zR6q���r3x�� i��ؿ,r6L=�$���OKw�@�b�jy:aU���>��d����§��6��;]$u���i�!�*�>�)�L=&E�<��S�{��	ŒG����)��=|G��̒,�w��(t"���O��1�I�:$�My����+H^�+�85�~W����{���O��u�!��G{:�#de&!�y��rV,^���@�T���Ϲ���a����	�Ejz�,.��i9��>HyT�5�,4�?kd��J��Sb��{��1^����"�w���p�5�5�F��ܟz�B7�[�2��{�.?�!����G�q�O�����/��ظ�Fˡ��+)��~��5&s�z��w�d�
�(��gu�i�ד�D*�gI�/'��C[�Ek/JKz�PX�:h���f��<8�50��O"�͐��fj�m��2s��>���~%��q�)Qz����w�ê�p?	�d7�n�;!�sڀ�L*jW�?rw���-w^~���I�΄������.AT0g��YR���b*e=�O���@_��z����z�[A�/X{��y�n[�CS�6��З�Z6������Nk�㑅�>Q�;E �9��t7V|	G�x�fRpA�������;,�?z��R#��O^�����n�y��!�Nv2���,y��>&M���
~��9��x����0�-�8;/�v�!�e9{�Ɋ����u\o} ��`	Y�O~d~���-�P��	:��*1��B/�^�
A���M;:�4p�JbA��#m �sI�!L�$�#U�ڡo�pp�}s;�'��J;�i���}�u����l	d�%N9vl�	�a����w����>(i�0}�+����!�{��t�v����ѝs(���"���@��@rd��0�8��6�qc� p��g��9aG'�zK�+�!^tۀ���z�j'��ƫ�Cz���1Tk�7���t���%��e�;#�
ǐ$;�#�=3$,, a��ɡ۱l�>u?=ze��5ߘ�\�����F��-A��k:�8{��څ��?[��)�
f	/�%�G�6�U�n/������`�ց����p��%����n�BTT��peB��fl{�<5 ��͚
ǘh?�Pѻ�����0;g������N'3�c�۞�x+1H���]^p>�c�=�
����BU��avM/Ψ�� �9����5VM��K�G�ҰD�z��K/ii�w�4��\�{�굸�Dސqn��}X�*���S&��~�������/)�9��0Q9�6�ӭ���52�#i����p�P�g��i�g�s٫�����?	����	Ǟ�7�5a�e� �|6駐P�1D�n���.��Cg��K�����<0xppipyxu�}���&@�G~�{�)AAZJ������s����q�����I+6nǢ�2-��p��/, ���!M����<�z{LF=�}��O�#)O�e��dN�%�v��LX?�b���ؔ��=',Um�j�����=��
��x�>�M�j?�K��[mBB�4GB��^��6�t��/�s��������cZ(��~9~��V{����%Dyk��9a-$���Ӓ��O�H�#�C׾���ÚP
�aP�o�X���]yò��/��f��9�K�p�sD��k����<w�H�b��SӤ0����O��cޣ�	��C� �-��!��eFO#�W�Lb���iZ8��Ѭ`%N�W������1��w��)q9x����/�?h�S�,/�\���`ȡ�.&X�����]i�eǸ<mZ(��������t�
l�<t�������mQ��HOp'�JUf���w��e��[.w=�{Ft1�L���:u����*<�}��mF�#��7�/w&�����p��N��m��:��7>�
��A7�@�a}c�m�o��)��y�.����{�t_�sn?v�0`>�Z�Y�� �M-
ǎ��n����Яg�p�8k@����17y�p#^�p��.�0�yq2vT���qG�p,�Y��(i��SQ���-8�:��u�H���=�,�<�rH�pl��Ac�����&���� �!f��8����s�I*���)�3.����C(c�tF�p,ο���Z���V����"e�"���v������	Ͷ?@��Fb}0�������!���ǚ�Z]<��G_(8�=>+_8���@n�Cg�wo����u�m��������+cn��'�����[��>Ĺ.K8N�� �P{�����|�v E����ݒ��6����u��"�p��A������xN�}��v��X�S�cn�4���,w)��x/Ɍ���J�`1�u��_ɳ  �� K$�sڗ��Q�]�U��o�����f`1���V��!�t)M_��1݄����Ɗ�NF[�z%�fl����`!֮���G���/e�=��]\�&���T!�5$D�v�C��fz�@Õ6h�lWf���D�6X�<�<��4 �@5^(���m6��ҏ��-p�d��%d�k�p[V�n�iB08Y�q��n��(	��5�W�-�ʜ��&�S9"�h	3\JA�\���S�\:1�xc	>�mkI��rB��2`Y�Y.�pqP����ry4/��RXE�O��\��xV d1lܞ�Z�B���3����d�D���X��Vi��(JB��38�w�f�l�?�d!.8���]�����2|����g��)��|,"�Z8�%<�,�X�#����Y k(���W��/Dl�Y�F��x&D}V#��3^��b�'�D~k8�%�,N�� ����w�0�]���ö�^�ۗ�x]���|�b�XD��;�>-!|K����/H	����r"$K����}%h����̗#(��)�BdQ_�̗G<��u�˕��o��f?��J΀}���y�	��qLp!����L�3`�Q"$��#�03���o��3`vb�����ZS��|1�Gc���=&\t'-����͂��� ,|��Q?�f��'vB\��3 ���Y�d�h��9��%u,�RB3�[�Sd�Y��Nb�ބ�#9f�!brP= 5��!J�
`z_v&�C�B�������SnI������CT���e/��T�;z�㙅g��p"�������G� 8��R��iy���Y�#�����2h�Л�{Ǯ�P�^  `��C��=�{fTa.ĽF"T���I�����;P��ߑA �f�*hO[�V"`l�;�fA+�Gɹgl|�-~Pg��1�`9!�3�Es�O�y�,Z���ȰW�P
/���COҘUKP�_�r�7�{QmPDaG����f��C`,,y>�`7�!�b��Hzo��bs��?Vg��~�;0��2��2r!�c�-*	�a11V��ސr~=��ܟQ���4DHT@}E�?�C,���z�I22xn׬���;!&c��n��;ycat�7d���6�D�?ܼ�1C����1,B���� /b�؟��%"���=F��O��gй�7C�>r.-�d��c��!��1������/<�w��8J��+���
@��;3ɀ 
gBą^W�׸��?��k )���9Y?+  X0N��A�#ĭ��T{�v�[1p���9���-*uf	L�(�H��ЊV����c��aG@.���<o�`��bC���'�4��n�y9�,���p�f�0��-���#�u\�m{�[�c,�H���\�Yޏm$��a�?�b�]z�wb������{�$a�@�F�i!v#L��#O?������ͅ�0��/C�9��BT�`DJ�=���� N�h�L�c�� y���!@��) B��=�p
��=2$��l*?�%�"�db�BT��Y}�i݀�jqا�l�����fT����&��2����D�_����W�a�0��V�Q�&�����0=�4`�w��B�S$-�ϙ����uE��>|8�af�
q>���)�G4��K�~Eru�=��L#)���������Hr��[S�[� #�D ��Tէ�;1~2z��>C��a�j{$Ű��8k�"6!����a9ƕ�>k#��C([�#���O�ݬ�p�t�� �!d����TqMfnn��.@d�>��p14F�37OJ�/���he��icX)\B��ǳvɇX��Ίq�����q���Z�
ǳ�6�pX��o,��W��1��1�k��7�Y��ƽNw�܊�����k�:�������u���o�n����]}�׿Qt ��kr[�?����xVrd#�AGW������Aq����c�5��W�	�2P��>�o��J�R2>��  <�~<�Pp!��p<$�J�����c�}qcjq��O<V'jr�S�f�a�B�w���2���7�;��7��g�Es�'���xhI��c��M)��b�ɋ櫵]���y�#6�>��e#�-���$6~	?�}<�z
�a�qL��gq�\c��~�J�/+17[�	0����
�����M���*�z���HT��t���6��=Ǭٟ�n�������g�?��v�u�7^м�c[�E��c�����o���v}�;2��Lq�]�(�!��1�V���?���}�W�/�t��+�� q��=���z3jc;P/�8Ђn'�;�3��4�Ҵ��pF�7巛E�@a`�@+����Y\�+��8�B\KE}�g�|N��<���s���Y���8}e��9��=1[� 5sF�s��?��ǘi%�s�ǆ���p9JfH���x����j׎Yd�Y��Z�K�ɿ���bb�#߬�n��>��!'�|]�Y  ��Z�m��_��۬���*Fs���0�_��H�J�^�fg�Ŀ�R;@�0|��[UOKN��|��r���i�%����{�ƍ�7������V�;񣞟5�S�h��0��?��V�9��qQl����E�F�9��v�;4�!���pw�8�u�á
�:���y�68 PK(\p�DR����9�T�5�X��t=_���R�����r�Y��z�}����e�8�v�ۆp��$��e��F
�x�U;D�8�C\��O>���I�.���6�;4ܯϱ��H_��@��%�V������d�b��4�+����R,��~g�t�YmN�&i�ޓM��&P����z�c�x�c�t;_�A���0�H�I|�m�����ToḜa�o�9P�V�s��6�Nj�+��i~�,%g %�W;��ŷ:_���<�G3 ��W�1w8��x��Es\]���Ӧ4;���yX*��ݥ�!�GZģ�q�< `9�u��{]q��u���
�|��n�6�i�Pbh�N�<��9m��bc�wS^��3�Q�W�5�!F;�:P�L�g�G�g�����Sh���.�[t=S�g�q��#��C
�S�3���� TS��:+�ݐ�?`S��88C=%V��+O#P'�Gɞ)c�<{����'6����y�f����t�ǵ�#�d#qHC�PǾ�ӻ�}�S�&/�-�,�^|����V���z��6�,��� ��N6�u�n,��MW�pU�]��K5�M���cJ�p~�����G^��/�}�a�Er�׏��!��'3�i��#/�傊����[k��%?[P������w�P��
���ɺ���/Tb��nr�6�����|����o=0�kV�JpA�|�	��+�P�v ��l��5w�`5�t@̀]��*RK!.�B<O�}���Q��z�E��L=Ö�\�H�=���X4�޸����ݿѕs�P��(Ş�o�y�u��,�6�SN�oLSr��;��f��������~�Ҩx'Ӵg�w�e����[�뾤!YZ����*g�5��&�����!^��'S���y�7c%���z�d��Ȳ�d���WZ�&�Sx�fٺ�02Μ*u�J�]A��yj<`���a����\��wٳ ���?�֓rV�6���d�Z�H!�и�Ai���0�m���ii�,��*�l�ӈ�٫�\H�t���2��8�5;��Y�oުv][97>���[�������Q�T�������1ެ�#!ۜ0����ɺ������� �	�ifa�Z��~��  P���ު�K�ݢ�(�TRe��4TI�֧��������`�����H�Gd��!fj�����{�E��Y�R�Fl��p��{�9�����S@����^��xҍ��+K�sf!8�+)�ˌ���qXI��hӞT�#*�H�s�l�`E ��#�C��Q�H� ��Q��;�jS�2Y����:7��
�%��ѽrm �]����gho%���!�	I*�.6 c�4*��}�D�����!6�	tƾ��=/���_�ɀ?<�x���cHa��T����	����f�2mڙ
l�bc0����1=�_p(Z��Q<Ӕ{�v�z�%�j��Ԝ�b�F�r���OM�P0��Ml춨B�b-@�m/�'��5.@&K+լ�n���ޘ����^��[�^�
�AĹJ6�/k��;���.���%S���Bd�� �|�蕿�2�t著�2-��۞�ߌm֐ō�]m�ܼ����nTd�����Iq��M����3��ղ;i04^Q�?:Ӈ{��W��)>�2��e��0n�~�كS�Cԏa'�����sƯQ=�uz�h͉����o8oX���_���u�*r�؞��,P�FjQ�FO���9Qɻ��.0��!t/M_c�m��  ��R���h�A�K���w����,l�0״W>tθŷG^��Aյu3����uW*.�TY�0��%959�c�q�G}	H��+)b�o�ձ�9��&��-��\4��;upr�N;�E�cXᔴ{e�5��y�$�qrhi8uf%� m�^�޾�D��d�P��ĄN�+�~�R�K���:�O�c/�댿_D�N��;0�i�VJ�T���t��ML�V'�X�;R�� �NN��3gcmZ�No�P�O�F��R������򪲄�Ы.B��|JGҙQ�c<��D���N�ܵՉ���2~�Z�#�r�3Ӄ.�B@N7�v�cY���+���2�E�W�h��KzB=������
<m�����JvP�ؿ㒛���הĞ�b�?���wL��y�8̒A���ҕ��	ӃaC�kb:DrM_���c�V��d܆�gM�/��[��s�8������/�G~�#�ڣ䡙m�hKH�_�U<�8\yֱ�=�q5~r�]������`&C!61"o��W��2F���xC=ƶ�mZA�f����&�P��B���x�*)'�ssv��B����i�Ğ�W�, ����uj�B�F����U��-�ȘR-�!>6���۽bi1�����j����q:0f��CB=�5�xW_��.���;U(v�L���\�W����*~R�AC
쒜��� )��9�S_�$3�V5!Z��+���nG��cm�V�ch]�+:ՏԄ���_��Ke�����/�u�أ�*~�dr��������z�F��a���	��Da��#�DlcP��wdc����΅4A~^^~E��glm�˜�G�G��Iӫ���X���_i��<�=<R�_�s�&���>���o5����}�S�dC5�����+������;�1��l�a��80f��3BE������G���"��m_��I`��
y�o���bG�˶w�w&���/)W��xaz�-L��d"��������Z�6/�q0�?����>��%97*wY
�9����k���5���O	�l�[hu��A�/��v���Ǜ�X��bl����|D�5���Kp �K��Tq�V�'n"0n�����Nn���il�����5@p���㦤��d4B����]w���j�9&�����c�w�^�;A}����{~=z8%��<h�,9[w;"7<�=QQ�����-�&����?Db���Ab*�� i�ů�C�4Jf!_J�o�g����� &�2�e��/K
j�D6�Hdz�G���L0L�4WW����+�}x������x�g|@#���~6��0�t����e�������/T�m�@6s�)�r7f���+6/���6�#a�xN#>7a�O�{��φ�ǧB1VFBe�m � �񑴪n�-jo)��	*ǐ8`���`"�l��]X���������~M�en{{&��)г�����x	K��X��A��梁/L{�CP�0�q'-�ʳ�3��=/2�E���K�u�;5?t�ϴ^	�)����@/*(s���ѕ���l`ͩ�݅a{\s��Ɲo�}l_��.[�64�7�P͌H8�+��f�<�?=�L��%�U�*��>�]�r=�.1}�Ѫ���= �{c�2���^�d�S�@�{v��}E1����Y2�|H�^�aa��La�$y���$c(:�+G���};�?�<��y�A�C�s�*BU;
��0z��0�J��P�c|-��w�c�x�j�lD!��?ͨ�?��z#�ï���a�Xa��i�5�dʒ-W����O�L)��iZ����oDrN�;�n����S�q������&���HR첨�X�c�{�j��L�u���+��^�L���k��ݤ �T7���P)��Y
�O�r����5��x��#H�'��2���=!�	O����3g����Dl	&�f����f�?�)L#b�!����V��*��NK���b��[��x ��������s��_;>R���7�q��R'���/����u�E�ux���;U%�R�}`�����C�vJ�N����#ʌ^Q���<FAo컗YK���ֲ�Sk/��x�"�3>h8��֜G�ޯ8�?<��[2�����K�7gb_�z.��QH���(5��(�i;,�U'<�m���1�W�=1�$�ƞ�1�G��n'��6��4���յF��p�����ŧ�z�	 B�HN(��!f�R a@Y��t7i�Y�o��֯vb�	S����h ��Qt��@]�ִ���|���_��t��dV��ĠRF1��F�x`�`z��z7j߮�{�'4_�z_ﰵ�n�x���/CxYP�5bBtV$-I)��Qz�c�eԑ��|ع6`%C�0�"g� DZ!�5��63F�Ho|p;�Y�%��C]�{@l�_��H�Qwo����i��J��(�I��x7�(���Y50��o�{g�J�0�U)Du�p��b əV������z���J#��Z��`��o�:�1�~�Q(eU!k��IN���T�l�P�<ڀ{(s8#L��H>� H#��#�E{%E�0��[wc�����`(�u--羙oJ��%XƋ E�׎��u	�ݫ�2P�`P�O;g[�?�
�`�"�̞Z�����2�)���kX���<��WL�#������3��t%�����V?�V���ɂ�+}����k1�YaY� �`���<�/����H2C��4?s�±���Pqj�m�/���E�0�BF���{%ec����<�A���c��P_�pv��N=�� �UO~1��G�6Ap�W�l��ܽ#��%���c9���U��|��zыſ#�k����z���}�&��Y���4M҆D��P�S5{�bt3v��ƫc0�\�z1j��;6��,S7�%��{S_(��ifUT}���yV
������Ԋ{��d�9O(k�v�U�S;ڳ�bF1�=�k��x)�7^x��C�bΊ���ܪڜ�;�永�c��K�j\�'�b\��ю�ņ�M�k���;V��t����tO
�YR1"���x��P`o<�,���I�l qH֧�m�r!N�>qm>(��r?Ѝ�S'�ه�=-l��Y݊������v�;ǧ;Si!����6��<��ePo��<�0��9Ҟ��k�i�_͂FB��j[��,�rg�WC���?4W^���j�������MuV�¨��b���'⹞����x�e�;�?�s9g`�L��\N�~�Y�PH�2z��@�c���q�O����.4`���yŵ��%�k�������!2�G�����s�˸ҿ7�ʴeG�fk�P0��U$�\���=,�\��'�,Ƥ��$�R�2��C���,��uq�&�?�f'_K&�_���.7�����}�:�f���O�������!�ֺTܣ�Q �P���za�;��|t���m�����zd럍����N��NC��2�\�m�}�~A5��˦7�1Q�D'�u�>�3����3�_��_itAN~�{m�����#��1Y���;��;��g8��J�5�c�Ӝ�c��O.TȲ�/��r��lZ*�I��7��_'|M�����i"2�)}�h����j�ʀdC�ay��vi9��$����/L��1Ǩ�t���`7F^�D�/��L>t��w?zPv�я���5����r?>�������� oZ�K���T���eѫ�YZ�$w��_�2v�]��?;ȇƧo��j�tO Pp�]vO�T�Z����c�)�K��R[Q�x�O���u����U٥us#)��HA�D���qBK��"��<�>s~J��H��7a���>������NK}�����.����KN��Gj�W�ƹ�@q�$��*�,R�����Q�6�<I�8�zSm�[I�4���'R)};M� ����"����@&�O�P�Be=0��������P>���p|���B�X����`hg��:n}O�h�&]��I��َ7!|ހLlj���#ˉ�xB<�ӿ��<����?^3�R7euxc'�&lP�+��rӟ<�מMWF��Hz���.ɿ��F��$_�4Q}$y��k"���Y��԰#�<� p�6�6g�� �=W�����b ���_#�h�D��>�[Nڞ��S����!�;X&�Kײ��#~o��?)l5U���t�5� 0pYwr;�.>]�gc��>��ߘ���@_<%���E}�m!e�}�߾�"��+����	�>J�%?�p�;�0�},p�� "H$,��1�<;0��◽6��,c�f��1ml/�g�T0D�$�%�{w��:�9%4�$�lZ���� �����c���9#T��867>N����V���ɬ�Y�����P攞Z�����QT3�6� Ea��M��حՁ30@�B�;oCG���A�m�����hk��q;�<�=�a�|�O��<'/����S�j�´�)�!�7_Ȝ�>���^�=F~��G�3v�-����@Y����?F�)��jXW��v_�X0־�yR\�!�v���ʠ�K;�Մ��6���s�۱�=�׸�!ԋ�7% �axN���Y2�*�h���x�V�>��6���ؾx\&���Kǧ�������Φ�����?sj�^`�QƎx�o���D\U�j��RBy��:���ӷ��F����)��d5#�O���°��F�VH��R8�!�(�-*K�/Q�0���?�2v�)����z���G?1h���P/a\n���׍A�7�y�f|.`�?��Ζ��C�@"�g�N��n��Kҷ��SƏjV�J�5�p�>�,����a�8L��ɑ��+�ʝ���!M�pu�G��"7�t3��ţ
ϝ)�	�m��&�i#����Mv���7ɐ�a��~�)Z��s;/����'��T�� �n���HIM���|�V�3�혳�k�4*t�աKS �a�Dtκw��H�0�ݛz�$(~l�(F��}kʠĠ�x\1��_[��4`����N&9�kO(pp��n��x&td ������8e���x#Hh�^�¶`Q���5�Y2E��j�~�E͇��P��R"t��f[��� ����\M�G�#KC-��5iӊ�8��oB$3��g��$3(K���/m*���c�Z+t�'b�]t'a>ս�x1�>6�W�Mp4��mO�3��w�oĕ�����﬍߷�A!�LQ���V�7|Wr�a�-?Rw~Sp
�:���a����N�[���D�%H�����}Y��=&�N�+����v�3���r��4�~��&��8T�GTʠ"���#��Ҫ�����س]��˪��Z�)۩T:���O:i��$�L�a�9�lq �Z����&��3D5`IDn	܆����^�}��=��)�bۜ
�G
_�J���t��v��e����L�:�sA���ڭ�[�\Y����z> ������N#Sہځ7�/��J���)�mdCl4q�7=�V�ɢ/S����%�3��+��/%����R\s®T��SL
L��BV�5,��"MJy��v��uSr��^��	xwt���dOJ�g���~�������{��D�MXM��n�-��m�^�@ ���w�e�`���;����	��LM� 9B�ž	���Y��F�i�Ojd�S���R�n��"��Ö'ixZ�f��.���%����S
g6ޗ~�܃��;������*-a:�xѣ�7����.��V4j�Ϛ�X��߰�B=����V�B��<��	�")��!6�"E���� �.��R�z�*�W{'�`�u�T¬m}�Z�0��a�kMDǈ��?tʠE��x�1Zm��u%E~��ʷy��wt�hZ��-[�(��� Cw�:!�3+W�d��P}mң�s�C}�~;p �u3
�V���j��"��x݄y�X0�?�̠=�ś��+68v��ju%�tX�2Q�(egq��g�	���fC&��?kiu�v��.�u
X�f>����&�#]�o8�~�չn`!�Aۛ��SC�B�hSl��e�92�"�'�9�=��wPeW�q`ב����,��\���]牱���@%g�M���qvK& -��`�-qg��X��
�3|��H�g-�Ig�8o	��	�$���(mmf��$�e��1�f��]}ܝ���^�`�G���]����W*uA�0Y���j�������Y���%.`(����A`��fX_�ISo�x(L#C�!��~R���r{#�QcT������w�m�g\���[�z���/{��"�҅Ɏ�ؑ�L5B�䨉�#����ߧ��#�lڬGKδ��Co]����0�]��X����8�
��Lq��1��1�7��3��zا֦�c�W�0;��$�h�m�mz�I��G�r��.��`�5iZ�0#K*% �ȗ�>�X	��k��͙�B��,<��rz����q)�:��uW�L��8�Xÿ���#�d"Z-�`�V�	�)pƓ~���:�J����ކ�`�����3��/cv�qt�o���l���:a�,vXG7��A�b�>z蠅j����|��e:�4��D��qi _�a8��e�q��]l�]�fA��*��cȊ�<z�c�ΰ{���я[�g�Icp��=���	���Փ,̈��V���(HŠ��G;�i�
����y6;z��7b���g��{��R���F�ʘ���=��ȑ0CX��$�=[���r���W�¨cz-d~��=a��7l��.F����Y���ˇ��ߨ�EG�ɣ�iۀ�����$J1"f�]#��4m������;飄�c^�z&򱈿F�&�����^�pE�%��fm�>'笼��O�n)�T��t�l>���fKI���e��¬8Ɍ���Yx��|SƬ�.�h���c��5+f �!�Ɓ0#"�̊�xBC,ȍ�9��3��lcP�_�bVb��c! W]��M ���=�j�hF,�"��823��nF�^gI�1��<�s��1p����W9�a29C�Kd� 
d��Ќ��31����w�����z�1ZFj3b��C�F(�A���ؑ���p����qᱻ�aG^1�������Y9�>�"8�0c��:6R�&DT��{Ix6LrC$���x��3aɚ�!>e���LXr&8D�HT�A�L�f���8�L�E�f��=DU��̏��O�,X
�)Dc���K�X���	�2HK^�`�a�?�v��#�f��E/�X����oK�����e`e�X�B1���q5�y,5!w�D����c��?���!v3@h�ܭ�x��ADB���A���_�y����F���r�G��	�b�5�%�;!�9 d���\��r��!�Y�e�1`�K�BP��'���|��F�H�@Ȕ�[��z��V��<b2�M��^�����dMޜ�����y|7�3N�xI�A��/�|�;s���3^�0�)�g�_\����!��,����֞�w�w��D�g���iܗH�p��L�E�J�,�ݘ1�[[~<�x�ȩ�"7y��
�P����B��\���xEj>s�h��5^�h.�n���Ԟ4]�чV�����%�9�u��� +��\k�ݬ�(�	��\m�r�7!�D�����K��q�iꁂl�`v�n�iEP2A"���;uS|�(�1��
�iDCD�4�jF��o1�{O6�4���r��!|�D�
9�9�����^:�ȶP�g�C1�y>��D�}[�@ns�6�0!����z��2��7xPH�ybѦa�0�z���K���d��nE���M�W��/�������r�,P��7��B<ΡӳrK�h�D}�˚`Jʶ\�3@f�B �f�l-.�tT�g��lA�;'��=O�� 
&�K��`�Cz���-��V���X#ȗ��J��Or�,�z1����%d�)lTp�٘��o���I�G-B<�	�I/g8?7�pI|�.���D�A:\6�s��_i�V�+�t#㱔��){�2���|�*FެϑWP#D���_�cn����ZP[���,�e�����`����V���(�~�B2�O��!�l� g��/B���������#��
�˟ȴ��byX4��]��[ �+��W�����C�"����O��q�ǣ�U�����34 �L�D�J����a^8kP��L��8Gi���wܒ?�*�J)^�$�Ғ�S�����P|T��߰�L�;�IrCܰ0G♯�w�˚�I�E�o��(/��I�̄km8mKv����m��ѕ��G�)\�dB�M���aġ,I�����k�g�N���%Js�<*� �[ B����i��ɍ��<��'�8��\(����� N湲�2g����Y��@�jWh�Ap��ܣR�!2@$�٧*�2��1�!�EG�ˎ4��<�`[�D�l��r�Vc�2�� .Hy���m?�y�u���_d>�GP�@��u�Kj���w��:�k���bkZ
�Om�uK�K!�@\) �\�_9�n���	Ȇ��Ӟ��BF-	�f��
�'��]ʂ�, ��qC(�a%3.B�l=�?W(�[w���:^�L��i[�r!�a��p��qde�gʜ�p����>�M��տ��v��FH��ߡ����3G�5�IK%�#�A���2�m�Ԡ��9E\���4��~sѣh�>�G������'�F���n[F0���:��} ��� ����.	���;s!sg�bP'�/���.xA�l� a�D|�)�1hόŰ�*?@����p+��aH�j�3��V���"�cl����ݍ�͹]�p��7�V������G]Ź���6R+n5U(��<�EĢcx�b�z���g�ūύ�ˣ�$��&i��"D�T�

ZH�Xi�Q�m_�Q�f�Ǩt|vB����6�=�y�0_��\}�1y��/xF"$�$��Z�� @T�Vg!�*�4�H��^��,if{�9`M�Ǌ�y�-�c�G��NE����7�,#7�)X��B�.">�4���m������,n�$j^X-�	�5.�V�n���<Z����)�m�>q.�[�Y��>H���&90 ��d�W�����ɗ��}�7Z<v�Tx�����"f<�8!�g�0���Ӧv�}�G�gm�+���Q����u��������*��L���Wۃ/�oo�ݗ�R��>����;�D� ��Z�[VZ�l)a*�CL���pu[W4S�Z/�O�n-��3��9�kc�z�(I�%��$D�k���?�8[޺�����y���-��( ���rp^-1�$8t��0�l�rd^Aj�U���A��xS���ppύ15?�Y^�+�E���f �;��� \��ɀ���6�-#��v�V� Y��
y�p�ٔ2aK��JW�0bw�)�87;B^y����|��ȷ�"�}=��x\�oP�����~쇸Nnx- �U.��z1r��/M�y�pr���)v�J��&�c?�/�<=A/��c�D���k�9F�.$6k��b��*�T��������?v����;p�es�2ՑM��g R+�։���X��-V���c��c:(|��`��3���a �(a"ղc}h]��<�=ݚ�0(��0~�pJ)���u(^��,�H����- εr۳������<��;s�H�
�wL�|�݈	$F�f!�1�A��6����PV�� �_��>���t_J�{���!a&B�bW�q��Sy���\hò��7�a��uU8E{q�%	�_?��x(O����b <S|kV�4��j!�c/���H�@8��`6��96�FN���!mF�/I9���m��\譜�$�,0���a���������8�q�5.�H|�
�BERmK�#s��Ō�Y���:-��UZ�ar�k#W$���.�JH��rAɌ��� rk��/}K�Dȸ���_$tt�2A�Co`�s�.T03!ܞ���w�u��/�f# �Pe����� M`85~�@q(�������4v��cnr�ى�p�É����$����rB�|�m�jp�qa�G(� �T�����la�B�@6��g2ZH!� ���L�(��5�#�[
f�6�>x��,�(�L%;��٠�>�-�5��q�?�	��cּ,��Ht�G��]��f�f,�~aV$F�rJ���o	��eE~�24p&����
�����0s�J+@60�H)���G`����_O����3'�[
O�nڙ�����U��E��]����Cc��(<�y�Y� ���D�>���!L�7ʃ��g� �o��=<�:�&�R�z�P2 �$�cx�W��6A@�f�òʜ���Y�M� T_�[�_=�!���+� �-���	b`�' �oH@��C���,�x�Rވ��mdG/�R�%��4���J�e�X}O��k�� cũ�Q�� h(o�~�c�O挄�ߣ��)��?�J��u���:uV�Œc��������x� `�#~����2�\���$��Ku���V���/<M���9Ce����,S�R�����Ӳ���S��  3�������:�6̓��g��I�d�}�fE�Q@Y ������z�>{F�$�2�5���E�����2��8�y|�cɄ[���A�Blÿ�3G^�S��NH�Uwo� ��M�Iҫ��Q��(H����_���F�;��K�p'7�[P@���������{=)&G�� s�P��:P(�A��N��$�����g#��ΑW�ޘ����f��q^�dn��@�p�$u$�6"[��v!=��f�-iI���}���eH&��R� ��_qv1�T���<�EB���}ƨ 'TO���%u�6�.�f��G�kj:h��?����i0 �>�PD86���{SY#,�ߝ���M���}WI篲ߚ�_�BDB�l��$��S�`�/�]��<�]�b^��Y7\	��n�hr��ř2���M�/�\��{�ם{�d}��v��`H�I��VH�q��d=ȇP �.�@/�#�"�s���36{\����Fհ�k^���0F|�4�O���0"�FV =	&�&n�����l�����'�E�0l��pKA"�{  �ۄ>Q��*xQ 
Л�d�&R�/����m�U�c����_��}˒U�����(y4�O��﹁zx�B���.D:���,��迤w�� s�vU���c�;\cE��r�餏A���<��g�l�D�A@Z��\FM\���Qv�Ҩ��&}����'4��%ԉb�ٝ���ڙT����k -�%2MR!|�9���5!���<t�a�J	���H�O*��,KE�}�6_k��O�/�QM<��h��j��#7C7�d�-�@�	����d���w(��<R��NI>��ɇ/�D(��x�Q��*�L����7O�Â@�ieЃ�`�FR@�yѧ�K��H����y�'8dڠ�>�R
�.~�S�ǈ����1��C�~��9d�Z�p�ӽR�>�ϕ47(��%Q�	�k�5y<���lfғ~����quL:����|Ą ��fЇp�$���hx���*�kjk���H�}b�-C��u6�Q��]bx��
r�<���s�F7�i`�'�g(��D>sF���Y�#�d��RJ����:��z=��ɉ�l�*ټ�T��c���/<@k����
���"]`��a���U���WSCͷ�����7�#��/xQ�ը�u�^���`��� )��'�f��d��C��6ݟj��u�(��D+pU�q,�R�~�O���dU$rQ�J��0��Mޣ�'��2�Гp�$�`🳸P�*��,iio����i�'�a���G<.���y����3;�|�E�Pǉ�d^_f��G�a�E�f���?RK��ˤ㽋��by�o�y̕M�sL�\m7�y�s�q�3��=�8�� =	,���T�s۵���}mS`J��A�2��."�i9�?>w{�B9������	�
�9�H��5��y�A�F#l�zh,�K)�xbt�ҏd��>(���)2�����[�b�j�[��]��������N��|�8�h��q1�q&,�B�� �A1	�b��z��od_�_R�\���J�����nٕ0��oZ�m{�'��`��J'	m����<s����4x��I��6��	�,�O�ᰨ�]�n���v)&m�09����r���b�I��]�_h�f����D��H�3�e9��E�ۈ�����,�@��5Fi$�HP��m����$�F�mB*J���&�X�qV�Ӳ�3�7��7%�2&ڍ<�G
�\�D�׎�7Ns�g�a�/�T3��OA�1D�h��TBp�x��
w��C�C�UUMtM!)�b[IK�L�]��㒻�G޽������j���v,�)2��)_��x���h�'����!�2zY��-8b�QZ(&�`�1ZT�.�C�G%ߓR^����5�2������x��w���kuJO��")�^�z�#���Y�>j��ÖW|R���Í�8�#$�ÅH�ha�]x@K�馎B҈�GL5�*ߠ�3�G_U�\M�d�P)0śc�m�8�2��A%�'��|c��Ju?��^�͹-Wy���EM�٪�G��<E8!���=�θ���BU�	 �jY��8���#�SEI�����g�]-y���?>%��r{�Fj�@+]��a&���R��v���θ�[�K�!�?dy쎫�9�]�)U���m�����md����o>{��Oo��
qT0�"I��F��f�j�.J�E�;|	R����/��ۼA܈$�:�X�LB��V�� 4P�L��&\��]T�]'q�؅o�&��7?~�K�ߋ=��	�g>�,�C�=��T>W۫yHw�`h�,��)��t�-��?�ꪋ.�99�SrL��!9h�}�Kv�j��6�$�d��V#ˑ��p�9RTJ�";�^}��?>�ɓk���d�S^"��PD]���W�$�*ig�yv` 6S�"7����'� |�Yn�y�AA6���10�A t(q��l��2�2�43�e�yXd�%�!��*k���&[l��.{�s 6�g�
�|ܑ����{������M���'H���cp,\�i%*<�7�6�=�
Hg�k��&/��&Vx	�
:g�1��% C����+H������p�_��CDQ<z�!�,�hf��9�?�/l0L�xc�w�κ���Ѐt��,�y��P�|� �B�������2G�d�:����M������$|�Ϝ�6�E%�1�7�'X*i���Yf�c�sDAa�y�覞b0���� �s��'�}d_"'��_8�7��?\�.OFy4��3���w| �H�H"�,�)��i��~��3�ˬ��>p�!$Hq�1ǐ!C�*4hСÀ&t���D 0�C��I+�PN1d�A
�D�����b<��q����Xrl}�  �
5u[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dnr20t153it5i"
path="res://.godot/imported/Icon.svg-62b5bc5b7872f9c089f3b98f0084a03c.ctex"
metadata={
"vram_texture": false
}
 ��o��8�)|�k@tool
extends EditorPlugin


func _enter_tree() -> void:
	# Initialization of the plugin goes here
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
Wb��MEX���r�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script    
   Texture2D    res://icon.svg ��\H���T      local://PackedScene_xqxgn 	         PackedScene          	         names "         test_scene    Node2D    Icon 	   position    texture 	   Sprite2D    	   variants       
    @D ��C                node_count             nodes        ��������       ����                      ����                          conn_count              conns               node_paths              editable_instances              version             RSRCP}�+e�_�_�RSRC                 	   Resource            ��������   LicenseLink                                             
      resource_local_to_scene    resource_name    script    link_files 
   link_dirs    link_paths    componet_name    extra    license_identifier 
   copyright       Script .   res://addons/simplelicense/api/LicenseLink.gd ��������   Script %   res://addons/simplelicense/plugin.gd ��������      local://Resource_4ksin �      	   Resource                                                                Simple License                    CC0-1.0 	               2023, GradyTheDev RSRC�uY��~����iGST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[  6�P��Fv�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cs78m84tlyy3x"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 EZ�x�����'�Y[remap]

path="res://.godot/exported/133200997/export-519f25f0647bff362aaec36756b0d6fe-LicenseGUI.scn"
YO!U]�ܐ�[remap]

path="res://.godot/exported/133200997/export-cab212ca14e0231956191525e5cfcf33-mod_1_license_link.res"
�[remap]

path="res://.godot/exported/133200997/export-57541083bd4f9efeb254d7f28843258b-test_scene.scn"
=�sؔ�8�6[remap]

path="res://.godot/exported/133200997/export-06633fdef9cfd93aa6de8bfde056a1af-SimpleLicense.res"
]g=���list=Array[Dictionary]([{
"base": &"Resource",
"class": &"License",
"icon": "",
"language": &"GDScript",
"path": "res://addons/simplelicense/api/License.gd"
}, {
"base": &"Resource",
"class": &"LicenseLink",
"icon": "",
"language": &"GDScript",
"path": "res://addons/simplelicense/api/LicenseLink.gd"
}, {
"base": &"Node",
"class": &"LicenseManager",
"icon": "",
"language": &"GDScript",
"path": "res://addons/simplelicense/api/LicenseManager.gd"
}])

!�ߟ��w���<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
�_9�]$ʜ   �F&��!.   res://addons/simplelicense/GUI/LicenseGUI.tscnC�T��,U   res://addons/simplelicense/mod_example/licenses/license_links/mod_1_license_link.tres\����rw#   res://addons/simplelicense/Icon.png�z�H�*�p#   res://addons/simplelicense/Icon.svg���۶�>]   res://code/test_scene.tscn7�?����5   res://resources/exports/Godot Wild Jam 61.144x144.png�u��c|!5   res://resources/exports/Godot Wild Jam 61.180x180.pnga~�!��5   res://resources/exports/Godot Wild Jam 61.512x512.png��2�
��r>   res://resources/exports/Godot Wild Jam 61.apple-touch-icon.png�:i�y2   res://resources/exports/Godot Wild Jam 61.icon.png����J�	-   res://resources/exports/Godot Wild Jam 61.pngDLb�׵}9   res://resources/licenses/license_links/SimpleLicense.tres��\H���T   res://icon.svgb~yЂw�$ECFG      application/config/name         Godot Wild Jam 61      application/run/main_scene$         res://code/test_scene.tscn     application/config/features(   "         4.1    GL Compatibility       application/config/icon         res://icon.svg     audio/driver/mix_rate.web      D�  !   filesystem/import/blender/enabled          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility�A�5ٛ��l3��V