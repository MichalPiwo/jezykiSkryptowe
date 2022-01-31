local tablex = require 'pl.tablex'

local categories = {}

local makeCategoriesCollection = function(category_names)
  	local last_id = #categories
  	local readings = tablex.map(
    	function(x)
    		last_id = last_id + 1
      		return {
	    	  id = last_id,
	    	  category_name = x
      		}
    	end, category_names )
  	return readings
end

local start_categories = {'jedzenie', 'pielegnacja'};
local categoriesCollection = makeCategoriesCollection(start_categories)

function categories.getCategories(id)
	-- categoriesCollection:printcategories()
	if(id < 0) then
		return categoriesCollection
	else
		if(id <= #categoriesCollection) then
			if(categoriesCollection[id] == nil) then	
				return	nil
			else	
			    return {id, categoriesCollection[id]}
			end
		else
			return nil
		end
	end
end

function categoriesCollection:printcategories()
	for _, cat in pairs(categoriesCollection) do
	  if type(cat) == "table" then
	  	print("id: ".. cat["id"])
	  	print("category_name: ".. cat["category_name"])
	  end
	end
end

function categories.addCategory(c)
	-- categoriesCollection:printcategories()
	local cat_id = #categoriesCollection+1
	local cat = {id = cat_id, category_name = c}
    categoriesCollection[cat_id] = cat
    -- print(c)
    -- print("!!!!!!!!!!! after add")
    -- categoriesCollection:printcategories()
    -- print("!!!!!!!!!!!!!")
end


function categories.updateCategory(id, category_name)
	if(#categoriesCollection >= id and id > 0) then
		local cat = {id = id , category_name = category_name}
		categoriesCollection[id] = cat
	end
end

function categories.deleteCategory(id)
	if(#categoriesCollection >= id and id > 0) then
		categoriesCollection[id] = nil
	end
end

return categories