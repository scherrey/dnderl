%% combat.erl

-module(combat).

-type class() :: cleric | druid | monk | 
				 fighter | paladin | ranger | 
				 thief | assassin | 
				 magicuser | illusionist |
				 monster.
-export_type([class/0]).

-type armour() :: none | 
				  leather | padded | 
				  studdedleather | ringmail |
				  scalemail |
				  chainmail |
				  bandedmail |
				  platemail.
-export_type([armour/0]).

-type shield() :: none | smallshield | shield | largeshield.
-export_type([shield/0]).

-import(combattables,[basetohit/3]).

-export([thac0/3, ac/1, ac/2]).

ac(Armor) -> 
	case Armor of
		none -> 10;
		leather -> 8;
		padded -> 8;
		studdedleather -> 7;
		ringmail -> 7;
		scalemail -> 6;
		chainmail -> 5;
		bandedmail -> 4;
		platemail -> 3
	end.

ac(Armor, Shield) -> 
	ac(Armor) - 
	case Shield of
		smallshield -> 1;
		shield -> 1;
		largeshield -> 1
	end.

% For monster hitdice under 2 express Level as
% a decimal value.
%
% 0 = 0
% 0.5 = up to 1-1
% 1 = 1
% 1.5 = 1+
-spec thac0(class(), number(), integer()) -> integer().
thac0(Class, Level, AC) -> combattables:basetohit(Class, Level, AC).
