fx_version 'cerulean'
game 'gta5'

description 'FirePack - EMS - MRSA'
version '1.0.0'

files {
    
	-- text
    'dlctext.meta',
	-- sounds
	'audio/fpmrsa_sounds.dat54.rel',
	'audio/fpmrsa_game.dat151.rel',
	-- anims
    'anim/clip_sets.xml',
	-- scenarios
	'ambience/loadouts.meta',
    'ambience/vehiclemodelsets.meta',
    'ambience/ambientpedmodelsets.meta',
    'ambience/propsets.meta',
    'ambience/scenarios.meta',
    'ambience/sp_manifest.meta',
	-- vehicles
    'vehicles/vehiclelayouts.meta',
    'vehicles/vehicles.meta',
    'vehicles/carcols.meta',
    'vehicles/carvariations.meta',
    'vehicles/handling.meta',
	-- objects
	'stream/props_mrsa.ytyp',
	-- weapons
    'weapons/weaponarchetypes.meta',
    'weapons/weaponanimations.meta',
    'weapons/pickups.meta',
	'weapons/weapons_fpmrsa.meta',
	'weapons/vehicleweapons_fpmrsa.meta',
	-- peds
	'peds/pedpersonality.meta',
	'peds/peds.meta'
}

-- text
data_file 'DLC_TEXT_FILE' 'dlctext.meta'
-- sounds
data_file 'AUDIO_SOUNDDATA' 'audio/fpmrsa_sounds.dat'
data_file 'AUDIO_GAMEDATA' 'audio/fpmrsa_game.dat'
-- anims
data_file 'CLIP_SETS_FILE' 'anim/clip_sets.xml'
-- scenarios
data_file 'LOADOUTS_FILE' 'ambience/loadouts.meta'
data_file 'AMBIENT_PED_MODEL_SET_FILE' 'ambience/ambientpedmodelsets.meta'
data_file 'AMBIENT_VEHICLE_MODEL_SET_FILE' 'ambience/vehiclemodelsets.meta'
data_file 'AMBIENT_PROP_MODEL_SET_FILE' 'ambience/propsets.meta'
data_file 'SCENARIO_INFO_FILE' 'ambience/scenarios.meta'
data_file 'SCENARIO_POINTS_OVERRIDE_FILE' 'ambience/sp_manifest.meta'
-- vehicles
data_file 'VEHICLE_LAYOUTS_FILE' 'vehicles/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles/vehicles.meta'
data_file 'CARCOLS_FILE' 'vehicles/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'vehicles/carvariations.meta'
data_file 'HANDLING_FILE' 'vehicles/handling.meta'
-- objects
data_file 'DLC_ITYP_REQUEST' 'stream/props_mrsa.ytyp'
-- weapons
data_file 'WEAPON_METADATA_FILE' 'weapons/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'weapons/weaponanimations.meta'
data_file 'DLC_WEAPON_PICKUPS' 'weapons/pickups.meta'
data_file 'WEAPONINFO_FILE' 'weapons/weapons_fpmrsa.meta'
data_file 'WEAPONINFO_FILE' 'weapons/vehicleweapons_fpmrsa.meta'
-- peds
data_file 'PED_PERSONALITY_FILE' 'peds/pedpersonality.meta'
data_file 'PED_METADATA_FILE' 'peds/peds.meta'

client_script 'names.lua'
