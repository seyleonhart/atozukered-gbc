DebugHallOfFameBoy::
	xor a
	jr DebugHallOfFameTest

DebugHallOfFameGirl::
	ld a, 1
	; fallthrough

DebugHallOfFameTest:
	; Preserve the requested protagonist gender while constructing
	; a fresh debug-game state.
	push af

	; PrepareOakSpeech deliberately preserves this bit while it
	; clears the new-game WRAM region.
	ld hl, wStatusFlags6
	set BIT_DEBUG_MODE, [hl]

	; Reproduce the useful initialization normally performed by
	; StartNewGameDebug, without actually playing the Oak intro
	; or entering Pallet Town.
	farcall PrepareOakSpeech
	predef InitPlayerData2
	farcall PrepareNewGameDebug

	; Apply the requested gender after InitPlayerData2 has reset
	; player data.
	pop af
	ld hl, wPlayerFlags
	res BIT_PLAYER_GIRL, [hl]
	and a
	jr z, .genderReady
	set BIT_PLAYER_GIRL, [hl]

.genderReady
	; Begin from a deterministic empty Hall of Fame count.
	xor a
	ld [wNumHoFTeams], a

	; This is the real Hall of Fame animation used by the game.
	call AnimateHallOfFame
	ret