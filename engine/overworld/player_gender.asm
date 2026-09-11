LoadGenderedFishingGraphics::
	; load the protag's standing sheet used by the fishing animation
	ld de, RedSprite
	ld b, BANK(RedSprite)
	ld a, [wPlayerFlags]
	bit BIT_PLAYER_GIRL, a
	jr z, .gotPlayerSprite
	ld de, GreenSprite
	ld b, BANK(GreenSprite)
.gotPlayerSprite
	ld c, 12
	ld hl, vNPCSprites tile $00
	call CopyVideoData
	; load the protag specific fishing overlay
	ld hl, RedFishingTiles
	ld a, [wPlayerFlags]
	bit BIT_PLAYER_GIRL, a
	jr z, .gotFishingTiles
	ld hl, GreenFishingTiles
.gotFishingTiles
	ld a, $4
	jp LoadAnimSpriteGfx

LoadGenderedPlayerFrontPic::
	ld de, RedPicFront
	ld a, BANK(RedPicFront)
	ld hl, wPlayerFlags
	bit BIT_PLAYER_GIRL, [hl]
	jr z, .load
	ld de, GreenPicFront
	ld a, BANK(GreenPicFront)
.load
	jp UncompressSpriteFromDE


LoadGenderedPlayerBackPic::
	ld de, RedPicBack
	ld a, BANK(RedPicBack)
	ld hl, wPlayerFlags
	bit BIT_PLAYER_GIRL, [hl]
	jr z, .load
	ld de, GreenPicBack
	ld a, BANK(GreenPicBack)
.load
	jp UncompressSpriteFromDE


GreenFishingTiles:
	fishing_gfx GreenFishingTilesFront, 2, $02
	fishing_gfx GreenFishingTilesBack,  2, $06
	fishing_gfx GreenFishingTilesSide,  2, $0a
	fishing_gfx RedFishingRodTiles,     3, $fd