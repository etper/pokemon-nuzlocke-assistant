### 1. Route status tracking (highest priority)
#
#Right now a route can only store:
#
#```json
#{
  #"caught": "Ralts",
  #"nickname": "",
  #"status": "alive"
#}
#```
#
#Missing states:
#
#* Not encountered yet
#* Encountered but failed
#* Encountered and caught
#* Encountered and killed
#* Encountered and fled
#* Static encounter
#* Gift Pokémon
#
#Without this, users can't accurately record what happened.
#
#---
#
### 2. Dupes Clause support
#
#A huge Nuzlocke feature.
#
#Example:
#
#* Route 101 → caught Zigzagoon
#* Route 102 → encounter Zigzagoon again
#* User rerolls because of Dupes Clause
#
#Current tracker has no way to mark:
#
#* duplicate encounter
#* rerolled encounter
#* species already owned
#
#---
#
### 3. Nicknames
#
#You already save a nickname field but never use it. 
#
#Current display:
#
#```
#Ralts
#Taillow
#Mudkip
#```
#
#Players usually think in:
#
#```
#Nimbus (Swellow)
#Beans (Breloom)
#MurderFish (Sharpedo)
#```
#
#Nicknames are core Nuzlocke data.
#
#---
#
### 4. Boxed Pokémon
#
#Currently:
#
#```gdscript
#team
#graveyard
#```
#
#That's it. 
#
#Missing:
#
#```gdscript
#team
#box
#graveyard
#```
#
#Most runs have 20–50 living Pokémon.
#
#Without a box, alive Pokémon disappear from tracking once removed from the team.
#
#---
#
### 5. Gym progression
#
#You store badge count but have no UI to manage it. 
#
#Would be useful:
#
#```
#☑ Roxanne
#☑ Brawly
#☐ Wattson
#☐ Flannery
#```
#
#---
#
### 6. Encounter completion overview
#
#Right now users must scroll routes.
#
#Add:
#
#```
#Encounters completed: 14/34
#Available routes: 5
#Failed routes: 3
#Deaths: 7
#```
#
#This becomes the dashboard.
#
#---
#
### 7. Support for more games
#
#Currently:
#
#```gdscript
#match game:
	#"Emerald":
#```
#
#Only Emerald exists. 
#
#For actual usefulness:
#
#* FireRed/LeafGreen
#* Platinum
#* HeartGold/SoulSilver
#* Black/White
#* Black2/White2
#
#At minimum.
#
#---
#
### 8. Route-level encounter lock
#
#Potential bug:
#
#Selecting another Pokémon on a route can overwrite the previous encounter because each route is just a group of checkboxes. 
#
#Typical Nuzlocke rule:
#
#> Once recorded, route is locked unless manually edited.
#
#You should probably require an explicit "Edit Encounter" action.
#
#---
#
### 9. Species database
#
#Current data:
#
#```gdscript
#"Route 101": [
	#"Poochyena",
	#"Zigzagoon",
	#"Wurmple"
#]
#```
#
#Very limited. 
#
#A proper tracker usually includes:
#
#* encounter rates
#* encounter methods
#* day/night
#* fishing
#* surfing
#* rock smash
#* headbutt
#* safari zones
#
#---
#
### 10. Run rules configuration
#
#At run creation:
#
#```
#Game: Emerald
#
#Rules:
#☑ Standard Nuzlocke
#☑ Dupes Clause
#☑ Shiny Clause
#☐ Species Clause
#☐ Hardcore
#☐ No Items
#```
#
#This makes runs self-documenting.
#
#---
#
### 11. Death details
#
#Current graveyard only stores Pokémon names. 
#
#Much more useful:
#
#```
#Nimbus (Swellow)
#Died to:
#Winona Altaria
#Level: 33
#Location: Fortree Gym
#```
#
#---
#
### 12. Search/filter
#
#Once a run gets large:
#
#```
#Show Alive
#Show Dead
#Show Available Routes
#Show Missed Routes
#Search Pokémon
#```
#
#becomes very valuable.
#
#---
#
#### If your goal is "minimum viable but genuinely useful"
#
#I would build these next, in order:
#
#1. Box system
#2. Nicknames
#3. Route status (caught/failed/missed)
#4. Dupes Clause
#5. Gym tracking
#6. Encounter lock/edit system
#
#Those six changes would move it from a prototype to something many Nuzlocke players could actually use.
