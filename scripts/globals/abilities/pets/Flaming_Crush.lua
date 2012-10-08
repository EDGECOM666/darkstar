---------------------------------------------------
-- Flaming Crush M=10, 2, 2? (STILL don't know)
---------------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/summon");
require("/scripts/globals/magic");
require("/scripts/globals/monstertpmoves");

---------------------------------------------------

function OnPetAbility(target, pet, skill)
	numhits = 3;
	accmod = 1;
	dmgmod = 10;
	dmgmodsubsequent = 2;
	
	totaldamage = 0;
	damage = AvatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,dmgmodsubsequent,TP_NO_EFFECT,1,2,3);
	--get resist multiplier (1x if no resist)
	resist = applyPlayerResistance(pet,skill,target,pet:getMod(MOD_INT)-target:getMod(MOD_INT),ELEMENTAL_MAGIC_SKILL, 1);
	--get the resisted damage
	damage.dmg = damage.dmg*resist;
	--add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
	damage.dmg = mobAddBonuses(pet,spell,target,damage.dmg,1);
	totaldamage = AvatarFinalAdjustments(damage.dmg,pet,skill,target,MOBSKILL_PHYSICAL,MOBPARAM_BLUNT,numhits);
	target:delHP(totaldamage);
	target:updateEnmityFromDamage(pet,totaldamage);
	
	return totaldamage;
end