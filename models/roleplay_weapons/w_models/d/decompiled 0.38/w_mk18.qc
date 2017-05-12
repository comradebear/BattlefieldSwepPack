// Created by Crowbar 0.38.0.0

$ModelName "weapons\cz805.mdl"

$BodyGroup "studio"
{
	studio "w_mk18_reference.smd"
}
$BodyGroup "studio1"
{
	studio "w_flipup2_reference.smd"
}

$SurfaceProp "weapon"

$Contents "solid"

$MaxEyeDeflection 90

$CDMaterials "models\roleplay_weapons\cz805\"

$Attachment "muzzle" "ATTACH_Muzzle" 0 0 0 rotate 0 0 0
$Attachment "shell" "ATTACH_Eject" 0 0 0 rotate 0 0 0

$CBox 0 0 0 0 0 0

$BBox -13.445 -4.699 -5.472 20.056 4.471 6.903

$Sequence "idle" {
	"w_mk18_anims\idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "w_mk18_physics.smd"
{
	$mass 95
	$inertia 1
	$damping 0.1
	$rotdamping 0.2
	$rootbone " "

}

$KeyValues
{
	prop_data 
	{
		"base" "Metal.Small"
	}
}
