%% combat.erl

-module(combat).

-type class() :: cleric | druid | monk | 
				 fighter | paladin | ranger | 
				 thief | assassin | 
				 magicuser | illusionist |
				 monster.
-export_type([class/0]).

-import(combattables,[basetohit/3]).

-export([thac0/3]).

-spec thac0(class(), number(), integer()) -> integer().

% For monster hitdice under 2 express Level as
% a decimal value.
%
% 0 = 0
% 0.5 = up to 1-1
% 1 = 1
% 1.5 = 1+
thac0(Class, Level, AC) -> combattables:basetohit(Class, Level, AC).
