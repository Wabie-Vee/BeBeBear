// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function InitNPCs(){
	global.coolDog = {
    voice: snd_CoolDog,
    portrait: spr_CoolDogPortrait,
    name: "Cool Dog"
	};

	global.catty = {
	    voice: snd_Catty,
	    portrait: spr_CattyPortrait,
	    name: "Catty"
	};
	
	global.bobbin = {
		voice : snd_Bobbin,
		portrait : spr_BonniePortrait,
		name : "Bobbin"
	}
	
	global.normal = {
	voice : snd_Speech,
	portrait : noone
	}
}