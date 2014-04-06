# python3 createPlayerSQM.py offset
import json
import sys
playerSlots = open('playerSlots.json')
slots = json.loads(playerSlots.read())
playerSlots.close()


sideTemplate = """
	class Item{count}
	{{
		side="{side}";
		class Vehicles
		{{
			items={total};
			{items}
		}};
	}};
"""

slotTemplate = """			
			class Item{id}
			{{
				position[]={{{position}}};
				id={id};
				side="{side}";
				vehicle="{vehicle}";
				player="PLAY";
				skill=0.60000002;
			}};
"""

output = ""
offset = int(sys.argv[1]) if len(sys.argv) > 1 else 0

for i, side in enumerate(["WEST", "EAST", "GUER"]):
	if len(slots[side]) == 0:
		continue
		
	slotStrings = []
	for count, type in enumerate(slots[side]):
		slotStrings.append( slotTemplate.format(id = count, position = slots['position'], side = side, vehicle = type) )
	
	output += sideTemplate.format(count = i+offset, side=side, total = len(slotStrings), items="\n".join(slotStrings))
	
print(output)