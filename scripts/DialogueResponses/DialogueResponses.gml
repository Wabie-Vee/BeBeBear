// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DialogueResponses(_responses){
	switch(_responses){
		//nothing happens / end text
		case 0: break;	
		
		case 1: NewTextBox(global.catty, ,"You gave response A!"); break;
		
		case 2: NewTextBox(global.catty,["3:Yes!", "0:No."],"You gave response B! Any further response?"); break;
		
		case 3: NewTextBox(global.catty,,"/s/cRFUCK YOU..."); break;
		
		default: break;
	}
}