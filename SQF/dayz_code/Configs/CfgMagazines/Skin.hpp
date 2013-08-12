    //Base parcel class
    class SkinBase : CA_Magazine {
        scope = private;
        count = 1;
        type = 256;
        displayName = "Clothes";
        skinModel="Survivor2_DZ";       //the base model this parcel changes to
        skinModelALT="SurvivorW2_DZ";   //female version
        heroSkin="Survivor3_DZ";        //hero/male
        heroSkinALT="SurvivorW2_DZ";    //hero/female
        banditSkin="Bandit1_DZ";        //bandit/male
        banditSkinALT="BanditW1_DZ";    //bandit/female
        isHumanitySkin=0;               //is this a humanity skin
        tearChance=0.4;                 //base chance that this item will tear when pulled from a corpse. 
        model = "\dayz_equip\models\cloth_parcel.p3d";
        picture = "\dayz_equip\textures\equip_cloth_parcel_ca.paa";
        descriptionShort = "Clothes Parcel";        
       class ItemActions {
          class Use {
                text = "Wear %1";
                script = "spawn player_wearClothes;";
          };
       };
    };
    //Base polymorphic suvivor skin
    class Skin_Survivor2_DZ : SkinBase {     
        scope = public;
        /*
        skinModel="Survivor2_DZ";       //the base model this parcel changes to
        skinModelALT="SurvivorW2_DZ";   //female version
        heroSkin="Survivor3_DZ";        //hero/male
        heroSkinALT="SurvivorW2_DZ";    //hero/female
        banditSkin="Bandit1_DZ";        //bandit/male
        banditSkinALT="BanditW1_DZ";    //bandit/female
        */
        isHumanitySkin=1;
        displayName = "Default Clothing";
        descriptionShort = "ordinary clothing, nothing special..";   
    };    
    //Camo Soldier
    class Skin_Camo1_DZ : SkinBase {
        scope = public;
        displayName = "Camo Clothes";
        descriptionShort = "Camo clothing for keeping out of sight"; 
        skinModel="Camo1_DZ";
       //skinModelALT="SniperW1_DZ";        
    };
    //Camo Soldier
    class Skin_Soldier1_DZ : SkinBase {
        scope = public;
        displayName = "Camo Clothes";
        descriptionShort = "Some camo clothing with a old helmet."; 
        skinModel="Soldier1_DZ";
       //skinModelALT="SniperW1_DZ";        
    };    
    //Officers Outfit(rocket unitform)
    class Skin_Officer1_DZ : SkinBase {
        scope = public;
        displayName = "Officers Outfit";
        descriptionShort = "An old military outfit, not than ranks matter anymore.."; 
        skinModel="Rocket_DZ";
        //skinModelALT="SniperW1_DZ";        
    };
    //Sniper outfit
    class Skin_Sniper1_DZ : SkinBase {
        scope = public;
        displayName = "Ghilisuit";
        descriptionShort = "The only outfit a stealth needs.."; 
        skinModel="Sniper1_DZ";
        skinModelALT="SniperW1_DZ";        
    };
    //End Dayz Original skins
  
  
  
    /*
        class Skin_BAF_Soldier_MTP : SkinBase {     
        scope = public;
        displayName = "BAF Soldier MTP";
        descriptionShort = "BAF Soldier MTP";   
    };
        class Skin_BAF_Soldier_DDPM : SkinBase {        
        scope = public;
        displayName = "BAF Soldier DDPM";
        descriptionShort = "BAF Soldier DDPM";  
    };
        class Skin_BAF_Soldier_L_MTP : SkinBase {       
        scope = public;
        displayName = "BAF Soldier L MTP";
        descriptionShort = "BAF Soldier L MTP"; 
    };
        class Skin_BAF_Soldier_L_DDPM : SkinBase {      
        scope = public;
        displayName = "BAF Soldier L DDPM";
        descriptionShort = "BAF Soldier L DDPM";    
    };
        class Skin_BAF_Soldier_Officer_MTP : SkinBase {     
        scope = public;
        displayName = "BAF Soldier Officer MTP";
        descriptionShort = "BAF Soldier Officer MTP";   
    };
        class Skin_BAF_Soldier_Officer_DDPM : SkinBase {        
        scope = public;
        displayName = "BAF Soldier Officer DDPM";
        descriptionShort = "BAF Soldier Officer DDPM";  
    };
        class Skin_BAF_Soldier_Sniper_MTP : SkinBase {      
        scope = public;
        displayName = "BAF Soldier Sniper MTP";
        descriptionShort = "BAF Soldier Sniper MTP";    
    };
        class Skin_BAF_Soldier_SniperH_MTP : SkinBase {     
        scope = public;
        displayName = "BAF Soldier SniperH MTP";
        descriptionShort = "BAF Soldier SniperH MTP";   
    };
        class Skin_BAF_Soldier_SniperN_MTP : SkinBase {     
        scope = public;
        displayName = "AF Soldier SniperN MTP";
        descriptionShort = "AF Soldier SniperN MTP";    
    };
        class Skin_CZ_Soldier_DES_EP1 : SkinBase {      
        scope = public;
        displayName = "CZ Soldier DES";
        descriptionShort = "CZ Soldier DES";    
    };
        class Skin_US_Soldier_EP1 : SkinBase {      
        scope = public;
        displayName = "US Soldier";
        descriptionShort = "US Soldier";    
    };
        class Skin_TK_INS_Soldier_EP1 : SkinBase {      
        scope = public;
        displayName = "Takistan INS Solider";
        descriptionShort = "Takistan INS Solider";  
    };
        class Skin_TK_CIV_Takistani01_EP1 : SkinBase {      
        scope = public;
        displayName = "Takistan Civilian 1";
        descriptionShort = "Takistan Civilian 1";   
    };
        class Skin_TK_CIV_Takistani05_EP1 : SkinBase {      
        scope = public;
        displayName = "Takistan Civilian 5";
        descriptionShort = "Takistan Civilian 5";   
    };
    
        class Skin_SniperW1_DZ : SkinBase {     
        scope = public;
        displayName = "Chilisuit Female";
        descriptionShort = "Chilisuit Female";  
    };
    
        class Skin_CivilianW1_DZ : SkinBase {       
        scope = public;
        displayName = "Civilian Female Skin 1";
        descriptionShort = "Civilian Female Skin 1";    
    };
    
        class Skin_CivilianW2_DZ : SkinBase {       
        scope = public;
        displayName = "Civilian Female Skin 2";
        descriptionShort = "Civilian Female Skin 2";    
    };
    
        class Skin_CivilianW3_DZ : SkinBase {       
        scope = public;
        displayName = "Civilian Female Skin 3";
        descriptionShort = "Civilian Female Skin 3";    
    };
    
        class Skin_CivilianW4_DZ : SkinBase {
        scope = public;
        displayName = "Civilian Female Skin 4";
        descriptionShort = "Civilian Female Skin 4";
    };
    
        class Skin_CivilianW5_DZ : SkinBase {
        scope = public;
        displayName = "Civilian Female Skin 5";
        descriptionShort = "Civilian Female Skin 5";
    };
    
        class Skin_Civilian1_DZ : SkinBase {        
        scope = public;
        displayName = "Civilian Skin 1";
        descriptionShort = "Civilian Skin 1";   
    };
    
        class Skin_Civilian2_DZ : SkinBase {        
        scope = public;
        displayName = "Civilian Skin 2";
        descriptionShort = "Civilian Skin 2";   
    };
    
        class Skin_Civilian3_DZ : SkinBase {        
        scope = public;
        displayName = "Civilian Skin 3";
        descriptionShort = "Civilian Skin 3";   
    };
    
        class Skin_Civilian4_DZ : SkinBase {
        scope = public;
        displayName = "Civilian Skin 4";
        descriptionShort = "Civilian Skin 4";
    };
    
        class Skin_Civilian5_DZ : SkinBase {
        scope = public;
        displayName = "Civilian Skin 5";
        descriptionShort = "Civilian Skin 5";
    };
    
        class Skin_Civilian6_DZ : SkinBase {
        scope = public;
        displayName = "Civilian Skin 6";
        descriptionShort = "Civilian Skin 6";
    };
    
        class Skin_Civilian7_DZ : SkinBase {
        scope = public;
        displayName = "Civilian Skin 7";
        descriptionShort = "Civilian Skin 7";
    };
    
        class Skin_Civilian8_DZ : SkinBase {
        scope = public;
        displayName = "Civilian Skin 8";
        descriptionShort = "Civilian Skin 8";
    };
    
        class Skin_Civilian9_DZ : SkinBase {
        scope = public;
        displayName = "Civilian Skin 9";
        descriptionShort = "Civilian Skin 9";
    };
    
        class Skin_Civilian10_DZ : SkinBase {
        scope = public;
        displayName = "Civilian Skin 10";
        descriptionShort = "Civilian Skin 10";
    };    
    */