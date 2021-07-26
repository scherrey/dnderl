%% combattables.erl

-module(combattables).

-import(lists,[any/2]). 
-import(combat,[class/0]).

-export([basetohit/3]).

-spec basetohit(combat:class(), number(), integer()) -> integer().

% From 1st edition AD&D DMG p.74-75.
clericdruidmonk0() -> { 20, 18, 16, 14, 12, 10, 9 }.
fighter0() -> { 20, 20, 18, 16, 14, 12, 10, 08, 06, 04 }.
magicuserillusionist0() -> { 20, 19, 16, 13, 11 }.
thiefassassin0() -> { 20, 19, 16, 14, 12, 10 }.
monster0() -> { 20, 20, 19, 18, 16, 15, 13, 12, 10, 9, 8, 7 }.

% For monster hitdice under 2 express Level as
% a decimal value.
%
% 0 = 0
% 0.5 = up to 1-1
% 1 = 1
% 1.5 = 1+
monster_offset(Level) ->
	if 
		Level < 0.5 -> 0;
		Level < 1 -> 1;
		Level < 1.5 -> 2;
		Level < 2 -> 3;
		true -> ((Level) div 2) + 3
	end.

basetohit(Class, Level, AC) when (Class == cleric) or (Class == druid) or (Class == monk) ->
	element( (Level+1) div 3, clericdruidmonk0() ) - AC;

basetohit(Class, Level, AC) when (Class == fighter) or (Class == paladin) or (Class == ranger) ->
	element( ((Level+1) div 2)+1, fighter0() ) - AC;

basetohit(Class, Level, AC) when (Class == thief) or (Class == assassin)  ->
	element( (Level+3) div 4, thiefassassin0() ) - AC;

basetohit(Class, Level, AC) when (Class == magicuser) or (Class == illusionist) ->
	element( (Level+4) div 5, magicuserillusionist0() ) - AC;

basetohit(Class, Level, AC) when (Class == monster) ->
	element( monster_offset(Level), monster0() ) - AC.


