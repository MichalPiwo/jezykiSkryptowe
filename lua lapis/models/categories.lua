local tablex = require 'pl.tablex'

local categories = {}

print("hello from categories lua")
print("hello from categories lua")
print("hello from categories lua")


local makeCategoriesCollection = function(names)
  	local last_id = #categories
  	local readings = tablex.map(
    	function(x)
    		last_id = last_id + 1
      		return {
	    	  id = last_id,
	    	  name = x
      		}
    	end, names )
  	return readings
end

local start_categories = {'jedzenie', 'pielegnacja'};
local categoriesCollection = makeCategoriesCollection(start_categories)

function categories.getCategories()
	categoriesCollection:printcategories()
  return categoriesCollection
end

function categoriesCollection:printcategories()
	for _, cat in pairs(categoriesCollection) do
	  -- print()
	  if type(cat) == "table" then
	  	print("id: ".. cat["id"])
	  	print("name: ".. cat["name"])
	  end
	  -- print()
	end
end

function categories.addCategory(c)
	categoriesCollection:printcategories()
	local cat_id = #categoriesCollection+1
	local cat = {id = cat_id, name = c}
    categoriesCollection[cat_id] = cat
    -- print(c)
    print("!!!!!!!!!!! after add")
    categoriesCollection:printcategories()
    print("!!!!!!!!!!!!!")
end

return categories